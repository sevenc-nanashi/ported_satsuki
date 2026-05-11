struct Constants {
  float size;
  float ratio;
  float angle;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float2 rotate(float2 point_, float angle) {
  float cosA = cos(angle);
  float sinA = sin(angle);
  return float2(point_.x * cosA - point_.y * sinA,
                point_.x * sinA + point_.y * cosA);
}

float4 old_grid_mask(float4 pos : SV_Position, float2 uv : TEXCOORD0) : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  uint width, height;
  srcTex.GetDimensions(width, height);

  int2 numCells = int2(floor(width / constants.size), floor(height / constants.size));

  float2 shiftedPos =
      rotate(pos.xy - float2(width, height) * 0.5, constants.angle);
  float2 cellPosition =
      fmod(fmod(shiftedPos, constants.size) + constants.size, constants.size);
  int2 cellIndex = int2(shiftedPos / constants.size);

  if (abs(cellIndex.x) * 2 + 2 > numCells.x || abs(cellIndex.y) * 2 + 2 > numCells.y) {
    return float4(0, 0, 0, 0);
  }

  float2 distanceToEdge = min(cellPosition, constants.size - cellPosition);
  float mask = step(min(distanceToEdge.x, distanceToEdge.y),
                    constants.size * constants.ratio / 2);

  return rgba * (1.0 - mask);
}
