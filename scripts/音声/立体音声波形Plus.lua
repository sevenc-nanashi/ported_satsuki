--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:拡大率
---min=0
---max=800
local scale = 100
---$track:高さ
---min=0
---max=800
local height = 100
---$track:分割数
---min=1
---max=1024
---step=1
local div = 50
---$track:奥行き
---min=0
---max=800
local length = 50
obj.effect()
local hh = height / 100
local s = scale / 100
local z = length / 2
local buf = {}
local n = obj.getaudio(buf, "audiobuffer", "spectrum", div)
local w = obj.w / n
local polygons = {}
for i = 1, n do
  local l = buf[i] / 10 * hh
  l = math.min(l, obj.h)
  local x0 = ((i - 1) * w - obj.w / 2) * s
  local y0 = (-l + obj.h / 2) * s
  local x1 = (i * w - obj.w / 2) * s
  local y2 = obj.h / 2 * s
  local u0 = (i - 1) * w
  local v0 = -l + obj.h
  local u1 = i * w
  local v2 = obj.h
  table.insert(polygons, { x0, y0, -z, x1, y0, -z, x1, y2, -z, x0, y2, -z, u0, v0, u1, v0, u1, v2, u0, v2 }) --前
  table.insert(polygons, { x0, y0, z, x1, y0, z, x1, y2, z, x0, y2, z, u0, v0, u1, v0, u1, v2, u0, v2 })  --後
  table.insert(polygons, { x0, y0, -z, x0, y0, z, x0, y2, z, x0, y2, -z, u0, v0, u0, v0, u0, v2, u0, v2 }) --左
  table.insert(polygons, { x1, y0, -z, x1, y0, z, x1, y2, z, x1, y2, -z, u1, v0, u1, v0, u1, v2, u1, v2 }) --右
  table.insert(polygons, { x0, y0, -z, x1, y0, -z, x1, y0, z, x0, y0, z, u0, v0, u1, v0, u1, v0, u0, v0 }) --上
  table.insert(polygons, { x0, y2, -z, x1, y2, -z, x1, y2, z, x0, y2, z, u0, v2, u1, v2, u1, v2, u0, v2 }) --下
end
obj.drawpoly(polygons)
