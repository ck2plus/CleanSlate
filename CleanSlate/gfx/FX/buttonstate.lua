Samplers = {
	MapTexture = {
		Index = 0;
		MinFilter = "Point";
		MagFilter = "Point";
		MipFilter = "None";
		AddressU = "Clamp";
		AddressV = "Clamp";
	}
}

AddSamplers()

BlendState = {
	BlendEnable = true;
	AlphaTest = false;
	SourceBlend = "src_alpha";
	DestBlend = "inv_src_alpha";
}

Includes = {
}

Defines = { }

DeclareShared( [[

CONSTANT_BUFFER( 0, 0 )
{
	float4x4 WorldViewProjectionMatrix;	
	float4 Color;
	float vXOffset;	// For textures with more than one frame
};
]] )

DeclareVertex( [[
struct VS_INPUT
{
	float3 vPosition  : POSITION;
	float2 vTexCoord  : TEXCOORD0;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT
{
	float4  vPosition : POSITION;
	float2  vTexCoord : TEXCOORD0;
};
]] )

Up = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShaderUp";
	ShaderModel = 3;
}

Down = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShaderDown";
	ShaderModel = 3;
}

Disable = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShaderDisable";
	ShaderModel = 3;
}

Over = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShaderOver";
	ShaderModel = 3;
}

DeclareShader( "VertexShader", [[

VS_OUTPUT main(const VS_INPUT v )
{
    VS_OUTPUT Out;
    Out.vPosition  = mul( float4( v.vPosition.xyz, 1 ), WorldViewProjectionMatrix );

    Out.vTexCoord  = v.vTexCoord;
	Out.vTexCoord.x += vXOffset;
    return Out;
}

]] )

DeclareShader( "PixelShaderUp", [[
	
float4 main( VS_OUTPUT v ) : COLOR
{
    float4 OutColor = tex2D( MapTexture, v.vTexCoord );
	OutColor *= Color;
	return OutColor;
}

	
]] )

DeclareShader( "PixelShaderDown", [[
	
float4 main( VS_OUTPUT v ) : COLOR
{
	float4 OutColor = tex2D( MapTexture, v.vTexCoord );
	float4 MixColor = float4( 0.1, 0.1, 0.1, 0 );
	OutColor -= MixColor;
	OutColor *= Color;
	return OutColor;
}

	
]] )

DeclareShader( "PixelShaderDisable", [[
	
float4 main( VS_OUTPUT v ) : COLOR
{
    float4 OutColor = tex2D( MapTexture, v.vTexCoord );
    float Grey = dot( OutColor.rgb, float3( 0.212671f, 0.715160f, 0.072169f ) ); 
    OutColor.rgb = float3(Grey, Grey, Grey);
	OutColor *= Color;
    return OutColor;
}	
]] )

DeclareShader( "PixelShaderOver", [[
	
float4 main( VS_OUTPUT v ) : COLOR
{
    float4 OutColor = tex2D( MapTexture, v.vTexCoord );
    float4 MixColor = float4( 0.1, 0.1, 0.1, 0 );
    OutColor += MixColor;
	OutColor *= Color;
    return OutColor;
}
]] )
