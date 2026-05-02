struct Constants {
  float lineWidth;
  float period;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float4 scanline2(float4 pos : SV_Position, float2 uv : TEXCOORD0) : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  float period = max(constants.period, 1.0);
  float lineWidth = max(constants.lineWidth, 0.0);
  float line_ = fmod(pos.y, period) < lineWidth ? 1.0 : 0.0;

  return rgba * line_;
}
