struct Constants {
  float lineWidth;
  float period;
  float width;
  float height;
  float horizontalOnly;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float repeatFromCenter(float value, float size, float period) {
  float centered = value - size * 0.5;
  return centered - period * floor(centered / period);
}

float4 grid(float4 pos : SV_Position, float2 uv : TEXCOORD0) : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  float period = max(constants.period, 1.0);
  float lineWidth = clamp(constants.lineWidth, 0.0, period);
  float lineY = repeatFromCenter(pos.y, constants.height, period) < lineWidth ? 1.0 : 0.0;
  float lineX = repeatFromCenter(pos.x, constants.width, period) < lineWidth ? 1.0 : 0.0;
  float mask = max(lineY, lineX * (1.0 - step(0.5, constants.horizontalOnly)));

  return rgba * mask;
}
