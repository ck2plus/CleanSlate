Samplers = 
{
	BaseTexture = {
		Index = 0;
		MagFilter = "Point";
		MinFilter = "Point";
		MipFilter = "None";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	MaskTexture = {
		Index = 1;
		MagFilter = "Point";
		MinFilter = "Point";
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
	AlphaTest = false;
	SourceBlend = "SRC_ALPHA";
	DestBlend = "INV_SRC_ALPHA";
}
Defines = { } -- Comma separated defines ie. "USE_SIMPLE_LIGHTS", "GUI"

DeclareShared( [[

CONSTANT_BUFFER( 1, 32 )
{
	float4x4 WorldViewProjectionMatrix; 
	float4	 FlagCoords;
}
]] )

DeclareVertex( [[
struct VS_INPUT
{
    float4 vPosition  : POSITION;
    float2 vTexCoord  : TEXCOORD0;
    float2 vMaskCoord  : TEXCOORD1;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT
{
    float4  vPosition : POSITION;
    float2  vTexCoord0 : TEXCOORD0;
    float2  vTexCoord1 : TEXCOORD1;
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

	Out.vTexCoord1 = v.vMaskCoord;

	Out.vTexCoord0.x = v.vTexCoord.x/FlagCoords.x;
	Out.vTexCoord0.x = Out.vTexCoord0.x + FlagCoords.z;
	Out.vTexCoord0.y = v.vTexCoord.y/FlagCoords.y;
	Out.vTexCoord0.y = Out.vTexCoord0.y + FlagCoords.w;

	return Out;
}
]] )

DeclareShader( "PixelShader", [[
float4 main( VS_OUTPUT v ) : COLOR
{
	float4 OutColor = tex2D( BaseTexture, v.vTexCoord0.xy );
	float4 MaskColor = tex2D( MaskTexture, v.vTexCoord1.xy );
	OutColor.a = MaskColor.a;
	
	return OutColor;
}
]] )

DeclareShader( "PixelShaderOver", [[
float4 main( VS_OUTPUT v ) : COLOR
{
    float4 OutColor = tex2D( BaseTexture, v.vTexCoord0.xy );
    float4 MaskColor = tex2D( MaskTexture, v.vTexCoord1.xy );
    float4 MixColor = float4( 0.1, 0.1, 0.1, 0 );
    OutColor.a = MaskColor.a;
    OutColor += MixColor;
    
    return OutColor;
}
]] )

DeclareShader( "PixelShaderDown", [[
float4 main( VS_OUTPUT v ) : COLOR
{
    float4 OutColor = tex2D( BaseTexture, v.vTexCoord0.xy );
    float4 MaskColor = tex2D( MaskTexture, v.vTexCoord1.xy );
    float Grey = dot( OutColor.rgb, float3( 0.212671f, 0.715160f, 0.072169f ) ); 
    
    OutColor.rgb = float3(Grey,Grey,Grey);
    OutColor.a = MaskColor.a;
    
    return OutColor;
}
]] )

DeclareShader( "PixelShaderDisable", [[
float4 main( VS_OUTPUT v ) : COLOR
{
    float4 OutColor = tex2D( BaseTexture, v.vTexCoord0.xy );
    float4 MaskColor = tex2D( MaskTexture, v.vTexCoord1.xy );
    float Grey = dot( OutColor.rgb, float3( 0.212671f, 0.715160f, 0.072169f ) ); 
    
    OutColor.rgb = float3(Grey,Grey,Grey);
    OutColor.a = MaskColor.a;
    
    return OutColor;
}
]] )
