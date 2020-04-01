Samplers = 
{
	BaseTexture = {
		Index = 0;
		MagFilter = "Linear";
		MinFilter = "Linear";
		MipFilter = "None";
		AddressU = "Clamp";
		AddressV = "Clamp";
	},
	MaskTexture = {
		Index = 1;
		MagFilter = "Linear";
		MinFilter = "Linear";
		MipFilter = "None";
		AddressU = "Clamp";
		AddressV = "Clamp";
	}
}

AddSamplers();

Includes = {
}

BlendState =
{
	BlendEnable = true;
	AlphaTest = false;
	SourceBlend = "SRC_ALPHA";
	DestBlend = "INV_SRC_ALPHA";
}
Defines = { } -- Comma separated defines ie. "USE_SIMPLE_LIGHTS", "GUI"

DeclareShared( [[

CONSTANT_BUFFER( 0, 0 )
{
	float4x4 WorldViewProjectionMatrix; 
	float4	 FlagCoords;
	float4	 FlagSize;
};
]] )

DeclareVertex( [[
struct VS_INPUT
{
    float4 vPosition  : POSITION;
    float4 vTexCoord  : TEXCOORD0;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT
{
    float4  vPosition : POSITION;
    float4  vTexCoord : TEXCOORD0;
};
]] )

Up = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
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
	Out.vPosition  = mul(v.vPosition, WorldViewProjectionMatrix );
	Out.vTexCoord.zw = v.vTexCoord.zw;
	Out.vTexCoord.xy = v.vTexCoord.xy / FlagCoords.xy;
	Out.vTexCoord.xy -= ( v.vTexCoord.xy / FlagSize.xy );
	Out.vTexCoord.xy += FlagCoords.zw + ( 0.5f / FlagSize.xy );
	
	return Out;
}

]] )

DeclareShader( "PixelShader", [[
float4 main( VS_OUTPUT v ) : COLOR
{
 	float4 OutColor = tex2D( BaseTexture, v.vTexCoord.xy );
	float4 MaskColor = tex2D( MaskTexture, v.vTexCoord.zw );
	OutColor.a = MaskColor.a;
	
	return OutColor;
}
]] )

DeclareShader( "PixelShaderOver", [[
float4 main( VS_OUTPUT v ) : COLOR
{
 	float4 OutColor = tex2D( BaseTexture, v.vTexCoord.xy );
	float4 MaskColor = tex2D( MaskTexture, v.vTexCoord.zw );
	OutColor.a = MaskColor.a;
	OutColor.rgb += float3(0.1, 0.1, 0.1);
	return OutColor;
}
]] )

DeclareShader( "PixelShaderDown", [[
float4 main( VS_OUTPUT v ) : COLOR
{
 	float4 OutColor = tex2D( BaseTexture, v.vTexCoord.xy );
	float4 MaskColor = tex2D( MaskTexture, v.vTexCoord.zw );
	OutColor.a = MaskColor.a;
	OutColor.rgb -= float3(0.1, 0.1, 0.1);
	return OutColor;
}
]] )

DeclareShader( "PixelShaderDisable", [[
float4 main( VS_OUTPUT v ) : COLOR
{
 	float4 OutColor = tex2D( BaseTexture, v.vTexCoord.xy );
	float4 MaskColor = tex2D( MaskTexture, v.vTexCoord.zw );
	OutColor.a = MaskColor.a;
	float Grey = dot( OutColor.rgb, float3( 0.212671f, 0.715160f, 0.072169f ) ); 
    OutColor.rgb = float3(Grey, Grey, Grey);
  
	return OutColor;
}
]] )
