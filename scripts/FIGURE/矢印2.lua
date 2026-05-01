--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:ライン幅
---min=1
---max=1000
local track0 = 20
---$track:先端size
---min=0
---max=1000
---step=1
local track1 = 50
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
local pos = {-100,0,100,0}


l = math.floor(track0) / 2
s = track1 / math.sqrt(2)
obj.setanchor("pos", n, "line")

-- 仮想バッファサイズ計算
w = 0
h = 0
for i = 0, n - 1 do
	dx = math.ceil(math.abs(pos[i * 2 + 1]) + l + s + 1)
	dy = math.ceil(math.abs(pos[i * 2 + 2]) + l + s + 1)
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
obj.setoption("blend", "alpha_mix")
x0 = pos[1]
y0 = pos[2]
for i = 1, n - 1 do
	x1 = pos[i * 2 + 1]
	y1 = pos[i * 2 + 2]
	r = math.atan2(y0 - y1, x1 - x0)
	dx = math.sin(r) * l
	dy = math.cos(r) * l
	obj.drawpoly(x0 - dx, y0 - dy, 0, x1 - dx, y1 - dy, 0, x1 + dx, y1 + dy, 0, x0 + dx, y0 + dy, 0)
	x0 = x1
	y0 = y1
end

--先端描画
obj.load("figure", fig, col, s * 8)
sx = {}
sy = {}
r = math.atan2(pos[2] - pos[4], pos[3] - pos[1])
for i = 1, 4 do
	sx[i] = pos[1] + math.cos(math.rad(-225 + (i - 1) * 90) - r) * s
	sy[i] = pos[2] + math.sin(math.rad(-225 + (i - 1) * 90) - r) * s
end
obj.drawpoly(sx[1], sy[1], 0, sx[2], sy[2], 0, sx[3], sy[3], 0, sx[4], sy[4], 0)

-- 頂点描画
obj.load("figure", "円", col, l * 8)
for i = 1 - maru, n - 2 + maru do
	x0 = pos[i * 2 + 1]
	y0 = pos[i * 2 + 2]
	obj.drawpoly(x0 - l, y0 - l, 0, x0 + l, y0 - l, 0, x0 + l, y0 + l, 0, x0 - l, y0 + l, 0)
end

obj.setoption("blend", 0)
obj.load("tempbuffer")
