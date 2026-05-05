struct Constants {
  float lineWidth;
  float alpha;
  float red;
  float green;
  float blue;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float4 tv_on_off_scanline(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  float lineWidth = max(constants.lineWidth, 1.0);
  float period = lineWidth * 2.0;
  float stripe = fmod(pos.y, period) < lineWidth ? 1.0 : 0.0;
  float alpha = saturate(constants.alpha) * stripe;
  float3 color = float3(constants.red, constants.green, constants.blue);

  return float4(lerp(rgba.rgb, color, alpha), rgba.a);
}
