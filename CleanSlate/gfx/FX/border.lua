Samplers = 
{
	BorderDiffuse = {
		Index = 0;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Clamp";
	},
	BorderData = {
		Index = 1;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Clamp";
	},
	BorderCornerDiffuse = {
		Index = 2;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Clamp";
	},
	BorderCornerData = {
		Index = 3;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Clamp";
	},
	
	WaterFoamDiffuse = {
		Index = 4;
		MagFilter = "Linear";
		MinFilter = "Linear";
		MipFilter = "Linear";
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
	},

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
	SourceBlend = "src_alpha";
	DestBlend = "inv_src_alpha";
	AlphaTest = false;
}

Defines = { } -- Comma separated defines ie. "USE_SIMPLE_LIGHTS", "GUI"

DeclareShared( [[

CONSTANT_BUFFER( 2, 48 )
{
	float4 vColorTint[6];
	float4 vSelectionColor;
	float  vTime;
}
]] )

DeclareVertex( [[
struct VS_INPUT_BORDER
{
    float3 position			: POSITION;
	float4 uv				: TEXCOORD0;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT_BORDER
{
    float4 position			: POSITION;
	float3 pos				: TEXCOORD0;
	float4 uv				: TEXCOORD1;
};
]] )

border = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;
}

WaterFoam = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShaderWaterFoam";
	ShaderModel = 3;
}

DeclareShader( "VertexShader", [[
VS_OUTPUT_BORDER main( const VS_INPUT_BORDER VertexIn )
{
	VS_OUTPUT_BORDER VertexOut;

	float4 pos = float4( VertexIn.position, 1.0f );

	float vClampHeight = saturate( ( WATER_HEIGHT - VertexIn.position.y ) * 10000 );

	pos.y = vClampHeight * WATER_HEIGHT + ( 1.0f - vClampHeight ) * pos.y;
	VertexOut.pos = pos.xyz;

	float4 vDistortedPos = pos - float4( vCamLookAtDir * 0.05f, 0.0f );
	pos = mul( pos, ViewProjectionMatrix );
	
	// move z value slightly closer to camera to avoid intersections with terrain
	float vNewZ = dot( vDistortedPos, float4( GetMatrixData( ViewProjectionMatrix, 0, 2 ), GetMatrixData( ViewProjectionMatrix, 1, 2 ), GetMatrixData( ViewProjectionMatrix, 2, 2 ), GetMatrixData( ViewProjectionMatrix, 3, 2 ) ) );
	VertexOut.position = float4( pos.xy, vNewZ, pos.w );

	VertexOut.uv = VertexIn.uv;
	return VertexOut;
}

]] )

DeclareShader( "PixelShader", [[

float4 main( VS_OUTPUT_BORDER Input ) : COLOR
{
	float4 vColor = tex2D( BorderDiffuse, float2( Input.uv.y * 0.1f, Input.uv.x ) );
	float4 vData = tex2D( BorderData, float2( Input.uv.y * 0.1f, Input.uv.x ) );

	vColor.rgb += lerp( 
		vData.r * vColorTint[0] + vData.g * vColorTint[1] + vData.b * vColorTint[2], 
		vData.r * vColorTint[3] + vData.g * vColorTint[4] + vData.b * vColorTint[5], vData.a ).rgb;

	vColor.a *= lerp( vColorTint[0].a, vColorTint[3].a, vData.a );
	
	float vPulseFactor = saturate( smoothstep( 0.0f, 1.0f, ( 0.8f - abs( Input.uv.x - 0.5f ) ) + sin( vTime * 2.5f ) * 0.15f ) ) * vSelectionColor.a; 

	vColor.rgb = saturate( vColor.rgb + vSelectionColor.rgb * saturate( vPulseFactor - vColor.a * 0.35f ) );
	vColor.rgb = ApplyDistanceFog( vColor.rgb, Input.pos ) * max( GetFoW( Input.pos, FoWTexture, FoWDiffuse ), vPulseFactor );
	
	return float4( ComposeSpecular( vColor.rgb, 0.0f ), max( vColor.a, vPulseFactor - 0.2f ) );
}
]] )

DeclareShader( "PixelShaderWaterFoam", [[

float4 main( VS_OUTPUT_BORDER Input ) : COLOR
{
  return float4( 1.0f, 1.0f, 1.0f, 1.0f );
}
]] )