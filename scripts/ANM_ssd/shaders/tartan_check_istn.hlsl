struct Constants {
  float scale;
  float backgroundR;
  float backgroundG;
  float backgroundB;
  float thick1R;
  float thick1G;
  float thick1B;
  float thick2R;
  float thick2G;
  float thick2B;
  float thinR;
  float thinG;
  float thinB;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

bool isHorizontalStripe(float y, float start, float width) {
  return y >= start && y < start + width;
}

bool isThinHorizontalStripe(float y) {
  return isHorizontalStripe(y, 6.0, 2.0) ||
         isHorizontalStripe(y, 48.0, 2.0) ||
         isHorizontalStripe(y, 56.0, 2.0) ||
         isHorizontalStripe(y, 74.0, 2.0) ||
         isHorizontalStripe(y, 128.0, 2.0);
}

bool isThinVerticalStripe(float x, float rowParity) {
  float shiftedX = x - rowParity;
  return shiftedX >= 0.0 && shiftedX < 1.0 ||
         shiftedX >= 54.0 && shiftedX < 55.0 ||
         shiftedX >= 72.0 && shiftedX < 73.0 ||
         shiftedX >= 80.0 && shiftedX < 81.0 ||
         shiftedX >= 122.0 && shiftedX < 123.0;
}

bool isAlternatingLine(float x, float parity) {
  return fmod(floor(x - parity) + 130.0, 2.0) < 1.0;
}

float3 tartanColor(float2 tilePos) {
  float x = floor(tilePos.x);
  float y = floor(tilePos.y);
  float rowParity = fmod(y + 1.0, 2.0);
  float horizontalParity = fmod(y, 2.0);
  float3 color =
      float3(constants.backgroundR, constants.backgroundG, constants.backgroundB);

  float redVerticalX = x - rowParity - 2.0;
  if (redVerticalX >= 0.0 && redVerticalX < 30.0 &&
      fmod(floor(redVerticalX), 2.0) < 1.0) {
    color = float3(constants.thick1R, constants.thick1G, constants.thick1B);
  }
  if (y >= 98.0 && y < 128.0 && isAlternatingLine(x, horizontalParity)) {
    color = float3(constants.thick1R, constants.thick1G, constants.thick1B);
  }

  float yellowVerticalX = x - rowParity - 38.0;
  if (yellowVerticalX >= 0.0 && yellowVerticalX < 34.0 &&
      fmod(floor(yellowVerticalX), 2.0) < 1.0) {
    color = float3(constants.thick2R, constants.thick2G, constants.thick2B);
  }
  if (y >= 58.0 && y < 92.0 && isAlternatingLine(x, horizontalParity)) {
    color = float3(constants.thick2R, constants.thick2G, constants.thick2B);
  }

  if (isThinVerticalStripe(x, rowParity) ||
      (isThinHorizontalStripe(y) && isAlternatingLine(x, horizontalParity))) {
    color = float3(constants.thinR, constants.thinG, constants.thinB);
  }

  return color;
}

float4 tartan_check_istn(float4 pos : SV_Position, float2 uv : TEXCOORD0)
    : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  float scale = max(constants.scale, 0.001);
  float tileSize = 130.0 * scale;
  float2 tilePos =
      fmod(fmod(pos.xy + 65.0 * scale, tileSize) + tileSize, tileSize) /
      scale;

  return float4(tartanColor(tilePos), rgba.a);
}
