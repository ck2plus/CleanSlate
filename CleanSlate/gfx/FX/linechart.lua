Includes = {
}

Defines = { } -- Comma separated defines ie. "USE_SIMPLE_LIGHTS", "GUI"

DeclareVertex( [[

struct VS_OUTPUT
{
    float4 vPosition : POSITION;
    float3 vColor	 : TEXCOORD0;
};

]] )

DeclareVertex( [[
struct VS_INPUT
{
	float4 nOffset  : POSITION;
};
]] )

linechart = {
	VertexShader = "VertexShader";
	PixelShader = "PixelShader";
	ShaderModel = 3;
}

DeclareShader( "VertexShader", [[

CONSTANT_BUFFER( 0, 0 )
{
float4x4 InverseView;
float4 vColorHeight[40];
float4 vScreenPosWidthHeight;
float2 vHalfLineWidthScale;
}


VS_OUTPUT main(const VS_INPUT v )
{
    VS_OUTPUT Out;
	int4 nOffsetInt = int4(v.nOffset.x, v.nOffset.y, v.nOffset.z, v.nOffset.w);

  	float  vHeight = vColorHeight[nOffsetInt.x].w;
	float  vOtherHeight = vColorHeight[ nOffsetInt.x + nOffsetInt.y ].w;
	
	float2 vLineVec = float2( vHalfLineWidthScale.y * nOffsetInt.y, vScreenPosWidthHeight.w * ( vHeight - vOtherHeight ) );
	vLineVec = normalize( vLineVec );
	vLineVec = float2( -vLineVec.y, vLineVec.x );
	
	float2 vCenterPoint = vScreenPosWidthHeight.xy; // screenpos of widget
	vCenterPoint.x += nOffsetInt.x * vHalfLineWidthScale.y;
	vCenterPoint.y += vScreenPosWidthHeight.w * (1.0f - vHeight);
	
	vLineVec.xy  *= vHalfLineWidthScale.x * nOffsetInt.z;
	vCenterPoint += vLineVec;
	
	Out.vPosition = mul( float4( vCenterPoint, 0, 1 ), InverseView );
	Out.vColor = vColorHeight[ nOffsetInt.x ].xyz;
	return Out;
}

]] )

DeclareShader( "PixelShader", [[
float4 main( VS_OUTPUT v ) : COLOR
{
 	return float4( v.vColor, 1.0f );
}
]] )
