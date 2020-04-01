Samplers = 
{
	DiffuseTexture = {
		Index = 0;
		MinFilter = "Linear";
		MagFilter = "Linear";
		MipFilter = "Linear";
		AddressU = "Clamp";
		AddressV = "Clamp";
	}
}

AddSamplers()

Includes = {
	"standardfuncsgfx.fxh"
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
	float4x4 ViewProj;
	float3 vProgress_MoveArmy;
}

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
    float4 vPosition : POSITION;
    float2 vTexCoord : TEXCOORD0;
	float3 vPos		 : TEXCOORD1;
};

]] )

ArrowEffect = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;
}

ArrowEndingEffect = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShaderEnding";
	ShaderModel = 3;
}

DeclareShader( "VertexShader", [[
VS_OUTPUT main(const VS_INPUT v )
{
 	VS_OUTPUT Out;

	float4 pos = float4( v.vPosition, 1.0f );
	pos.y += 2.0f * vProgress_MoveArmy.z + 0.5 * ( 1.0f - vProgress_MoveArmy.z );
	pos.y += 2.0f;
	
	Out.vPos = pos.xyz;
   	Out.vPosition  = mul( pos, ViewProj );	
	Out.vTexCoord = v.vTexCoord;

	return Out;
}

]] )

DeclareShader( "PixelShader", [[
float4 main( VS_OUTPUT v ) : COLOR
{
 	clip( vProgress_MoveArmy.x - v.vTexCoord.y );

	float vPassed = v.vTexCoord.y < vProgress_MoveArmy.y ? 1.0f : 0.0f;

	float vArrowPart = 15.0f;
	
	float vArrowDiff = v.vTexCoord.y - ( vProgress_MoveArmy.x - vArrowPart );
	float vArrow = saturate( vArrowDiff * 10000.0f );

	float BODY = 0.125f;
	float ARROW = 1.0f - BODY;

	float vBodyV = frac( v.vTexCoord.y * 0.00001f ) * BODY;
	float vArrowV = BODY + ( vArrowDiff / vArrowPart ) * ARROW;

	float4 OutColorBody = tex2D( DiffuseTexture, float2( v.vTexCoord.x * 0.5f, vBodyV ).yx );
	float4 OutColorBodyPass = tex2D( DiffuseTexture, float2( 0.5f + v.vTexCoord.x * 0.5f, vBodyV ).yx );
	float4 OutColorArrow = tex2D( DiffuseTexture, float2( v.vTexCoord.x * 0.5f, vArrowV ).yx );
	float4 OutColorArrowPass = tex2D( DiffuseTexture, float2( 0.5f + v.vTexCoord.x * 0.5f, vArrowV ).yx );

	float4 OutColor = lerp(
			lerp( OutColorBody, OutColorArrow, vArrow ),
			lerp( OutColorBodyPass, OutColorArrowPass, vArrow ),
			vPassed );

	return float4( ComposeSpecular( OutColor.rgb, 0.0f ), OutColor.a );
}
]] )

DeclareShader( "PixelShaderEnding", [[
float4 main( VS_OUTPUT v ) : COLOR
{
	float4 OutColor = tex2D( DiffuseTexture, v.vTexCoord.xy );

	return float4( ComposeSpecular( OutColor.rgb, 0.0f ), OutColor.a );
}
]] )
