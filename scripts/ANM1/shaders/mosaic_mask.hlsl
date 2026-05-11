struct Constants {
  float size;
  float threshold;
  float random;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
Texture2D randomTex : register(t1);
SamplerState srcSmp : register(s0);

float rand01(float seed, float2 nonce) {
  uint width, height;
  randomTex.GetDimensions(width, height);
  float2 uv = fmod(nonce + seed, float2(width, height)) / float2(width, height);
  return randomTex.Sample(srcSmp, uv).r;
}

float4 mosaic_mask(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  uint width, height;
  srcTex.GetDimensions(width, height);

  float2 shiftedPos = pos.xy + float2(width, height) * 0.5;
  float2 ceiledPos = ceil(shiftedPos / constants.size) * constants.size;

  float2 cellCenter = ceiledPos - constants.size * 0.5;
  float mask = rand01(constants.random, cellCenter) < constants.threshold ? 1.0 : 0.0;

  return rgba * mask;
}
