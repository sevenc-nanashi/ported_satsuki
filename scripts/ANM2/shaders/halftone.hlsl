struct Constants {
  float size;
  float sizeThreshold;
  float alphaThreshold;
  float binarySize;
  float binaryAlpha;
  float scale;
  float rotation;
  float width;
  float height;
  float useSourceColor;
};

cbuffer constants : register(b0) { Constants constants; }

Texture2D srcTex : register(t0);
Texture2D figTex : register(t1);
SamplerState srcSmp : register(s0);

float2 cellCenter(float2 pixelPos, float2 imageSize, float size) {
  float2 centered = pixelPos - imageSize * 0.5;
  float2 cell = floor(centered / size);
  return cell * size + imageSize * 0.5 + size * 0.5;
}

float luma(float3 rgb) { return dot(rgb, float3(0.299, 0.587, 0.114)); }

float4 halftone(float4 pos : SV_Position, float2 uv : TEXCOORD0) : SV_TARGET {
  float size = max(constants.size, 1.0);
  float2 imageSize =
      max(float2(constants.width, constants.height), float2(1.0, 1.0));
  float2 center = clamp(
      cellCenter(pos.xy, imageSize, size),
      float2(0.5, 0.5),
      imageSize - float2(0.5, 0.5));
  float2 centerUv = center / imageSize;
  float4 src = srcTex.Sample(srcSmp, centerUv);

  float brightness = saturate(luma(src.rgb));
  float dotScale = constants.binarySize >= 0.5
                       ? step(constants.sizeThreshold, brightness)
                       : brightness;
  float alpha = constants.binaryAlpha >= 0.5 ? step(constants.alphaThreshold, src.a)
                                             : src.a;
  float totalScale = dotScale * max(constants.scale, 0.0);

  if (totalScale <= 0.0 || alpha <= 0.0) {
    return float4(0.0, 0.0, 0.0, 0.0);
  }

  float2 local = pos.xy - center;
  float s;
  float c;
  sincos(-constants.rotation, s, c);
  float2 rotated = float2(local.x * c - local.y * s, local.x * s + local.y * c);
  float2 figurePos = rotated / totalScale + size * 0.5;
  float2 figureUv = figurePos / size;
  float inside = step(0.0, figureUv.x) * step(0.0, figureUv.y) *
                 step(figureUv.x, 1.0) * step(figureUv.y, 1.0);
  float4 figure = figTex.Sample(srcSmp, figureUv) * inside;
  float3 color =
      constants.useSourceColor >= 0.5 ? src.rgb * figure.a : figure.rgb;

  return float4(color, figure.a * alpha);
}
