
struct Constants {
  float flip;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
Texture2D maskTex : register(t1);
SamplerState srcSmp : register(s0);

float4 transform_mask(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  float4 mask = maskTex.Sample(srcSmp, uv);
  float maskValue = mask.r;
  return rgba * (constants.flip >= 0.5 ? maskValue : 1.0 - maskValue);
}
