struct Constants {
  float cx;
  float cy;
  float angle;
  float width;
  float num;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float positiveMod(float x, float y) { return fmod(fmod(x, y) + y, y); }
float quantize(float value, float step) { return round(value / step) * step; }

static float PI = 3.14159265358979323846;
float4 extra_diagonal_clipping(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  uint width, height;
  srcTex.GetDimensions(width, height);
  float2 centerPos =
      float2(constants.cx, constants.cy) + float2(width, height) * 0.5;
  float angle = positiveMod(
      (atan2(pos.y - centerPos.y, pos.x - centerPos.x) - constants.angle),
      2 * PI);
  float quantizedAngle = quantize(angle, 2 * PI / constants.num) + constants.angle;

  float2 angleDir = float2(cos(quantizedAngle), sin(quantizedAngle));
  float2 vecToPixel = pos.xy - centerPos;
  float distance = angleDir.x * vecToPixel.y - angleDir.y * vecToPixel.x;
  float mask = clamp(abs(distance) - constants.width / 2, 0.0, 1.0);

  return rgba * mask;
}
