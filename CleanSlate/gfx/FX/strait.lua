Samplers = 
{
	DiffuseTexture = {
		Index = 0;
		MagFilter = "Linear";
		MipFilter = "Linear";
		MinFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
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

DepthStencil = {
	DepthEnable = true;
}

RasterizerState =
{
	FillMode = "FILL_SOLID";
	CullMode = "CULL_BACK";
	FrontCCW = false;
}

Defines = { } -- Comma separated defines ie. "USE_SIMPLE_LIGHTS", "GUI"

AddSamplers()

DeclareVertex( [[
struct VS_INPUT
{
    float4 vPosition		: POSITION;
	float4 vUV				: TEXCOORD0;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT
{
    float4  vPosition 	: POSITION;
    float2	vUV		  	: TEXCOORD0;
	float3	vPos		: TEXCOORD1;
};
]] )

strait = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;
}


DeclareShader( "VertexShader", [[
VS_OUTPUT main( const VS_INPUT v )
{
	VS_OUTPUT Out;
   	
	float4 vPos = float4( v.vPosition.xyz, 1.0f );
	
	vPos.y += 1.0f;
	
   	Out.vPosition  = mul( vPos, ViewProjectionMatrix );
	
	// move z value slightly closer to camera to avoid intersections with terrain
	float4 vDistortedPos = vPos - float4( vCamLookAtDir * 0.01f, 0.0f );	
	float vNewZ = dot( vDistortedPos, float4( GetMatrixData( ViewProjectionMatrix, 0, 2 ), GetMatrixData( ViewProjectionMatrix, 1, 2 ), GetMatrixData( ViewProjectionMatrix, 2, 2 ), GetMatrixData( ViewProjectionMatrix, 3, 2 ) ) );
	Out.vPosition.z = vNewZ;
	
   	Out.vUV = v.vUV.xy;
	Out.vPos = vPos.rgb;
	
	return Out;
}

]] )

DeclareShader( "PixelShader", [[

float4 main( VS_OUTPUT v ) : COLOR
{
	float4 vColor = tex2D( DiffuseTexture, v.vUV );
	vColor.rgb = ApplyDistanceFog( vColor.rgb, v.vPos, FoWTexture, FoWDiffuse );
	
	return vColor;
}

]] )
