struct Constants {
  float threshold;
};

cbuffer constants : register(b0) { Constants constants; }

Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float4 randomLineExApplyTexture(float4 pos : SV_Position,
                                float2 uv : TEXCOORD0) : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  float gray = dot(rgba.rgb, float3(0.298912, 0.58661, 0.114478));
  float binary = gray > constants.threshold / 255.0 ? 1.0 : 0.0;

  return float4(1.0, 1.0, 1.0, 1.0) * binary;
}
