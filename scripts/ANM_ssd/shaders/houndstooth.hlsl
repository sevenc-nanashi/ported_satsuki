struct Constants {
  float unitSize;
  float foregroundR;
  float foregroundG;
  float foregroundB;
  float backgroundR;
  float backgroundG;
  float backgroundB;
  float hasBackground;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

bool inBox(float2 p, float left, float top, float right, float bottom) {
  return p.x >= left && p.x < right && p.y >= top && p.y < bottom;
}

bool inPattern(float2 p) {
  if (inBox(p, -2.0, -2.0, -1.0, -1.0) && p.x + p.y <= -3.0) {
    return true;
  }
  if (inBox(p, 1.0, 1.0, 2.0, 2.0) && p.x + p.y >= 3.0) {
    return true;
  }
  if (inBox(p, -2.0, -2.0, 0.0, 0.0) && p.y >= -p.x - 2.0 && p.y <= -p.x - 1.0) {
    return true;
  }
  if (inBox(p, 0.0, 0.0, 2.0, 2.0) && p.y >= -p.x + 1.0 && p.y <= -p.x + 2.0) {
    return true;
  }
  if (inBox(p, 0.0, -2.0, 2.0, 0.0)) {
    return true;
  }

  return false;
}

float4 houndstooth(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  float unitSize = max(constants.unitSize, 0.001);
  float tileSize = unitSize * 4.0;
  float2 tilePos = fmod(fmod(pos.xy, tileSize) + tileSize, tileSize);
  float2 patternPos = tilePos / unitSize - 2.0;
  bool filled = inPattern(patternPos);

  float3 foreground = float3(constants.foregroundR, constants.foregroundG, constants.foregroundB);
  float3 background = float3(constants.backgroundR, constants.backgroundG, constants.backgroundB);
  if (filled) {
    return float4(foreground, rgba.a);
  }

  return float4(background, step(0.5, constants.hasBackground) * rgba.a);
}
