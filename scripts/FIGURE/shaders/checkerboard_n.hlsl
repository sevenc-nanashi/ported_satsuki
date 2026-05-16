struct Constants {
  float squareSize;
  float color1R;
  float color1G;
  float color1B;
  float color2R;
  float color2G;
  float color2B;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float4 checkerboard_n(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  float squareSize = max(constants.squareSize, 1.0);
  float2 cell = floor(pos.xy / squareSize);
  float parity = fmod(cell.x + cell.y, 2.0);
  float3 color1 = float3(constants.color1R, constants.color1G, constants.color1B);
  float3 color2 = float3(constants.color2R, constants.color2G, constants.color2B);

  return float4(lerp(color1, color2, parity), rgba.a);
}
