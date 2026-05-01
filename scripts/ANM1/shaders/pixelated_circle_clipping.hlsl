struct Constants {
  float size;
  float radius;
  float centerX;
  float centerY;
  float width;
  float height;
  float flip;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float4 pixelated_circle_clipping(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  float size = max(constants.size, 1.0);
  float2 pixelPos = pos.xy - float2(constants.width, constants.height) * 0.5;
  float2 cellCenter = round(pixelPos / size) * size;
  float2 distanceFromCenter =
      cellCenter - float2(constants.centerX, constants.centerY);
  float inside = length(distanceFromCenter) < constants.radius ? 1.0 : 0.0;
  float mask = constants.flip >= 0.5 ? 1.0 - inside : inside;

  return rgba * mask;
}
