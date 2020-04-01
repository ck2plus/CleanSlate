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
		MagFilter = "Point";
		MinFilter = "Point";
		MipFilter = "None";
		AddressU = "Clamp";
		AddressV = "Clamp";
	},
	EmblemTexture = {
		Index = 2;
		MagFilter = "Linear";
		MinFilter = "Linear";
		MipFilter = "Linear";
		AddressU = "Clamp";
		AddressV = "Clamp";
	},
	SealMaskTexture = {
		Index = 3;
		MagFilter = "Point";
		MinFilter = "Point";
		MipFilter = "None";
		AddressU = "Clamp";
		AddressV = "Clamp";
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

CONSTANT_BUFFER( 0, 0 )
{
float4x4 WorldViewProjectionMatrix	; 
float4	 FlagCoords					;
float4	 EmblemTemplateCoords		;
float4	 EmblemCoords				;
float4	Color1						;
float4	Color2						;
float4	Color3						;
float2	Over_Alpha					;
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
	float2  vTexCoord2 : TEXCOORD2;
};

]] )

DeclareVertex( [[
struct VS_OUTPUT_FRAME
{
    float4  vPosition : POSITION;
    float2  vTexCoord0 : TEXCOORD0;
};

]] )

Standard = {
	VertexShader = "GeneralVertexShader";
	PixelShader = "GeneralPixelShader";
	ShaderModel = 3;
}
Color = {
	VertexShader = "GeneralVertexShader";
	PixelShader = "GeneralPixelShaderColor";
	ShaderModel = 3;
}
Seal = {
	VertexShader = "GeneralVertexShader";
	PixelShader = "GeneralPixelShaderColorSeal";
	ShaderModel = 3;
}
Frame = {
	VertexShader = "GeneralVertexShaderFrame";
	PixelShader = "GeneralPixelShaderFrame";
	ShaderModel = 3;
}

DeclareShader( "GeneralVertexShader", [[
VS_OUTPUT main(const VS_INPUT v )
{
	VS_OUTPUT Out;

	Out.vPosition  = mul(v.vPosition, WorldViewProjectionMatrix );

	Out.vTexCoord1 = v.vMaskCoord;

	Out.vTexCoord0.x = v.vTexCoord.x / FlagCoords.x + FlagCoords.z;
	Out.vTexCoord0.y = v.vTexCoord.y / FlagCoords.y + FlagCoords.w;
	
	Out.vTexCoord2.x = (v.vTexCoord.x - EmblemTemplateCoords.x) / (EmblemTemplateCoords.z * EmblemCoords.y) + EmblemCoords.x / EmblemCoords.y;
	Out.vTexCoord2.y = (v.vTexCoord.y - EmblemTemplateCoords.y) / (EmblemTemplateCoords.w * EmblemCoords.w) + EmblemCoords.z / EmblemCoords.w ;
	
	return Out;
}

]] )

DeclareShader( "GeneralVertexShaderFrame", [[
VS_OUTPUT_FRAME main(const VS_INPUT v )
{
	VS_OUTPUT_FRAME Out;

	Out.vPosition  = mul(v.vPosition, WorldViewProjectionMatrix );
	Out.vTexCoord0 = v.vTexCoord;
	return Out;
}
]] )

DeclareShader( "GeneralPixelShader", [[
float4 main( VS_OUTPUT v ) : COLOR
{
	float4 OutColor = tex2D( BaseTexture, v.vTexCoord0.xy );
	float4 EmblemColor = tex2D( EmblemTexture, v.vTexCoord2.xy );
	float MaskColor = tex2D( MaskTexture, v.vTexCoord1.xy ).r;
	OutColor = lerp( OutColor, EmblemColor, EmblemColor.a );
	OutColor.a = MaskColor * Over_Alpha.y;

	return OutColor;
}

]] )

DeclareShader( "GeneralPixelShaderColor", [[
float4 main( VS_OUTPUT v ) : COLOR
{
	float2 vEmb = v.vTexCoord2.xy;
	vEmb.x = clamp(v.vTexCoord2.x, EmblemCoords.x / EmblemCoords.y, (EmblemCoords.x + 1) / EmblemCoords.y );
	//vEmb.y = clamp(v.vTexCoord2.y, EmblemCoords.z / EmblemCoords.w, (EmblemCoords.z + 1) / EmblemCoords.w );
	
	float4 OutColor = tex2D( BaseTexture, v.vTexCoord0.xy );
	float4 EmblemColor = tex2D( EmblemTexture, vEmb );
	float MaskColor = tex2D( MaskTexture, v.vTexCoord1.xy ).r;
	OutColor = OutColor.r * Color1 + OutColor.g * Color2 + OutColor.b * Color3;
	OutColor = lerp( OutColor, EmblemColor, EmblemColor.a );
	
	OutColor.a = MaskColor * Over_Alpha.y;
	OutColor += Over_Alpha.x * float4( 0.1, 0.1, 0.1, 0.0 );

	return OutColor;
}
]] )

DeclareShader( "GeneralPixelShaderColorSeal", [[
float4 main( VS_OUTPUT v ) : COLOR
{
	float2 vEmb = v.vTexCoord2.xy;
	vEmb.x = clamp(v.vTexCoord2.x, EmblemCoords.x / EmblemCoords.y, (EmblemCoords.x + 1) / EmblemCoords.y );
	//vEmb.y = clamp(v.vTexCoord2.y, EmblemCoords.z / EmblemCoords.w, (EmblemCoords.z + 1) / EmblemCoords.w );
	
	float4 OutColor = tex2D( BaseTexture, v.vTexCoord0.xy );
	float4 EmblemColor = tex2D( EmblemTexture, vEmb );
	float MaskColor = tex2D( MaskTexture, v.vTexCoord1.xy ).r;
	float SealMaskColor = tex2D( SealMaskTexture, v.vTexCoord1.xy ).a;
	OutColor = OutColor.r * Color1 + OutColor.g * Color2 + OutColor.b * Color3;
	OutColor = lerp( OutColor, EmblemColor, EmblemColor.a );
	
	OutColor -= tex2D( BaseTexture, v.vTexCoord0.xy-0.0009)*2.7f;
	OutColor += tex2D( BaseTexture, v.vTexCoord0.xy+0.0009)*2.7f;
	float vC = ( ( OutColor.r*0.212671+OutColor.g*0.715160+OutColor.b*0.072169)/3.0f );
	OutColor.rgb = float3(vC, vC, vC);
	OutColor.rgb *= float3( 3.0f, 1.0f, 1.0f );
	
	OutColor.a = MaskColor * Over_Alpha.y * SealMaskColor;
	OutColor += Over_Alpha.x * float4( 0.1, 0.1, 0.1, 0.0 );
	return OutColor;
}
]] )

DeclareShader( "GeneralPixelShaderFrame", [[
float4 main( VS_OUTPUT_FRAME v ) : COLOR
{
	float4 OutColor = tex2D( BaseTexture, v.vTexCoord0.xy );
	
	OutColor.a *= Over_Alpha.y;
	OutColor += Over_Alpha.x * float4( 0.1, 0.1, 0.1, 0.0 );

	return OutColor;
}

]] )
