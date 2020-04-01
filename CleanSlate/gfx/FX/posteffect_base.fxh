static const float vSamples = 3.0f;
static const float4 vWeights = float4( 55.0f, 12.0f, 1.0f, 90.0f );

CONSTANT_BUFFER( 1, 32 )
{
	float4 	Season;
	float3 vHalfPixelOffset_Axis;
	float2 vHalfPixelOffsetBloom;
};

