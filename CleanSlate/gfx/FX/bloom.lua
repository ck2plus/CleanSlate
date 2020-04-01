Samplers = 
{
	Specular = {
		Index = 0;
		MagFilter = "Linear";
		MinFilter = "Linear";
		MipFilter = "Linear";
		AddressU = "Clamp";
		AddressV = "Clamp";
	}
}
AddSamplers()


Includes = {
	"standardfuncsgfx.fxh",
	"posteffect_base.fxh"
}

bloom = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;
}

BlendState = {
	BlendEnable = false;
	AlphaTest = false;
	WriteMask = "RED";
}

DeclareShared( [[
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
	
	color /= dot( vWeights, float4( 1.0f,1.0f,1.0f,1.0f ));
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

DeclareShader( "VertexShader", [[

VS_OUTPUT_BLOOM main( const VS_INPUT VertexIn )
{
	VS_OUTPUT_BLOOM VertexOut;
	VertexOut.position = float4( VertexIn.position, 0.0f, 1.0f );
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
	float BloomVal = SampleBloom( Specular, Input );
	return float4( BloomVal, BloomVal, BloomVal, 1.0f );
}


]] )
