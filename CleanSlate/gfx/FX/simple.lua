Samplers = 
{
	SimpleTexture = {
		Index = 0;
		MagFilter = "Linear";
		MinFilter = "Linear";
		MipFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	}
}
AddSamplers()

Includes = {
--	"standardfuncsgfx.fxh"
}

BlendState =
{
	BlendEnable = true;
	AlphaTest = false;
	SourceBlend = "SRC_ALPHA";
	DestBlend = "INV_SRC_ALPHA";
}
Defines = { } -- Comma separated defines ie. "USE_SIMPLE_LIGHTS", "GUI"

DeclareVertex( [[
struct VS_INPUT
{
    float4 vPosition  : POSITION;
    float2 vTexCoord  : TEXCOORD0;
	float4 vColor	  : COLOR;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT
{
    float4  vPosition : POSITION;
    float2  vTexCoord : TEXCOORD0;
	float4  vColor	  : TEXCOORD1;
};
]] )

DeclareShared( [[
CONSTANT_BUFFER( 0, 0 )
{
	float4x4 Matrix;//			: register( c0 );
};

/*
	In glsl:
	
	uniform float4 UNIFORM0[ 4 ];
	#define Matrix mat4( UNIFORM[0], UNIFORM[1], UNIFORM[2], UNIFORM[3] )
	
	In hlsl
	
	float4x4 Matrix : register( c0 );
*/

]] )

Simple = {
	VertexShader = "VertexShaderSimple";
	PixelShader = "PixelShaderSimple";
	ShaderModel = 3;
}

DeclareShader( "VertexShaderSimple", [[
VS_OUTPUT main(const VS_INPUT v )
{
    VS_OUTPUT Out;
    Out.vPosition  	= mul( v.vPosition, Matrix );
	
    Out.vTexCoord  	= v.vTexCoord;
	
	Out.vColor		= v.vColor;

    return Out;
}

]] )

DeclareShader( "PixelShaderSimple", [[
float4 main( VS_OUTPUT v ) : COLOR
{
    float4 OutColor = tex2D( SimpleTexture, v.vTexCoord );
	OutColor = OutColor * v.vColor;
    return OutColor;
}
]] )
