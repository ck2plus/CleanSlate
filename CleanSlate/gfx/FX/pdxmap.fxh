
CONSTANT_BUFFER( 1, 32 )
{
float4	QuadOffset_Scale_IsDetail					;
float4  vSnap										;
float4	vBorderLookup_HeightScale_UseMultisample_Unused	;
}

//#define	vUseMultisample vBorderLookup_HeightScale_UseMultisample.z
//#define vHeightScale vBorderLookup_HeightScale_UseMultisample.y
//#define	vBorderLookup vBorderLookup_HeightScale_UseMultisample.x

const static float WATER_HEIGHT = 19.0f;
const static float WATER_HEIGHT_RECP = 1.0f / 19.0f;
const static float vTimeScale = 0.5f / 300.0f;
