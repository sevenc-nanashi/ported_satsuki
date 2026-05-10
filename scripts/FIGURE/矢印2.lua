--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:ライン幅
---min=1
---max=1000
local weight = 20
---$track:先端size
---min=0
---max=1000
---step=1
local tip_size = 50
---$track:頂点数
---min=2
---max=16
---step=1
local n = 2
---$color:色
local col = 0xffff00

---$figure:先端図形
local fig = "三角形"

---$check:両端を丸める
local maru = 0

---$value:座標
local pos = { -100, 0, 100, 0 }

local l = math.floor(weight) / 2
local s = tip_size / math.sqrt(2)
obj.setanchor("pos", n, "line")

-- 仮想バッファサイズ計算
local w = 0
local h = 0
for i = 0, n - 1 do
  local dx = math.ceil(math.abs(pos[i * 2 + 1]) + l + s + 1)
  local dy = math.ceil(math.abs(pos[i * 2 + 2]) + l + s + 1)
  if w < dx then
    w = dx
  end
  if h < dy then
    h = dy
  end
end
obj.setoption("drawtarget", "tempbuffer", w * 2, h * 2)
obj.load("figure", "四角形", col, 1)

-- ライン描画
-- obj.setoption("blend", "alpha_mix")
local x0 = pos[1]
local y0 = pos[2]
local polygons = {}
for i = 1, n - 1 do
  local x1 = pos[i * 2 + 1]
  local y1 = pos[i * 2 + 2]
  local r = math.atan2(y0 - y1, x1 - x0)
  local dx = math.sin(r) * l
  local dy = math.cos(r) * l
  -- obj.drawpoly(x0 - dx, y0 - dy, 0, x1 - dx, y1 - dy, 0, x1 + dx, y1 + dy, 0, x0 + dx, y0 + dy, 0)
  table.insert(polygons,
    { x0 - dx, y0 - dy, 0, x1 - dx, y1 - dy, 0, x1 + dx, y1 + dy, 0, x0 + dx, y0 + dy, 0, 0, 0, 1, 0, 1, 1, 0, 1 })
  x0 = x1
  y0 = y1
end
obj.drawpoly(polygons)

--先端描画
obj.load("figure", fig, col, s * 8)
local tip_x = {}
local tip_y = {}
local r = math.atan2(pos[2] - pos[4], pos[3] - pos[1])
for i = 1, 4 do
  tip_x[i] = pos[1] + math.cos(math.rad(-225 + (i - 1) * 90) - r) * s
  tip_y[i] = pos[2] + math.sin(math.rad(-225 + (i - 1) * 90) - r) * s
end
obj.drawpoly(tip_x[1], tip_y[1], 0, tip_x[2], tip_y[2], 0, tip_x[3], tip_y[3], 0, tip_x[4], tip_y[4], 0)

-- 頂点描画
obj.load("figure", "円", col, l * 8)
local polygons2 = {}
for i = 1 - maru, n - 2 + maru do
  x0 = pos[i * 2 + 1]
  y0 = pos[i * 2 + 2]
  table.insert(polygons2, { x0 - l, y0 - l, 0, x0 + l, y0 - l, 0, x0 + l, y0 + l, 0, x0 - l, y0 + l, 0,
    0, 0, l * 8, 0, l * 8, l * 8, 0, l * 8 })
end
if #polygons2 > 0 then
  obj.drawpoly(polygons2)
end

obj.setoption("blend", "none")
obj.load("tempbuffer")
