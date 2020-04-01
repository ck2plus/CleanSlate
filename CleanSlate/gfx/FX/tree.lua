Samplers = 
{
	DiffuseMap = {
		Index = 0;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
		MipMapLodBias = -1;
	},
	NormalMap = {
		Index = 1;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
		MipMapLodBias = -1;
	},
	TintMap = {
		Index = 2;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	SeasonMap = {
		Index = 3;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},	
	ColorMap = {
		Index = 4;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	ColorMapSecond = {
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
	"constants.fxh"
}


BlendState =
{
	WriteMask = "RED|GREEN|BLUE";
	BlendEnable = false;
	AlphaTest = false;
}
Defines = { } -- Comma separated defines ie. "USE_SIMPLE_LIGHTS", "GUI"


DeclareShared( [[
CONSTANT_BUFFER( 1, 32 )
{
	float2 vSeasonLerp;
}
]] )

DeclareVertex( [[
struct VS_INPUT_INSTANCE
{
    float4 vPosition   : POSITION;
    float3 vNormal     : NORMAL;
	float4 vTangent    : TANGENT;
	float2 vTexCoord0  : TEXCOORD0;
	float2 vTexCoord1  : TEXCOORD1;
	float4 vPos_YRot   : TEXCOORD2;
	float2 vSlopes     : TEXCOORD3;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT
{
    float4 vPosition          : POSITION;
	float4 vTexCoord0_TintUV  : TEXCOORD0;
	float3 _vLightDir         : TEXCOORD1;
	float3 vPos				  : TEXCOORD2;
	float4 vScreenCoord		  : TEXCOORD3;
	float  vSeasonColumn	  : TEXCOORD4;
};
]] )

tree = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;
}

DeclareShader( "VertexShader", [[
VS_OUTPUT main( const VS_INPUT_INSTANCE v )
{
	VS_OUTPUT Out;

	float vRandom = v.vPos_YRot.w / 6.28318531f;
	float vSummedRandom = v.vTexCoord1.x + vRandom;
	vSummedRandom = vSummedRandom >= 1.0f ? vSummedRandom - 1.0f : vSummedRandom;
	
	float vHeightScaleFactor = 0.75f + vSummedRandom * 0.5f;
	Out.vPosition = float4( v.vPosition.xyz, 1.0 );
	Out.vPosition.y *= vHeightScaleFactor;

	float randSin = sin( v.vPos_YRot.w );
	float randCos = cos( v.vPos_YRot.w );

	Out.vPosition.xz = float2( 
		Out.vPosition.x * randCos - Out.vPosition.z * randSin, 
		Out.vPosition.x * randSin + Out.vPosition.z * randCos );

	Out.vPosition.y += Out.vPosition.x * v.vSlopes.x + Out.vPosition.z * v.vSlopes.y;
	Out.vPosition.xyz += v.vPos_YRot.xyz;
	
	Out.vPos = Out.vPosition.xyz;

	Out.vPosition = mul( Out.vPosition, ViewProjectionMatrix );
	
	Out.vTexCoord0_TintUV.xy = v.vTexCoord0;

	float3 vNormal = v.vNormal;
	vNormal.xz = float2( 
		vNormal.x * randCos - vNormal.z * randSin, 
		vNormal.x * randSin + vNormal.z * randCos );
	
	float3 vTangent = v.vTangent.xyz;
	vTangent.xz = float2( 
		vTangent.x * randCos - vTangent.z * randSin, 
		vTangent.x * randSin + vTangent.z * randCos );

	float3 vBitangent = cross( vTangent, vNormal ) * v.vTangent.w;
	
	float3x3 matTBN = float3x3( vTangent, vBitangent, vNormal );
	Out._vLightDir = mul( matTBN, vLightDir );

	Out.vTexCoord0_TintUV.zw = float2( vRandom, 0.0f ) + v.vTexCoord1;
	
	// Output the screen-space texture coordinates
	Out.vScreenCoord.x = ( Out.vPosition.x * 0.5 + Out.vPosition.w * 0.5 );
	Out.vScreenCoord.y = ( Out.vPosition.w * 0.5 - Out.vPosition.y * 0.5 );
#ifdef PDX_OPENGL
	Out.vScreenCoord.y = -Out.vScreenCoord.y;
#endif			
	Out.vScreenCoord.z = Out.vPosition.w;
	Out.vScreenCoord.w = Out.vPosition.w;
	
	Out.vSeasonColumn = vSeasonLerp.y/8.0f;
	Out.vSeasonColumn += 1.0f/16.0f;
	
	return Out;
}
]] )

DeclareShader( "PixelShader", [[

float3 ApplySnowTree( float3 vColor, float3 vPos, float4 vFoWColor, in sampler2D FoWDiffuse )
{
	float vIsSnow = GetSnow( vFoWColor );
	float vPattern = tex2D(FoWDiffuse, float2(vPos.x, vPos.z)).a + 0.9;
	vColor = GetOverlay( vColor, SNOW_COLOR, min(vIsSnow * vPattern, 0.9) );	
	return vColor;
}

float4 main( VS_OUTPUT In ) : COLOR
{
	float3 vColor = GetOverlay( tex2D( DiffuseMap, In.vTexCoord0_TintUV.xy ).rgb, tex2D( TintMap, In.vTexCoord0_TintUV.zw ).rgb, 0.5f );
	float3 vNormal = tex2D( NormalMap, In.vTexCoord0_TintUV.xy ).rgb - 0.5f;
	
	// Seasons
	float2 uv = float2( ( ( In.vPos.x+0.5f ) / vMapSize.x ), ( ( In.vPos.z+0.5f-vMapSize.y ) / -vMapSize.y ) ); 
	vColor = GetOverlay( vColor, tex2D(ColorMap, uv).rgb, 0.25f );
	float3 vSeasonColorMap = lerp( tex2D(ColorMap, uv), tex2D(ColorMapSecond, uv), vSeasonLerp.x ).rgb;
	vColor = GetOverlay( vColor, vSeasonColorMap, 0.25f );
	float vSeasonTreeFade = saturate( saturate( (In.vPos.z/MAP_SIZE_Y) - TREE_SEASON_MIN )*TREE_SEASON_FADE_TWEAK );
	vColor += ( tex2D( SeasonMap, float2( In.vSeasonColumn, In.vTexCoord0_TintUV.w ) ).rgb-0.5f ) * vSeasonTreeFade;
	
	// Snow
	float4 vFoWColor = GetFoWColor( In.vPos, FoWTexture );
	vColor = ApplySnowTree( vColor, In.vPos, vFoWColor, FoWDiffuse );
	
	vColor = CalculateLighting( vColor, normalize( vNormal ), normalize( In._vLightDir ) );
	vColor = ApplyDistanceFog( vColor, In.vPos, FoWTexture, FoWDiffuse );
	
	return float4( ComposeSpecular( vColor, 0.0f ), 1.0f );
}

]] )
