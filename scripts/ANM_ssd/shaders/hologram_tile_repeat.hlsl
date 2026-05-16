struct Constants {
  float tileSize;
  float width;
  float height;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float4 hologram_tile_repeat(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float tileSize = max(constants.tileSize, 1.0);
  float2 centerOffset = float2(constants.width, constants.height) * 0.5;
  float2 tileUv = fmod(fmod(pos.xy - centerOffset + tileSize * 0.5, tileSize) + tileSize, tileSize) / tileSize;

  return srcTex.Sample(srcSmp, tileUv);
}
