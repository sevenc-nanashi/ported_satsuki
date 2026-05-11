struct Constants {
  float blend;
  float cx;
  float cy;
  float width;
  float angle;
  float nDivs;
  float col1R;
  float col1G;
  float col1B;
  float col2Opaque;
  float col2R;
  float col2G;
  float col2B;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float4 quantized_gradation(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  uint width, height;
  srcTex.GetDimensions(width, height);
  int2 centerPos = int2(constants.cx, constants.cy) + int2(uint2(width, height) / 2);
  float2 direction = float2(cos(constants.angle), sin(constants.angle));
  float2 vecToPixel = pos.xy - centerPos;
  float distance = direction.x * vecToPixel.y - direction.y * vecToPixel.x;
  float centeredPhase = clamp(distance / constants.width, -1.0, 1.0);
  float phase = centeredPhase * 2 + 0.5;
  float quantizedPhase = round(phase * constants.nDivs) / constants.nDivs;

  float4 col1 = float4(constants.col1R, constants.col1G, constants.col1B, 1.0);
  float4 col2 = float4(constants.col2R, constants.col2G, constants.col2B, constants.col2Opaque);
  float4 gradationCol = lerp(col1, col2, quantizedPhase);

  return lerp(rgba, gradationCol * rgba.a, constants.blend * gradationCol.a);
}
