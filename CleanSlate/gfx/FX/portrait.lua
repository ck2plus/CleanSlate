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
	float4x4 WorldViewProjectionMatrix;	 
	float4	HairColor1;					
	float4	HairColor2;					
	float4	HairColor3;					
	float4	EyeColor;					
	float2  Over_Alpha;					
};

CONSTANT_BUFFER( 1, 32 )
{
	float4	 FlagCoords;				
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

Standard = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;
}
Eyes = {
	VertexShader = "VertexShader";
	PixelShader = "EyePixelShader";
	ShaderModel = 3;
}
Hair = {
	VertexShader = "VertexShader";
	PixelShader = "HairPixelShader";
	ShaderModel = 3;
}


DeclareShader( "VertexShader", [[
VS_OUTPUT main(const VS_INPUT v )
{
	VS_OUTPUT Out;

	Out.vPosition  = mul(v.vPosition, WorldViewProjectionMatrix );

	Out.vTexCoord0.x = v.vTexCoord.x / FlagCoords.x + FlagCoords.z;
	Out.vTexCoord0.y = v.vTexCoord.y / FlagCoords.y + FlagCoords.w;
	
	return Out;
}

]] )

DeclareShader( "PixelShader", [[
float4 main( VS_OUTPUT v ) : COLOR
{
	float4 OutColor = tex2D( BaseTexture, v.vTexCoord0.xy );
	
	OutColor.a *= Over_Alpha.y;
	OutColor += Over_Alpha.x * float4( 0.1, 0.1, 0.1, 0.0 );
	return OutColor;
}

]] )

DeclareShader( "EyePixelShader", [[
float4 main( VS_OUTPUT v ) : COLOR
{
	float4 OutColor = tex2D( BaseTexture, v.vTexCoord0.xy );
	OutColor = float4( EyeColor.rgb * OutColor.r, OutColor.a * Over_Alpha.y );
	OutColor += Over_Alpha.x * float4( 0.1, 0.1, 0.1, 0.0 );
	return OutColor;
}
]] )

DeclareShader( "HairPixelShader", [[
float4 main( VS_OUTPUT v ) : COLOR
{

	float4 OutColor = tex2D( BaseTexture, v.vTexCoord0.xy );
			
	//hair colors
	//0     0.5   1.0
	//c1 -> c2 -> c3	
	float4 ctmp = lerp( HairColor1, HairColor2, saturate(OutColor.g * 2) );
	ctmp = lerp( ctmp, HairColor3, saturate((OutColor.g - 0.5)*2 ));
	
	//ctmp.rgb *= OutColor.r;
	ctmp.a = OutColor.a * Over_Alpha.y;
	ctmp += Over_Alpha.x * float4( 0.1, 0.1, 0.1, 0.0 );
	return ctmp;
}
]] )

