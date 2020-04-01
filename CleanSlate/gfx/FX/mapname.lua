Samplers = 
{
	DiffuseTexture = {
		Index = 0;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Clamp";
		AddressV = "Clamp";
		MipMapLodBias = -1;
	},
	FoWTexture = {
		Index = 1;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},
	FoWDiffuse = {
		Index = 2;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
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
	ZWriteEnable = false;
	SourceBlend = "src_alpha";
	DestBlend = "inv_src_alpha";

	WriteMask = "RED|GREEN|BLUE";
	CullMode = "CW";
}
Defines = { } -- Comma separated defines ie. "USE_SIMPLE_LIGHTS", "GUI"

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
	float3 vPrepos   : TEXCOORD0;
    float2 vTexCoord : TEXCOORD1;
};
]] )

mapname = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;
}

DeclareShader( "VertexShader", [[
VS_OUTPUT main( const VS_INPUT v )
{
	VS_OUTPUT Out;

	float4 vPos = float4( v.vPosition, 1.0f );
	float4 vDistortedPos = vPos - float4( vCamLookAtDir * 0.5f, 0.0f );

	vPos = mul( vPos, ViewProjectionMatrix );
	
	// move z value slightly closer to camera to avoid intersections with terrain
	float vNewZ = dot( vDistortedPos, float4( GetMatrixData( ViewProjectionMatrix, 0, 2 ), GetMatrixData( ViewProjectionMatrix, 1, 2 ), GetMatrixData( ViewProjectionMatrix, 2, 2 ), GetMatrixData( ViewProjectionMatrix, 3, 2 ) ) );
	
	Out.vPosition = float4( vPos.xy, vNewZ, vPos.w );
	Out.vPrepos = v.vPosition.xyz;
	Out.vTexCoord = v.vTexCoord;

	return Out;
}

]] )

DeclareShader( "PixelShader", [[

CONSTANT_BUFFER( 1, 32 )
{
	float2 vTargetOpacity_Fade;
}

float4 main( VS_OUTPUT v ) : COLOR
{
	float4 vSample = tex2D( DiffuseTexture, v.vTexCoord );
	vSample.a *= vTargetOpacity_Fade.x * vTargetOpacity_Fade.y;	
	vSample.rgb = ApplyDistanceFog( vSample.rgb, v.vPrepos, FoWTexture, FoWDiffuse );
	return vSample;
	
}

]] )
