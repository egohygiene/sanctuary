Texture2D shaderTexture;
SamplerState SampleType;

struct PS_INPUT
{
	float4 Position   : SV_POSITION;
	float2 Texture    : TEXCOORD0;
};

float4 main(PS_INPUT In) : SV_TARGET
{
	float2 newCoords;

//	newCoords = float2(In.Texture.x, In.Texture.y / 2.0); //SBS UP DOWN
	newCoords = float2(In.Texture.x / 2.0, In.Texture.y); //SBS LEFT RIGHT
	
	float4 rgba;

	rgba = shaderTexture.Sample(SampleType, newCoords);

	return rgba;
}
