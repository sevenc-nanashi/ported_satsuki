---$track:分割数
---min=4
---max=50
---step=1
local div = 10
---$track:割合
---min=0
---max=100
local track1 = 50
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

---$color:色2(負値で透明)
local col2 = 0xffff00

---$figure:図形
local fig = "円"

---$value:横サイズ
local w = 800

---$value:縦サイズ
local h = 450

---$value:図形角度
local figr = 0

---$value:中心座標
local pos = {0,0}


local val = track1 / 100

obj.setanchor("pos", 1)
local cx = pos[1]
local cy = pos[2]
local l = math.sqrt((w + math.abs(cx)) ^ 2 + (h + math.abs(cy)) ^ 2) * 1.2

obj.setoption("drawtarget", "tempbuffer", w, h)

--背景色
if col2 >= 0 then
	obj.load("figure", "四角形", col2, 2)
	obj.drawpoly(-w / 2, -h / 2, 0, w / 2, -h / 2, 0, w / 2, h / 2, 0, -w / 2, h / 2, 0)
end

--光
obj.load("figure", "四角形", col, 2)
for i = 0, div - 1 do
	local a = i / div
	local b = a + 1 / div * val
	local sr = r - 360 / div * val / 2 - 90
	x1 = cx + l * math.cos(math.rad(sr + 360 * a))
	y1 = cy + l * math.sin(math.rad(sr + 360 * a))
	x2 = cx + l * math.cos(math.rad(sr + 360 * (a + b) / 2))
	y2 = cy + l * math.sin(math.rad(sr + 360 * (a + b) / 2))
	x3 = cx + l * math.cos(math.rad(sr + 360 * b))
	y3 = cy + l * math.sin(math.rad(sr + 360 * b))
	obj.drawpoly(cx, cy, 0, x1, y1, 0, x2, y2, 0, x3, y3, 0)
end

--図形
obj.load("figure", fig, col, s)
obj.draw(cx, cy, 0, 1, 1, 0, 0, r + figr)

obj.load("tempbuffer")
