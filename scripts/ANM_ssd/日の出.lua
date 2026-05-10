--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:分割数
---min=4
---max=50
---step=1
local div = 10
---$track:割合
---min=0
---max=100
local ratio = 50
---$track:回転
---min=-720
---max=720
local r = 0
---$track:サイズ
---min=0
---max=2000
---step=1
local s = 200
---$color:色1
local col = 0xff0000

---$color:色2
local col2 = nil

---$figure:図形
local fig = "円"

---$track:横サイズ
---min=0
---max=2000
---step=1
local w = 800

---$track:縦サイズ
---min=0
---max=2000
---step=1
local h = 450

---$track:図形角度
---min=-3600
---max=3600
---step=0.01
---zero_label=
---scale=0.05
local figr = 0

---$track:中心X
---min=-4000
---max=4000
---step=0.01
local cx = 0

---$track:中心Y
---min=-4000
---max=4000
---step=0.01
local cy = 0

local val = ratio / 100

obj.setanchor("cx,cy", 1)
local l = math.sqrt((w + math.abs(cx)) ^ 2 + (h + math.abs(cy)) ^ 2) * 1.2

obj.setoption("drawtarget", "tempbuffer", w, h)

--背景色
if col2 ~= nil then
  obj.load("figure", "四角形", col2, 2)
  obj.drawpoly(-w / 2, -h / 2, 0, w / 2, -h / 2, 0, w / 2, h / 2, 0, -w / 2, h / 2, 0)
end

--光
local polygons = {}
for i = 0, div - 1 do
  local a = i / div
  local b = a + 1 / div * val
  local sr = r - 360 / div * val / 2 - 90
  local x1 = cx + l * math.cos(math.rad(sr + 360 * a))
  local y1 = cy + l * math.sin(math.rad(sr + 360 * a))
  local x2 = cx + l * math.cos(math.rad(sr + 360 * (a + b) / 2))
  local y2 = cy + l * math.sin(math.rad(sr + 360 * (a + b) / 2))
  local x3 = cx + l * math.cos(math.rad(sr + 360 * b))
  local y3 = cy + l * math.sin(math.rad(sr + 360 * b))
  table.insert(polygons, { x1, y1, 0, x2, y2, 0, x3, y3, 0, cx, cy, 0, 0, 0, 1, 0, 1, 1, 0, 1 })
end
obj.load("figure", "四角形", col, 2)
obj.drawpoly(polygons)

--図形
obj.load("figure", fig, col, s)
obj.draw(cx, cy, 0, 1, 1, 0, 0, r + figr)

obj.load("tempbuffer")
