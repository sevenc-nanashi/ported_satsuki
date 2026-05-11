struct Constants {
  float width;
  float height;
  float offset;
  float top;
  float bottom;
  float left;
  float right;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float positiveMod(float x, float y) { return fmod(fmod(x, y) + y, y); }

float triangleMask(float phase, float depth, float width, float height) {
  if (height <= 0.0 || depth < 0.0 || depth > height) {
    return 0.0;
  }

  float halfWidth = width * (1.0 - depth / height);
  return abs(phase - width) <= halfWidth ? 1.0 : 0.0;
}

float4 triangle_clipping(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  uint texWidth, texHeight;
  srcTex.GetDimensions(texWidth, texHeight);

  float2 size = float2(texWidth, texHeight);
  float2 p = pos.xy - size * 0.5;
  float period = max(constants.width * 2.0, 1.0);
  float clip = 0.0;

  if (constants.top >= 0.5) {
    float phase = positiveMod(p.x + size.x * 0.5 - constants.offset, period);
    float depth = p.y + size.y * 0.5;
    clip = max(clip, triangleMask(phase, depth, constants.width, constants.height));
  }

  if (constants.bottom >= 0.5) {
    float phase = positiveMod(size.x * 0.5 - p.x - constants.offset, period);
    float depth = size.y * 0.5 - p.y;
    clip = max(clip, triangleMask(phase, depth, constants.width, constants.height));
  }

  if (constants.left >= 0.5) {
    float phase = positiveMod(p.y + size.y * 0.5 + constants.offset, period);
    float depth = p.x + size.x * 0.5;
    clip = max(clip, triangleMask(phase, depth, constants.width, constants.height));
  }

  if (constants.right >= 0.5) {
    float phase = positiveMod(size.y * 0.5 - p.y + constants.offset, period);
    float depth = size.x * 0.5 - p.x;
    clip = max(clip, triangleMask(phase, depth, constants.width, constants.height));
  }

  return rgba * (1.0 - clip);
}
