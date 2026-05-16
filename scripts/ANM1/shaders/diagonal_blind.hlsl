struct Constants {
  float blindWidth;
  float angle;
  float progress;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float distanceToLine(float2 basePoint, float2 lineDir, float2 targetPoint) {
  float2 vecToTarget = targetPoint - basePoint;
  return lineDir.x * vecToTarget.y - lineDir.y * vecToTarget.x;
}

float4 diagonal_blind(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  uint width, height;
  srcTex.GetDimensions(width, height);

  float2 pixelPos = pos.xy - float2(width, height) * 0.5;
  float2 normal = float2(cos(constants.angle), sin(constants.angle));
  float distance = distanceToLine(float2(0, 0), normal, pixelPos);
  float cycle =
      fmod(fmod(distance, constants.blindWidth) + constants.blindWidth,
           constants.blindWidth) /
      constants.blindWidth;
  float mask = 1.0 - step(cycle, constants.progress);

  return rgba * mask;
}
