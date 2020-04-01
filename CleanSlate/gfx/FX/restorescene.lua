Samplers = 
{
	MainScene = {
		Index = 0;
		MagFilter = "Point";
		MinFilter = "Point";
		MipFilter = "None";
		AddressU = "Clamp";
		AddressV = "Clamp";
	},
	RestoreBloom = {
		Index = 1;
		MagFilter = "Linear";
		MinFilter = "Linear";
		MipFilter = "Linear";
		AddressU = "Clamp";
		AddressV = "Clamp";
	}
}


Includes = {
	"standardfuncsgfx.fxh",
	"posteffect_base.fxh"
}

Restore = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;
}

RestoreBloom = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShaderBloom";
	ShaderModel = 3;
}

BlendState = {
	BlendEnable = false;
	AlphaTest = false;
	ZWriteEnable = false;
	ZEnable = false;
	WriteMask = "RED GREEN BLUE";
}

DeclareShared( [[


static const float3 HSVTweak = float3( 0.0f, 0.72f, 1.0f );
static const float3 ColorBalance = float3( 1.1f, 1.0f, 1.0f );
static const float2 LevelValue = float2( 0.03f, 0.85f );    // First: DARKNESS 0.0 Normal, the higher the darker   Second: Brightness, Lower = brighter

float4 RestoreScene( VS_OUTPUT_BLOOM Input )
{
	float3 color = saturate( tex2D( MainScene, Input.uv ).rgb /** ( 1.0f / STANDARD_HDR_RANGE )*/ );

	float3 HSV = RGBtoHSV( color.rgb );
	HSV.yz *= HSVTweak.yz;
	HSV.x += HSVTweak.x;
	HSV.x = mod( HSV.x, 6 );
	color = HSVtoRGB( HSV );

	color = saturate( color * ColorBalance );

	color = Levels( color, LevelValue.x, LevelValue.y );

	return float4( color, 1.0f );
}

float SampleBloom( in sampler2D InSampler, in VS_OUTPUT_BLOOM Input )
{
	float color = tex2D( InSampler, Input.uvBloom ).r * vWeights[3];

	color += vWeights[0] 
			* ( tex2D( InSampler, Input.uvBloom2_0.xy ).r
				+ tex2D( InSampler, Input.uvBloom2_0.zw ).r );
	color += vWeights[1] 
			* ( tex2D( InSampler, Input.uvBloom2_1.xy ).r
				+ tex2D( InSampler, Input.uvBloom2_1.zw ).r );
	color += vWeights[2] 
			* ( tex2D( InSampler, Input.uvBloom2_2.xy ).r
				+ tex2D( InSampler, Input.uvBloom2_2.zw ).r );
	
	color /= dot( vWeights, float4( 1.0f,1.0f,1.0f,1.0f ) );
	return color;
}

]] )

DeclareVertex( [[

struct VS_INPUT
{
    float2 position			: POSITION;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT_BLOOM
{
    float4 position			: POSITION;
	float2 uv				: TEXCOORD0;
	float2 uvBloom			: TEXCOORD1;
	float4 uvBloom2_0		: TEXCOORD2;
	float4 uvBloom2_1		: TEXCOORD3;
	float4 uvBloom2_2		: TEXCOORD4;
};
]] )

AddSamplers()

DeclareShader( "VertexShader", [[

VS_OUTPUT_BLOOM main( const VS_INPUT VertexIn )
{
	VS_OUTPUT_BLOOM VertexOut;
	VertexOut.position = float4( VertexIn.position.x, FIX_FLIPPED_UV( VertexIn.position.y ), 0.0f, 1.0f );
	VertexOut.uv = ( VertexIn.position + 1.0f ) * 0.5f;
	VertexOut.uv.y = 1.0f - VertexOut.uv.y;
	VertexOut.uvBloom = VertexOut.uv;
	VertexOut.uv += vHalfPixelOffset_Axis.xy;
	VertexOut.uvBloom += vHalfPixelOffsetBloom;

	float vAxis = vHalfPixelOffset_Axis.z;

	float2 vAxisOffset = float2( vHalfPixelOffset_Axis.x * vAxis, vHalfPixelOffset_Axis.y * ( 1.0f - vAxis ) );

		float vStepFactor = 2.0f;
	VertexOut.uvBloom2_0 = float4( 
			VertexOut.uvBloom + (0+1) * vAxisOffset * vStepFactor, 
			VertexOut.uvBloom - (0+1) * vAxisOffset * vStepFactor );
	VertexOut.uvBloom2_1 = float4( 
			VertexOut.uvBloom + (1+1) * vAxisOffset * vStepFactor, 
			VertexOut.uvBloom - (1+1) * vAxisOffset * vStepFactor );
	VertexOut.uvBloom2_2 = float4( 
			VertexOut.uvBloom + (2+1) * vAxisOffset * vStepFactor, 
			VertexOut.uvBloom - (2+1) * vAxisOffset * vStepFactor );


	return VertexOut;
}

]] )

DeclareShader( "PixelShader", [[

float4 main( VS_OUTPUT_BLOOM Input ) : COLOR
{
	return RestoreScene( Input );
}


]] )

DeclareShader( "PixelShaderBloom", [[

float4 main( VS_OUTPUT_BLOOM Input ) : COLOR
{
	float4 vColor = RestoreScene( Input );
	float bloom = SampleBloom( RestoreBloom, Input );
	return float4( vColor.rgb + float3(bloom,bloom,bloom) * STANDARD_vDiffuseLight * 0.3f, 1.0f );
}


]] )
