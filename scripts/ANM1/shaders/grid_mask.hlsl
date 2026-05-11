struct Constants {
  float size;
  float ratio;
  float flip;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float4 grid_mask(float4 pos : SV_Position, float2 uv : TEXCOORD0) : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  uint width, height;
  srcTex.GetDimensions(width, height);

  float2 shiftedPos = pos.xy - float2(width, height) * 0.5;
  float2 cellPosition = fmod(fmod(shiftedPos, constants.size) + constants.size, constants.size);

  float2 distanceToEdge = min(cellPosition, constants.size - cellPosition);
  float mask = step(min(distanceToEdge.x, distanceToEdge.y),
                    constants.size * constants.ratio / 2);

  return rgba * (constants.flip >= 0.5 ? mask : 1.0 - mask);
}
