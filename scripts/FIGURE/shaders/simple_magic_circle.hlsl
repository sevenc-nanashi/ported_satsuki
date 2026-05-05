struct Constants {
  float size;
  float radius;
  float lineWidth;
  float circleWidth;
  float rotation;
  float vertexCount;
  float stepCount;
  float drawSecondFigure;
};

cbuffer constants : register(b0) { Constants constants; }
Texture2D srcTex : register(t0);
SamplerState srcSmp : register(s0);

float2 rotatePoint(float2 p, float degree) {
  float rad = radians(degree);
  float s = sin(rad);
  float c = cos(rad);
  return float2(c * p.x - s * p.y, s * p.x + c * p.y);
}

float distanceToSegment(float2 p, float2 a, float2 b) {
  float2 ab = b - a;
  float t = saturate(dot(p - a, ab) / max(dot(ab, ab), 0.0001));
  return length(p - (a + ab * t));
}

float polygonLine(float2 p, float radius, float lineWidth, int vertexCount, float stepCount) {
  float mask = 0.0;

  [unroll]
  for (int i = 0; i < 9; i++) {
    if (i < vertexCount) {
      float r0 = radians(stepCount * 360.0 * i / vertexCount);
      float r1 = radians(stepCount * 360.0 * (i + 1) / vertexCount);
      float2 a = float2(cos(r0), sin(r0)) * radius;
      float2 b = float2(cos(r1), sin(r1)) * radius;
      mask = max(mask, 1.0 - smoothstep(lineWidth * 0.5, lineWidth * 0.5 + 1.0, distanceToSegment(p, a, b)));
    }
  }

  return mask;
}

float circleLine(float2 p, float radius, float lineWidth) {
  float d = abs(length(p) - radius);
  return 1.0 - smoothstep(lineWidth * 0.5, lineWidth * 0.5 + 1.0, d);
}

float4 simple_magic_circle(float4 pos : SV_Position, float2 uv : TEXCOORD0) : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);
  float2 p = pos.xy - constants.size * 0.5;
  int vertexCount = (int)round(constants.vertexCount);
  float lineWidth = max(constants.lineWidth, 0.0);
  float circleWidth = max(constants.circleWidth, 0.0);

  float polygon = polygonLine(rotatePoint(p, -constants.rotation), constants.radius, lineWidth, vertexCount, constants.stepCount);
  float secondRotation = constants.rotation - 180.0 / max(constants.vertexCount, 1.0);
  float secondPolygon = polygonLine(rotatePoint(p, secondRotation), constants.radius, lineWidth, vertexCount, constants.stepCount);
  polygon = max(polygon, secondPolygon * step(0.5, constants.drawSecondFigure));

  float innerCircle = circleLine(p, constants.radius + circleWidth / 3.0, circleWidth * 2.0 / 3.0);
  float outerCircle = circleLine(p, constants.size * 0.5, circleWidth);
  float mask = saturate(polygon + innerCircle + outerCircle);

  return float4(rgba.rgb * mask, rgba.a * mask);
}
