
Includes = {
	"standardfuncs.fxh"
}

Defines = { } -- Comma separated defines ie. "USE_SIMPLE_LIGHTS", "GUI"

DeclareShader( "Shared", [[

float4x4 Matrix			: register( c0 );

struct VS_INPUT
{
    float2 vPosition  : POSITION;
 	float4 vColor	  : COLOR;
};

struct VS_OUTPUT
{
    float4  vPosition : POSITION;
	float4  vColor	  : TEXCOORD1;
};

]] )

Color = {
	VertexShader = "VertexColor";
	PixelShader = "PixelColor";
	ShaderModel = 3;
}

DeclareShader( "VertexColor", [[
VS_OUTPUT main(const VS_INPUT v )
{
    VS_OUTPUT Out 	= (VS_OUTPUT)0;
	float4 vPosition = float4( v.vPosition.x, 0, v.vPosition.y, 1 );
    Out.vPosition  	= mul( vPosition, Matrix );	
	Out.vColor		= v.vColor;
    return Out;
}

]] )

DeclareShader( "PixelColor", [[
float4 main( VS_OUTPUT v ) : COLOR
{
    return v.vColor;
}
]] )
