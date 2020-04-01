Samplers = 
{
	ReflectionCubeMap = {
		Index = 0;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Mirror";
		AddressV = "Mirror";
		Type = "Cube"
	},
}
AddSamplers()

Includes = {
	"standardfuncsgfx.fxh",
}


BlendState =
{
	WriteMask = "RED";
	BlendEnable = false;
	AlphaTest = false;
}
Defines = { } -- Comma separated defines ie. "USE_SIMPLE_LIGHTS", "GUI"

DeclareVertex( [[

struct VS_INPUT_SKY
{
    float2 position			: POSITION;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT_SKY
{
    float4 position	: POSITION;
	float3 pos		: TEXCOORD0;
};
]] )

sky = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;
}

DeclareShader( "VertexShader", [[

VS_OUTPUT_SKY main( const VS_INPUT_SKY VertexIn )
{
	VS_OUTPUT_SKY VertexOut;

	VertexOut.position = float4( VertexIn.position, 1.0f, 1.0f );
	float4 position = mul( VertexOut.position, InvViewProjMatrix );
	position.xyz /= position.w;
	VertexOut.pos = position.xyz;
	return VertexOut;
}
]] )

DeclareShader( "PixelShader", [[
float4 main( VS_OUTPUT_SKY Input ) : COLOR
{
	float3 color = texCUBE( ReflectionCubeMap, float3( 0.0, -1.0, 0.0 ) ).rgb;
	float3 fog = ApplyDistanceFog( color.rgb, Input.pos );

	color = lerp( fog, color, saturate( Input.pos.y / 300.0f ) );
	return float4( ComposeSpecular( color, 0.0f ), 1.0f );
}

]] )
