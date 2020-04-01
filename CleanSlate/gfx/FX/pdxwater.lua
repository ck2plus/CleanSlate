Samplers = 
{
	HeightTexture = {
		Index = 0;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	WaterNormal = {
		Index = 1;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	ReflectionCubeMap = {
		Index = 2;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Mirror";
		AddressV = "Mirror";
		Type = "Cube";
	},
	WaterColor = {
		Index = 3;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	WaterNoise = {
		Index = 4;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	WaterRefraction = {
		Index = 5;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Clamp";
		AddressV = "Clamp";
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
	},
	ProvinceColorMap = {
		Index = 8;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Clamp";
		AddressV = "Clamp";
	},
	IceDiffuse = {
		Index = 9;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	IceNormal = {
		Index = 10;
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
	"pdxmap.fxh"
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

CONSTANT_BUFFER( 2, 48 )
{
	float3 vTime_HalfPixelOffset;
};

]] )

DeclareVertex( [[
struct VS_INPUT_WATER
{
    float2 position			: POSITION;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT_WATER
{
    float4 position			: POSITION;
	float3 pos				: TEXCOORD0;
	float2 uv				: TEXCOORD1;
	float4 screen_pos		: TEXCOORD2;
	float3 cubeRotation     : TEXCOORD3;
	float2 uv_ice			: TEXCOORD4;
};
]] )

water = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;	
}

water_color = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShaderColor";
	ShaderModel = 3;
}

DeclareShader( "VertexShader", [[
VS_OUTPUT_WATER main( const VS_INPUT_WATER VertexIn )
{
	VS_OUTPUT_WATER VertexOut;
	VertexOut.pos = float3( VertexIn.position.x, WATER_HEIGHT, VertexIn.position.y );
	VertexOut.position = mul( float4( VertexOut.pos.x, VertexOut.pos.y, VertexOut.pos.z, 1.0f ), ViewProjectionMatrix );
	VertexOut.screen_pos = VertexOut.position;
	VertexOut.screen_pos.y = FIX_FLIPPED_UV( VertexOut.screen_pos.y );
	VertexOut.uv = float2( ( VertexIn.position.x + 0.5f ) / vMapSize.x,  ( VertexIn.position.y + 0.5f - vMapSize.y ) / -vMapSize.y );
	
	VertexOut.uv_ice = VertexOut.uv * float2( MAP_SIZE_X, MAP_SIZE_Y ) * 0.1f;
	VertexOut.uv_ice *= float2( FOW_POW2_X, FOW_POW2_Y ); //POW2
	
	float vAnimTime = vTime_HalfPixelOffset.x * 0.01f;
	VertexOut.cubeRotation = normalize( float3( sin( vAnimTime ) * 0.5f, sin( vAnimTime ), cos( vAnimTime ) * 0.3f ) );
	return VertexOut;
}


]] )

DeclareShader( "PixelShader", [[
float3 CalcWaterNormal( float2 uv, float vTimeSpeed )
{
	float vScaledTime = vTime_HalfPixelOffset.x * vTimeSpeed;
	float vScaleUV = 10.0f;
	float2 time1 = vScaledTime * float2( 0.3f, 0.7f );
	float2 time2 = -vScaledTime * 0.75f * float2( 0.8f, 0.2f );
	float2 uv1 = vScaleUV * uv;
	float2 uv2 = vScaleUV * uv * 1.3;
	float noiseScale = 12.0f;
	float3 noiseNormal1 = tex2D( WaterNoise, uv1 * noiseScale + time1 * 3.0f ).rgb - 0.5f;
	float3 noiseNormal2 = tex2D( WaterNoise, uv2 * noiseScale + time2 * 3.0f ).rgb - 0.5f;
	float3 normalNoise = noiseNormal1 + noiseNormal2 + float3( 0.0f, 0.0f, 1.5f );
	return normalize( /*normalWaves +*/ normalNoise ).xzy;
}
float4 ApplyIce( float4 vColor, float2 vPos, inout float3 vNormal, float4 vFoWColor, float2 vIceUV, out float vIceFade )
{
	float vSnow = saturate( GetSnow(vFoWColor) - 0.2f ); 
	vIceFade = vSnow*8.0f;
	float vIceNoise = tex2D( FoWDiffuse, ( vPos + 0.5f ) / 64.0f  ).r;
	vIceFade *= vIceNoise;
	float vMapLimitFade = saturate( saturate( (vPos.y/MAP_SIZE_Y) - 0.74f )*800.0f );
	vIceFade *= vMapLimitFade;
	vIceFade = saturate( ( vIceFade-0.5f ) * 10.0f );
	vNormal = lerp( vNormal, tex2D( IceNormal, vIceUV ).rgb, vIceFade );

	float4 vIceColor = tex2D( IceDiffuse, vIceUV );
	vColor = lerp( vColor, vIceColor, saturate(vIceFade) );

	return vColor;
}
float4 main( VS_OUTPUT_WATER Input ) : COLOR
{
	float3 normal = CalcWaterNormal( Input.uv, vTimeScale * 12.0f );
	
	//Ice effect
	float4 waterColor = tex2D( WaterColor, Input.uv * vMapSize.zw );
	float4 vFoWColor = GetFoWColor( Input.pos, FoWTexture);
	float vIceFade = 0.0f;
	waterColor = ApplyIce( waterColor, Input.pos.xz, normal, vFoWColor, Input.uv_ice, vIceFade );
	
	float3 vEyeDir = normalize( Input.pos - vCamPos.xyz );
	float3 normalReflection = normal;
	float3 reflection = reflect( vEyeDir, normalReflection );
	float3 reflectiveColor = texCUBE( ReflectionCubeMap, reflection ).rgb;
	float2 refractiveUV = ( Input.screen_pos.xy / Input.screen_pos.w ) * 0.5f + 0.5f;
	refractiveUV.y = 1.0f - refractiveUV.y;
	refractiveUV += vTime_HalfPixelOffset.gb;
	float vRefractionScale = saturate( 5.0f - ( Input.screen_pos.z / Input.screen_pos.w ) * 5.0f );
	float3 refractiveColor = tex2D( WaterRefraction, (refractiveUV.xy - normal.xz * vRefractionScale * 0.2f) ).rgb;
	float waterHeight = tex2D( HeightTexture, Input.uv * vMapSize.zw ).x;

	waterHeight /= ( 93.7f / 255.0f );
	waterHeight = saturate( ( waterHeight - 0.995f ) * 50.0f );

	float fresnelBias = 0.2f;
	float fresnel = saturate( dot( -vEyeDir, normal ) ) * 0.5f;
	fresnel = saturate( fresnelBias + ( 1.0f - fresnelBias ) * pow( 1.0f - fresnel, 10.0f ) );
	fresnel *= (1.0f-vIceFade); //No fresnel when we have snow

	float3 H = normalize( -vLightDir + -vEyeDir );

	float vSpecWidth = vMapSize.x*0.9f;
	
	float vSpecMultiplier = 3.0f;
	float specular = saturate( pow( saturate( dot( H, normal ) ), vSpecWidth ) * vSpecMultiplier );

	refractiveColor = lerp( refractiveColor, waterColor.rgb, 0.3f+(0.7f*vIceFade) );
	float3 outColor = refractiveColor * ( 1.0f - fresnel ) + reflectiveColor * fresnel;

	float vFoW = GetFoW( Input.pos, FoWTexture, FoWDiffuse );
	outColor = ApplyDistanceFog( outColor, Input.pos ) * vFoW;

	return float4( ComposeSpecular( outColor, specular * vFoW ), 1.0f - waterHeight );
}

]] )

DeclareShader( "PixelShaderColor", [[
float3 CalcWaterNormal( float2 uv, float vTimeSpeed )
{
	float vScaledTime = vTime_HalfPixelOffset.x * vTimeSpeed;
	float vScaleUV = 10.0f;
	float2 time1 = vScaledTime * float2( 0.3f, 0.7f );
	float2 time2 = -vScaledTime * 0.75f * float2( 0.8f, 0.2f );
	float2 uv1 = vScaleUV * uv;
	float2 uv2 = vScaleUV * uv * 1.3;
	float noiseScale = 12.0f;
	float3 noiseNormal1 = tex2D( WaterNoise, uv1 * noiseScale + time1 * 3.0f ).rgb - 0.5f;
	float3 noiseNormal2 = tex2D( WaterNoise, uv2 * noiseScale + time2 * 3.0f ).rgb - 0.5f;
	float3 normalNoise = noiseNormal1 + noiseNormal2 + float3( 0.0f, 0.0f, 1.5f );
	return normalize( /*normalWaves +*/ normalNoise ).xzy;
}
float4 main( VS_OUTPUT_WATER Input ) : COLOR
{
	float3 normal = CalcWaterNormal( Input.uv, vTimeScale * 12.0f );
	float3 vEyeDir = normalize( Input.pos - vCamPos.xyz );
	float3 normalReflection = normal;
	float3 reflection = reflect( vEyeDir, normalReflection );
	float3 reflectiveColor = texCUBE( ReflectionCubeMap, reflection ).rgb;
	float2 refractiveUV = ( Input.screen_pos.xy / Input.screen_pos.w ) * 0.5f + 0.5f;
	refractiveUV.y = 1.0f - refractiveUV.y;
	refractiveUV += vTime_HalfPixelOffset.gb;
	float vRefractionScale = saturate( 5.0f - ( Input.screen_pos.z / Input.screen_pos.w ) * 5.0f );
	float3 refractiveColor = tex2D( WaterRefraction, (refractiveUV.xy - normal.xz * vRefractionScale * 0.2f) ).rgb;
	
	float2 ColorMapUV = Input.uv;
	ColorMapUV.y = 1.0f - ColorMapUV.y;
	float4 ColormapColor = tex2D( ProvinceColorMap, ColorMapUV.xy );
	
	float4 waterColor = tex2D( WaterColor, Input.uv * vMapSize.zw );
	float waterHeight = tex2D( HeightTexture, Input.uv * vMapSize.zw ).x;

	waterHeight /= ( 93.7f / 255.0f );
	waterHeight = saturate( ( waterHeight - 0.995f ) * 50.0f );

	float fresnelBias = 0.2f;
	float fresnel = saturate( dot( -vEyeDir, normal ) ) * 0.5f;
	fresnel = saturate( fresnelBias + ( 1.0f - fresnelBias ) * pow( 1.0f - fresnel, 10.0f ) );

	float3 H = normalize( -vLightDir + -vEyeDir );

	float vSpecWidth = vMapSize.x*0.9f;
	
	float vSpecMultiplier = 3.0f;
	float specular = saturate( pow( saturate( dot( H, normal ) ), vSpecWidth ) * vSpecMultiplier );

	float2 vBlend = float2( 0.65f, 0.35f );
	
	refractiveColor = lerp( refractiveColor, waterColor.rgb, 0.3f );
	float3 outColor = refractiveColor * ( 1.0f - fresnel ) + reflectiveColor * fresnel;
	
	outColor = outColor * vBlend.x + ColormapColor.rgb * vBlend.y;
 
	float vFoW = GetFoW( Input.pos, FoWTexture, FoWDiffuse );
	outColor = ApplyDistanceFog( outColor, Input.pos ) * vFoW;

	return float4( ComposeSpecular( outColor, specular * vFoW ), 1.0f - waterHeight );
}

]] )