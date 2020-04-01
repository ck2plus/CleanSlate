Samplers = 
{
	TextureOne = {
		Index = 0;
		MagFilter = "Linear";
		MinFilter = "Linear";
		MipFilter = "None";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	TextureTwo = {
		Index = 1;
		MagFilter = "Linear";
		MinFilter = "Linear";
		MipFilter = "None";
		AddressU = "Wrap";
		AddressV = "Wrap";
	}
}

AddSamplers()

Includes = {
}

BlendState =
{
	BlendEnable = true;
	AlphaTest = true;
	SourceBlend = "SRC_ALPHA";
	DestBlend = "INV_SRC_ALPHA";
}
Defines = { } -- Comma separated defines ie. "USE_SIMPLE_LIGHTS", "GUI"

DeclareShared( [[

CONSTANT_BUFFER( 0, 0 )
{
	float4x4 WorldViewProjectionMatrix; 
	float4 vFirstColor;
	float4 vSecondColor;
	float CurrentState;
};
]] )

DeclareVertex( [[
struct VS_INPUT
{
    float4 vPosition  : POSITION;
    float2 vTexCoord  : TEXCOORD0;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT
{
    float4  vPosition : POSITION;
    float2  vTexCoord0 : TEXCOORD0;
};

]] )

Color = {
	VertexShader = "VertexShader";
	PixelShader = "PixelColor";
	ShaderModel = 3;
}

Texture = {
	VertexShader = "VertexShader";
	PixelShader = "PixelTexture";
	ShaderModel = 3;
}

DeclareShader( "VertexShader", [[

VS_OUTPUT main(const VS_INPUT v )
{
	VS_OUTPUT Out;
   	Out.vPosition  = mul(v.vPosition, WorldViewProjectionMatrix );
	Out.vTexCoord0  = v.vTexCoord;

	return Out;
}
]] )


DeclareShader( "PixelColor", [[

float4 main( VS_OUTPUT v ) : COLOR
{
	if( v.vTexCoord0.x <= CurrentState )
		return vFirstColor;
	else
		return vSecondColor;
}
]] )


DeclareShader( "PixelTexture", [[

float4 main( VS_OUTPUT v ) : COLOR
{
	if( v.vTexCoord0.x <= CurrentState )
		return tex2D( TextureOne, v.vTexCoord0.xy );
	else
		return tex2D( TextureTwo, v.vTexCoord0.xy );
}
]] )
