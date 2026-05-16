struct Constants {
  float tileSize;
  float backgroundR;
  float backgroundG;
  float backgroundB;
  float checkR;
  float checkG;
  float checkB;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float rectMask(float2 localPos, float left, float top, float right, float bottom) {
  float insideX = step(left, localPos.x) * (1.0 - step(right, localPos.x));
  float insideY = step(top, localPos.y) * (1.0 - step(bottom, localPos.y));
  return insideX * insideY;
}

float3 blendCheck(float3 color, float3 checkColor, float mask) {
  return lerp(color, lerp(color, checkColor, 0.5), mask);
}

float4 check_pattern(float4 pos : SV_Position, float2 uv : TEXCOORD0) : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  float tileSize = max(constants.tileSize, 1.0);
  float2 tilePos = fmod(fmod(pos.xy, tileSize) + tileSize, tileSize);
  float2 localPos = tilePos - tileSize * 0.5;

  float3 color = float3(constants.backgroundR, constants.backgroundG, constants.backgroundB);
  float3 checkColor = float3(constants.checkR, constants.checkG, constants.checkB);

  color = blendCheck(color, checkColor, rectMask(localPos, -35.0, -52.0, 7.0, 52.0));
  color = blendCheck(color, checkColor, rectMask(localPos, -52.0, -7.0, 52.0, 35.0));
  color = blendCheck(color, checkColor, rectMask(localPos, -52.0, -52.0, 52.0, -51.0));
  color = blendCheck(color, checkColor, rectMask(localPos, 51.0, -52.0, 52.0, 52.0));
  color = blendCheck(color, checkColor, rectMask(localPos, -52.0, 51.0, 52.0, 52.0));
  color = blendCheck(color, checkColor, rectMask(localPos, -52.0, -52.0, -51.0, 52.0));

  return float4(color, rgba.a);
}
