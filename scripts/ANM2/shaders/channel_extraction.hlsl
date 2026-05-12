
struct Constants {
  float channel;
  float blend;
  float saturate;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float4 channel_extraction(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  float3 blended;
  if (constants.channel >= 2.5) {
    blended = float3(0.0, 0.0, rgba.b);
  } else if (constants.channel >= 1.5) {
    blended = float3(0.0, rgba.g, 0.0);
  } else {
    blended = float3(rgba.r, 0.0, 0.0);
  }
  blended *= constants.blend;
  float3 result = constants.saturate > 0.5 ? saturate(blended) : blended;

  return float4(result, saturate(rgba.a * constants.blend));
}
