Samplers = 
{
	MainScene = {
		Index = 0;
		MagFilter = "Linear";
		MinFilter = "Linear";
		MipFilter = "None";
		AddressU = "Clamp";
		AddressV = "Clamp";
	}
}

AddSamplers()

Includes = {
	"posteffect_base.fxh",
	"standardfuncsgfx.fxh"
}

downsample = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;
}

BlendState = {
	BlendEnable = false;
	AlphaTest = false;
	WriteMask = "RED";
}

DeclareVertex( [[

struct VS_OUTPUT_DOWNSAMPLE
{
    float4 position			: POSITION;
	float2 uv				: TEXCOORD0;
};

]] )

DeclareVertex( [[

struct VS_INPUT
{
    float2 position			: POSITION;
};
]] )

DeclareShader( "VertexShader", [[

VS_OUTPUT_DOWNSAMPLE main( const VS_INPUT VertexIn )
{
	VS_OUTPUT_DOWNSAMPLE VertexOut;
	VertexOut.position = float4( VertexIn.position, 0.0f, 1.0f );
	VertexOut.uv = ( VertexIn.position + 1.0f ) * 0.5f;
	VertexOut.uv.y = 1.0f - VertexOut.uv.y;
	VertexOut.uv += vHalfPixelOffsetBloom;
	return VertexOut;
}

]] )

DeclareShader( "PixelShader", [[

float4 main( VS_OUTPUT_DOWNSAMPLE Input ) : COLOR
{
	float vRestoreSpec = 1.0f / ( 1.0f - STANDARD_HDR_RANGE );
	float color = dot( saturate( tex2D( MainScene, Input.uv ).rgb - STANDARD_HDR_RANGE ) * vRestoreSpec, float3(1.0f,1.0f,1.0f) );
	return float4(color, color, color,color);
}

]] )
