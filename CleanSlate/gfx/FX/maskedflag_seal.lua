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
}
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
	Out.vTexCoord.xy = v.vTexCoord.xy/FlagCoords.xy;
	Out.vTexCoord.xy += FlagCoords.zw;
	return Out;
}

]] )

DeclareShader( "PixelShader", [[
float4 main( VS_OUTPUT v ) : COLOR
{
 	float4 OutColor = tex2D( BaseTexture, v.vTexCoord.xy );
	OutColor -= tex2D( BaseTexture, v.vTexCoord.xy-0.0009)*2.7f;
	OutColor += tex2D( BaseTexture, v.vTexCoord.xy+0.0009)*2.7f;
	float vC = (( OutColor.r*0.212671+OutColor.g*0.715160+OutColor.b*0.072169)/3.0f );
	OutColor.rgb = float3(vC, vC, vC);
	OutColor.rgb *= float3( 3.0f, 1.0f, 1.0f );
	float4 MaskColor = tex2D( MaskTexture, v.vTexCoord.zw );
	OutColor.a = MaskColor.a;
	
	return OutColor;
}
]] )

DeclareShader( "PixelShaderOver", [[
float4 main( VS_OUTPUT v ) : COLOR
{
    float4 OutColor = tex2D( BaseTexture, v.vTexCoord.xy );
	OutColor -= tex2D( BaseTexture, v.vTexCoord.xy-0.0009)*2.7f;
	OutColor += tex2D( BaseTexture, v.vTexCoord.xy+0.0009)*2.7f;
	float vC = ( ( OutColor.r*0.212671+OutColor.g*0.715160+OutColor.b*0.072169)/3.0f );
	OutColor.rgb = float3(vC,vC,vC);
	vC = ( dot( OutColor.rgb, float3( 1.0f, 0.2f, 0.2f ) ) );
	OutColor = float4(vC, vC, vC, vC);
    float4 MaskColor = tex2D( MaskTexture, v.vTexCoord.zw );
    float4 MixColor = float4( 0.1, 0.1, 0.1, 0 );
    OutColor.a = MaskColor.a;
    OutColor += MixColor;
    
    return OutColor;
}
]] )

DeclareShader( "PixelShaderDown", [[
float4 main( VS_OUTPUT v ) : COLOR
{
    float4 OutColor = tex2D( BaseTexture, v.vTexCoord.xy );
	OutColor -= tex2D( BaseTexture, v.vTexCoord.xy-0.0009)*2.7f;
	OutColor += tex2D( BaseTexture, v.vTexCoord.xy+0.0009)*2.7f;
	float vC = ( ( OutColor.r*0.212671+OutColor.g*0.715160+OutColor.b*0.072169)/3.0f );
	OutColor.rgb = float3(vC, vC, vC);
	vC = ( dot( OutColor.rgb, float3( 1.0f, 0.2f, 0.2f ) ) );
	OutColor = float4(vC,vC,vC,vC);
    float4 MaskColor = tex2D( MaskTexture, v.vTexCoord.zw );
    float4 MixColor = float4( 0.1, 0.1, 0.1, 0 );
    OutColor.a = MaskColor.a;
    OutColor -= MixColor;
    
    return OutColor;
}
]] )

DeclareShader( "PixelShaderDisable", [[
float4 main( VS_OUTPUT v ) : COLOR
{
    float4 OutColor = tex2D( BaseTexture, v.vTexCoord.xy );
    float4 MaskColor = tex2D( MaskTexture, v.vTexCoord.zw );
    float Grey = dot( OutColor.rgb, float3( 0.212671f, 0.715160f, 0.072169f ) ); 
    
    OutColor.rgb = float3(Grey,Grey,Grey);
    OutColor.a = MaskColor.a;
    
    return OutColor;
}
]] )
