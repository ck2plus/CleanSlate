Samplers = 
{
	DiffuseMap = {
		Index = 0;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Clamp";
	},
	NormalMap = {
		Index = 1;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Clamp";
	},
	DiffuseBottomMap = {
		Index = 2;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Clamp";
	},
	SurfaceNormalMap = {
		Index = 3;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	ColorOverlay = {
		Index = 4;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	HeightNormal = {
		Index = 5;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	FoWTexture = {
		Index = 6;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	FoWDiffuse = {
		Index = 7;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	}
}
AddSamplers()

Includes = {
	"standardfuncsgfx.fxh",
}


BlendState =
{
	WriteMask = "RED|GREEN|BLUE";
	BlendEnable = true;
	AlphaTest = false;
	SourceBlend = "src_alpha";
	DestBlend = "inv_src_alpha";
}

Defines = { } -- Comma separated defines ie. "USE_SIMPLE_LIGHTS", "GUI"

DeclareShared( [[
CONSTANT_BUFFER( 1, 32 )
{
	float2 vTimeDirection;
}
]] )

DeclareVertex ( [[
struct VS_INPUT
{
    float4 vPosition   : POSITION;
	float4 vUV_Tangent : TEXCOORD0;
};
]] )

DeclareVertex ( [[
struct VS_OUTPUT
{
    float4 vPosition	    : POSITION;
	float4 vUV			    : TEXCOORD0;
	float4 vWorldUV_Tangent	: TEXCOORD1;
	float4 vPrePos_Fade		: TEXCOORD2;
	float2 vSecondaryUV		: TEXCOORD3;
};
]] )

river = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;
}

DeclareShader( "VertexShader", [[
VS_OUTPUT main( const VS_INPUT v )
{
	VS_OUTPUT Out;

	Out.vPosition = float4( v.vPosition.xyz, 1.0f );

	float4 vTmpPos = float4( v.vPosition.xyz, 1.0f );
	Out.vPrePos_Fade.xyz = vTmpPos.xyz;

	float4 vDistortedPos = vTmpPos - float4( vCamLookAtDir * 0.05f, 0.0f );

	vTmpPos = mul( vTmpPos, ViewProjectionMatrix );
	
	// move z value slightly closer to camera to avoid intersections with terrain
	float vNewZ = dot( vDistortedPos, float4( GetMatrixData( ViewProjectionMatrix, 0, 2 ), GetMatrixData( ViewProjectionMatrix, 1, 2 ), GetMatrixData( ViewProjectionMatrix, 2, 2 ), GetMatrixData( ViewProjectionMatrix, 3, 2 ) ) );
	Out.vPosition = float4( vTmpPos.xy, vNewZ, vTmpPos.w );
	
	Out.vUV.yx = v.vUV_Tangent.xy;
	Out.vUV.x += vTimeDirection.x * 1.0f * vTimeDirection.y;
	Out.vUV.y += vTimeDirection.x * 0.2f;
	Out.vUV.x *= 0.05f;

	Out.vSecondaryUV.yx = v.vUV_Tangent.xy;
	Out.vSecondaryUV.x += vTimeDirection.x * 0.9f * vTimeDirection.y;
	Out.vSecondaryUV.y -= vTimeDirection.x * 0.1f;
	Out.vSecondaryUV.x *= 0.05f;

	Out.vUV.wz = v.vUV_Tangent.xy;
	Out.vUV.z *= 0.05f;

	Out.vWorldUV_Tangent.x = (  v.vPosition.x + 0.5f ) / vMapSize.x;
	Out.vWorldUV_Tangent.y = (  v.vPosition.z + 0.5f - vMapSize.y ) / -vMapSize.y;
	Out.vWorldUV_Tangent.zw = v.vUV_Tangent.zw;
	Out.vPrePos_Fade.w = saturate( 1.0f - v.vUV_Tangent.y );

	return Out;
}
]] )

DeclareShader( "PixelShader", [[
float4 main( VS_OUTPUT In ) : COLOR
{
	float4 vWaterSurface = tex2D( DiffuseMap, float2( In.vUV.x, In.vUV.w ) );

	float3 vHeightNormal = normalize( tex2D( HeightNormal, In.vWorldUV_Tangent.xy * vMapSize.zw ).rbg - 0.5f );

	float3 vSurfaceNormal1 = normalize( tex2D( SurfaceNormalMap, In.vUV.xy ).rgb - 0.5f );
	float3 vSurfaceNormal2 = normalize( tex2D( SurfaceNormalMap, In.vSecondaryUV ).rgb - 0.5f );

	float3 vSurfaceNormal = normalize( vSurfaceNormal1 + vSurfaceNormal2 );

	vSurfaceNormal.xzy = float3( vSurfaceNormal.x * In.vWorldUV_Tangent.zw + vSurfaceNormal.y * float2( -In.vWorldUV_Tangent.w, In.vWorldUV_Tangent.z ), vSurfaceNormal.z );
	vSurfaceNormal =
		  vHeightNormal.yxz * vSurfaceNormal.x
		+ vHeightNormal.xyz * vSurfaceNormal.y
		+ vHeightNormal.xzy * vSurfaceNormal.z;

	float3 vEyeDir = normalize( In.vPrePos_Fade.xyz - vCamPos );
	float3 H = normalize( -vLightDir + -vEyeDir );

	float vSpecRemove = 1.0f - abs( 0.5f - In.vUV.w ) * 2.0f;

	float vSpecWidth = 70.0f;
	float vSpecMultiplier = 0.25f;
	float specular = saturate( pow( saturate( dot( H, vSurfaceNormal ) ), vSpecWidth ) * vSpecMultiplier ) * vSpecRemove/*  dot( vWaterSurface, vWaterSurface )*/;

	float2 vDistort = refract( vCamLookAtDir, vSurfaceNormal, 0.66f ).xz;

	vDistort = vDistort.x * In.vWorldUV_Tangent.zw + vDistort.y * float2( -In.vWorldUV_Tangent.w, In.vWorldUV_Tangent.z );

	float3 vBottom = tex2D( DiffuseBottomMap, In.vUV.zw + vDistort * 0.05f ).rgb;
	float  vBottomAlpha = tex2D( DiffuseBottomMap, In.vUV.zw ).a;

	vBottom = GetOverlay( vBottom, tex2D( ColorOverlay, In.vWorldUV_Tangent.xy ).rgb, 0.5f );

	float3 vBottomNormal = normalize( tex2D( NormalMap, In.vUV.zw ).rgb - 0.5f );
	vBottomNormal.xzy = float3( vBottomNormal.x * In.vWorldUV_Tangent.zw + vBottomNormal.y * float2( -In.vWorldUV_Tangent.w, In.vWorldUV_Tangent.z ), vBottomNormal.z );
	vBottomNormal = 
		  vHeightNormal.yxz * vBottomNormal.x
		+ vHeightNormal.xyz * vBottomNormal.y
		+ vHeightNormal.xzy * vBottomNormal.z;

	float3 vColor = lerp( vBottom, vWaterSurface.xyz, vWaterSurface.a * 0.8f );
	float4 vFoWColor = GetFoWColor( In.vPrePos_Fade.xyz, FoWTexture);
	vColor = ApplyWaterSnow( vColor, In.vPrePos_Fade.xyz, vSurfaceNormal, vFoWColor, FoWDiffuse );
	vColor = CalculateLighting( vColor, vBottomNormal );
	float vFoW = GetFoW( In.vPrePos_Fade.xyz, FoWTexture, FoWDiffuse );
	vColor = ApplyDistanceFog( vColor, In.vPrePos_Fade.xyz ) * vFoW;
	return float4( ComposeSpecular( vColor, specular * ( 1.0f - In.vPrePos_Fade.w ) * vWaterSurface.a * vFoW ), vBottomAlpha * ( 1.0f - In.vPrePos_Fade.w ) );
}

]] )
