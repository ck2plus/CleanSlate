Samplers = {
	DiffuseMap = {
		Index = 0;
		MinFilter = "Anisotropic";
		MagFilter = "Linear";
		MipFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
		MipMapLodBias = -1;
		MaxAnisotropy = 4;
	},	
	SpecularMap = {
		Index = 1;
		MinFilter = "Linear";
		MagFilter = "Linear";
		MipFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},	
	
	NormalMap = {
		Index = 2;
		MinFilter = "Linear";
		MagFilter = "Linear";
		MipFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},	
	
	FlagMap = {
		Index = 3;
		MinFilter = "Linear";
		MagFilter = "Linear";
		MipFilter = "None";
		AddressU = "Clamp";
		AddressV = "Clamp";
	},	
	
	FoWTexture = {
		Index = 4;
		MinFilter = "Linear";
		MagFilter = "Linear";
		MipFilter = "Linear";
		AddressU = "Clamp";
		AddressV = "Clamp";
	},	
	
	FoWDiffuse = {
		Index = 5;
		MinFilter = "Linear";
		MagFilter = "Linear";
		MipFilter = "Linear";
		AddressU = "Wrap";
		AddressV = "Wrap";
	},	
}

AddSamplers()

BlendState = {
	BlendEnable = false;
	AlphaTest = false;
}

BlendState2 = {
	BlendEnable = true;
	AlphaTest = false;
	SourceBlend = "SRC_ALPHA";
	DestBlend = "INV_SRC_ALPHA";
}

Includes = {
	"standardfuncsgfx.fxh"
}

Defines = { }

DeclareVertex( [[
struct VS_INPUT
{
    float4 vPosition   : POSITION;
    float3 vNormal     : NORMAL;
	float4 vTangent    : TANGENT;
	float2 vTexCoord0  : TEXCOORD0;
	float4 boneIndices : BLENDINDICES;
    float4 boneWeights : BLENDWEIGHT;
};

]] )

DeclareVertex( [[
struct VS_INPUT_STATIC
{
    float4 vPosition   : POSITION;
    float3 vNormal     : NORMAL;
	float4 vTangent    : TANGENT;
	float2 vTexCoord0  : TEXCOORD0;
};

]] )

DeclareVertex( [[
struct VS_INPUT_TAB
{
    float4 vPosition   : POSITION;
    float3 vNormal     : NORMAL;
	float4 vTangent    : TANGENT;
	float2 vTexCoord0  : TEXCOORD0;
	float2 vTexCoord1  : TEXCOORD1;
	float4 boneIndices : BLENDINDICES;
    float4 boneWeights : BLENDWEIGHT;
};

]] )

DeclareVertex( [[

struct VS_OUTPUT
{
    float4 vPosition  : POSITION;
	float2 vTexCoord0 : TEXCOORD0;
	float3 Normal     : TEXCOORD1;
	float3 vPos       : TEXCOORD2;
	float3 vTangent   : TEXCOORD3;
};

]] )

DeclareVertex( [[
struct VS_INPUT_TAB_STATIC
{
    float4 vPosition   : POSITION;
    float3 vNormal     : NORMAL;
	float4 vTangent    : TANGENT;
	float2 vTexCoord0  : TEXCOORD0;
	float2 vTexCoord1  : TEXCOORD1;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT_TAB
{
    float4 vPosition  : POSITION;
	float2 vTexCoord0 : TEXCOORD0;
	float2 vTexCoord1 : TEXCOORD1;
	float3 vNormal    : TEXCOORD2;
	float3 vPos       : TEXCOORD3;
};
]] )

DeclareVertex( [[
struct VS_OUTPUT_TAB_STATIC
{
    float4 vPosition  : POSITION;
	float2 vTexCoord0 : TEXCOORD0;
	float2 vTexCoord1 : TEXCOORD1;
	float3 vNormal    : TEXCOORD2;
	float3 vPos       : TEXCOORD3;
	float3 vTangent	  : TEXCOORD4;
};
]] )
DeclareShared( [[

CONSTANT_BUFFER( 1, 32 )
{
	float4x4 WorldMatrix;
	float4 TextureOffset;
	float4 PrimaryColor;
	float4 SecondaryColor;
	float4 TertiaryColor; 
	float2 vScale_Time;
}

CONSTANT_BUFFER( 2, 41 )
{
	float4x4 matBones[45]; // : Bones :register( c41 ); // 45 * 4 registers 41 - 221 
}

static const int SKINNING_INFLUENCES = 2;


float2 GetTexCoordsInAtlas(float2 TexCoord)
{
	return float2( (TexCoord.x / TextureOffset.x) + TextureOffset.z,
	               (TexCoord.y / TextureOffset.y) + TextureOffset.w );
}

]] )

StaticTabard = {
	VertexShader = "VertexStaticTabard";
	PixelShader = "PixelStaticTabard";
	ShaderModel = 3;
}

Tabard = {
	VertexShader = "VertexTabard";
	PixelShader = "PixelTabard";
	ShaderModel = 3;
}

StaticStandard = {
	VertexShader = "VertexStatic";
	PixelShader = "PixelAvatar";
	ShaderModel = 3;
}

StaticStandardShield = {
	VertexShader = "VertexStaticTabard";
	PixelShader = "PixelAvatarShield";
	ShaderModel = 3;
}

StaticStandardNormal = {
	VertexShader = "VertexStandard";
	PixelShader = "PixelAvatarNormal";
	ShaderModel = 3;

	BlendState = "BlendState2";
}

Standard = {
	VertexShader = "VertexStandard";
	PixelShader = "PixelAvatar";
	ShaderModel = 3;
}

Smoke = {
	VertexShader = "VertexStatic";
	PixelShader = "PixelSmoke";
	BlendState = "BlendState2";
	ShaderModel = 3;
}


DeclareShader( "VertexStandard", [[

VS_OUTPUT main(const VS_INPUT v )
{
	VS_OUTPUT Out;
		
	float4 skinnedPosition = float4( 0, 0, 0, 0 );
	float3 skinnedNormal = float3( 0, 0, 0 );
	float3 skinnedTangent = float3( 0, 0, 0 );

	float4 vPosition = float4( v.vPosition.xyz, 1.0 );
		
	// skinning
	for( int i = 0; i < SKINNING_INFLUENCES; ++i )
    {
		int Index = int( v.boneIndices[i] );
		float4x4 mat = matBones[ Index ];
	#ifdef PDX_OPENGL
		skinnedNormal += mul( v.vNormal, float3x3( mat ) ) * v.boneWeights[i];
		skinnedTangent += mul( v.vTangent.xyz, float3x3( mat ) ) * v.boneWeights[i];
	#else
    	skinnedNormal += mul( v.vNormal, (float3x3) mat ) * v.boneWeights[i];
		skinnedTangent += mul( v.vTangent.xyz, (float3x3) mat ) * v.boneWeights[i];
	#endif
		skinnedPosition += mul( vPosition, mat ) * v.boneWeights[i];		
	}
	
	Out.vPos = skinnedPosition.xyz;
	Out.vPosition = mul(skinnedPosition, ViewProjectionMatrix );
	Out.vTexCoord0 = v.vTexCoord0;
	Out.Normal  = normalize(skinnedNormal);
	Out.vTangent = normalize( skinnedTangent ) * v.vTangent.w;

	return Out;
}
]] )


DeclareShader( "VertexStaticTabard", [[

VS_OUTPUT_TAB_STATIC main( const VS_INPUT_TAB_STATIC v )
{
 VS_OUTPUT_TAB_STATIC Out;

	Out.vPosition = float4(v.vPosition.xyz * vScale_Time.x * clamp( 0.35f + ( vCamPos.y / 500.0f ), 0.45f, 2.2f ), 1.0);
	
#	ifdef PDX_OPENGL

	float4x4 Rot = float4x4( ViewMatrix[0][0], ViewMatrix[1][0], ViewMatrix[2][0], 0.0f,
                     ViewMatrix[0][1], ViewMatrix[1][1], ViewMatrix[2][1], 0.0f,
                     ViewMatrix[0][2], ViewMatrix[1][2], ViewMatrix[2][2], 0.0f,
                     0.0f, 0.0f, 0.0f, 1.0f );
#	else

	float4x4 Rot = { ViewMatrix._m00_m10_m20, 0.0f,
                     ViewMatrix._m01_m11_m21, 0.0f,
					 ViewMatrix._m02_m12_m22, 0.0f,
					 0.0f, 0.0f, 0.0f, 1.0f }; 
#	endif

	Out.vPosition = mul( Out.vPosition, Rot );
	Out.vPosition = mul( Out.vPosition, WorldMatrix );
	
	Out.vPos = Out.vPosition.xyz;
	Out.vPosition = mul( Out.vPosition, ViewProjectionMatrix );

	Out.vTexCoord0 = v.vTexCoord0;
	Out.vTexCoord1 = v.vTexCoord1;
#	ifdef PDX_OPENGL
	Out.vNormal = normalize( mul( v.vNormal.xyz, float3x3(Rot) ) );
	Out.vTangent = normalize( mul( v.vTangent.xyz, float3x3(Rot) ) ) * v.vTangent.w;
#	else
	Out.vNormal = normalize( mul( v.vNormal.xyz, (float3x3)Rot ) );
	Out.vTangent = normalize( mul( v.vTangent.xyz, (float3x3)Rot ) ) * v.vTangent.w;
#	endif
	return Out;
}

]] )

DeclareShader( "PixelStaticTabard", [[
	
float4 main( VS_OUTPUT_TAB_STATIC In ) : COLOR
{
  	float4 vColor = tex2D( DiffuseMap, In.vTexCoord0 );
	float3 vSpecColor = tex2D( SpecularMap, In.vTexCoord0 ).rgb;
	float3 vTabardColor = tex2D( FlagMap, GetTexCoordsInAtlas( In.vTexCoord1 ) ).rgb;
	float3 vNormal = normalize( In.vNormal );
	float3 vTangent = normalize( In.vTangent );
	float3 vBitangent = cross( vTangent, vNormal );

	float3 vNormalSample = normalize( tex2D( NormalMap, In.vTexCoord0 ).rbg - 0.5f );
	float3x3 TNB = float3x3( vTangent, vNormal, vBitangent );
	vNormal = mul( vNormalSample, TNB );
	
	float3 vFinal = vColor.rgb * ( 1 - vColor.a ) + vColor.rgb * vColor.a * vTabardColor;

	vFinal = CalculateLighting( vFinal, vNormal );
	float vFoW = GetFoW( In.vPos, FoWTexture, FoWDiffuse );
	vFinal = ApplyDistanceFog( vFinal, In.vPos ) * vFoW;
	vFinal = ComposeSpecular( vFinal, CalculateSpecular( In.vPos, vNormal, vSpecColor.r ) * vFoW );

	return float4( vFinal, 1 );
}
	
]] )


DeclareShader( "VertexStatic", [[

VS_OUTPUT main( const VS_INPUT_STATIC v )
{
  	VS_OUTPUT Out;
			
	Out.vPosition = float4(v.vPosition.xyz * vScale_Time.x, 1.0);
	Out.vPosition = mul(Out.vPosition, WorldMatrix );
	
	Out.vPos = Out.vPosition.xyz;
	Out.vPosition = mul(Out.vPosition, ViewProjectionMatrix );
	
	Out.vTexCoord0 = v.vTexCoord0;
#	ifdef PDX_OPENGL
	Out.Normal  = normalize( mul( v.vNormal, float3x3(WorldMatrix) ) );
#	else
	Out.Normal  = normalize( mul( v.vNormal, (float3x3)WorldMatrix ) );
#	endif
	Out.vTangent = float3( 0.0f, 0.0f, 0.0f );
	return Out;
}

]] )

DeclareShader( "PixelAvatar", [[
	
float4 main( VS_OUTPUT In ) : COLOR
{
	float4 vColor = tex2D( DiffuseMap, In.vTexCoord0 );
	float4 vColor_Spec = tex2D( SpecularMap, In.vTexCoord0 );
	float3 vNormal = normalize( In.Normal );

	vColor.rgb = lerp( vColor.rgb, 
	        vColor.rgb * ( vColor_Spec.r * PrimaryColor.rgb ), 
		    vColor_Spec.r );

	vColor.rgb = lerp( vColor.rgb, 
	        vColor.rgb * ( vColor_Spec.g * SecondaryColor.rgb ), 
		    vColor_Spec.g );

	vColor.rgb = lerp( vColor.rgb, 
	        vColor.rgb * ( vColor_Spec.b * TertiaryColor.rgb ), 
		    vColor_Spec.b );

	vColor.rgb = CalculateLighting( vColor.rgb, vNormal );
	float vFoW = GetFoW( In.vPos, FoWTexture, FoWDiffuse );
	vColor.rgb = ApplyDistanceFog( vColor.rgb, In.vPos ) * vFoW;
	vColor.rgb = ComposeSpecular( vColor.rgb, CalculateSpecular( In.vPos, vNormal, vColor_Spec.a ) * vFoW );

	return vColor;
}
	
]] )

DeclareShader( "PixelAvatarShield", [[
	
float4 main( VS_OUTPUT_TAB_STATIC In ) : COLOR
{
	float4 vColor = tex2D( DiffuseMap, In.vTexCoord0 );
	float4 vColor_Spec = tex2D( SpecularMap, In.vTexCoord0 );
	float3 vNormal = normalize( In.vNormal );

	vColor.rgb = lerp( vColor.rgb, 
	        vColor.rgb * ( vColor_Spec.r * PrimaryColor.rgb ), 
		    vColor_Spec.r );

	vColor.rgb = lerp( vColor.rgb, 
	        vColor.rgb * ( vColor_Spec.g * SecondaryColor.rgb ), 
		    vColor_Spec.g );

	vColor.rgb = lerp( vColor.rgb, 
	        vColor.rgb * ( vColor_Spec.b * TertiaryColor.rgb ), 
		    vColor_Spec.b );

	vColor.rgb = CalculateLighting( vColor.rgb, vNormal );
	float vFoW = GetFoW( In.vPos, FoWTexture, FoWDiffuse );
	vColor.rgb = ApplyDistanceFog( vColor.rgb, In.vPos ) * vFoW;
	vColor.rgb = ComposeSpecular( vColor.rgb, CalculateSpecular( In.vPos, vNormal, vColor_Spec.a ) * vFoW );

	return vColor;
}
	
]] )


DeclareShader( "PixelAvatarNormal", [[
	
float4 main( VS_OUTPUT In ) : COLOR
{
	float4 vColor = tex2D( DiffuseMap, In.vTexCoord0 );
	clip( vColor.a - 0.0001f );

	float4 vColor_Spec = tex2D( SpecularMap, In.vTexCoord0 );
	float3 vNormal = normalize( In.Normal );
	float3 vTangent = normalize( In.vTangent );
	float3 vBitangent = cross( vTangent, vNormal );

	float3 vNormalSample = normalize( tex2D( NormalMap, In.vTexCoord0 ).rbg - 0.5f );
	float3x3 TNB = float3x3( vTangent, vNormal, vBitangent );
	vNormal = mul( vNormalSample, TNB );

	vColor.rgb = CalculateLighting( vColor.rgb, vNormal );
	float vFoW = GetFoW( In.vPos, FoWTexture, FoWDiffuse );
	vColor.rgb = ApplyDistanceFog( vColor.rgb, In.vPos ) * vFoW;
	vColor.rgb = ComposeSpecular( vColor.rgb, CalculateSpecular( In.vPos, vNormal, vColor_Spec.a ) * vFoW );

	return vColor;
}
	
]] )

DeclareShader( "VertexTabard", [[

VS_OUTPUT_TAB main(const VS_INPUT_TAB v )
{
	VS_OUTPUT_TAB Out;
		
	float4 skinnedPosition = float4( 0, 0, 0 ,0 );
	float3 skinnedNormal = float3( 0, 0, 0 );
	//float3 skinnedTangent = float3( 0, 0, 0 );
	
	float4 vPosition = float4( v.vPosition.xyz, 1.0 );
		
	// skinning
	for( int i = 0; i < SKINNING_INFLUENCES; ++i )
    {
		int Index = int( v.boneIndices[i] );
		float4x4 mat = matBones[ Index ];

	#ifdef PDX_OPENGL
		skinnedNormal += mul( v.vNormal, float3x3( mat ) ) * v.boneWeights[i];
	#else
		skinnedNormal += mul( v.vNormal, (float3x3)mat ) * v.boneWeights[i];
	#endif

		skinnedPosition += mul( vPosition, mat ) * v.boneWeights[i];		
		//skinnedTangent += mul( v.vTangent.xyz, mat ) * v.boneWeights[i];
	}
		
	Out.vPos = skinnedPosition.xyz;
	Out.vPosition = mul( skinnedPosition, ViewProjectionMatrix );
	Out.vTexCoord0 = v.vTexCoord0;
	Out.vTexCoord1 = v.vTexCoord1;
	Out.vNormal = normalize( skinnedNormal );
	//Out.vTangent = normalize( skinnedTangent ) * v.vTangent.w;


	return Out;
}
]] )

DeclareShader( "PixelTabard", [[

float4 main( VS_OUTPUT_TAB In ) : COLOR
{
	float4 vColor = tex2D( DiffuseMap, In.vTexCoord0 );
	float3 vSpecColor = tex2D( SpecularMap, In.vTexCoord0 ).rgb;
	float3 vTabardColor = tex2D( FlagMap, GetTexCoordsInAtlas( In.vTexCoord1 ) ).rgb;
	float3 vNormal = normalize( In.vNormal );
	
	float3 vFinal = vColor.rgb * ( 1 - vColor.a ) + vColor.rgb * vColor.a * vTabardColor;

	vFinal = CalculateLighting( vFinal, vNormal );
	float vFoW = GetFoW( In.vPos, FoWTexture, FoWDiffuse );
	vFinal = ApplyDistanceFog( vFinal, In.vPos ) * vFoW;
	vFinal = ComposeSpecular( vFinal, CalculateSpecular( In.vPos, vNormal, vSpecColor.r ) * vFoW );
	
	return float4( vFinal, 1 );
}
]] )

DeclareShader( "PixelSmoke", [[

float4 main( VS_OUTPUT In ) : COLOR
{
	const float ANIMATION_SPEED = 0.5;
	float t = frac( vScale_Time.y * ANIMATION_SPEED);
	float vAlpha = tex2D( DiffuseMap, In.vTexCoord0 ).a;
	float4 vColor = tex2D( DiffuseMap, float2(In.vTexCoord0.x, In.vTexCoord0.y + t ) );
	vColor.a = vAlpha;
	return vColor;
}
]] ) 
