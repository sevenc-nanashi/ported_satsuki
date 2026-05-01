---$track:行数
---min=1
---max=256
---step=1
local n = 5
---$track:範囲
---min=0
---max=1000
local track1 = 100
---$track:移動速度
---min=0
---max=1000
local track2 = 0
---$track:回転速度
---min=0
---max=1000
local track3 = 0
---$value:X軸範囲[%]
local wx = 100

---$value:Y軸範囲[%]
local wy = 100

---$value:Z軸範囲[%]
local wz = 100

---$check:Z回転
local kz = 1

---$value:拡大最小[-%]
local s_min = 0

obj.effect()
w = obj.w / 2
h = obj.h / 2 / n
W = obj.screen_w / 2
H = obj.screen_h / 2
wh = track1 / 100 --範囲
v = track2 / 100 --移動速度
vr = track3 / 100 --回転速度

for i = 0, n - 1 do
	cx = (obj.rand(-W - w, W + w, i, 0) * wh + obj.rand(-100, 100, i, 3) * obj.time * v) * wx / 100
	cy = (obj.rand(-H - h, H + h, i, 1) * wh + obj.rand(-100, 100, i, 4) * obj.time * v) * wy / 100
		- obj.h / 2
		+ h
		+ h * 2 * i
	cz = (obj.rand(-W - w, W + w, i, 2) * wh + obj.rand(-100, 100, i, 5) * obj.time * v) * wz / 100
	l = math.sqrt(w ^ 2 + h ^ 2) * (1 + obj.rand(100 - s_min, 100, i, 6) / 100)
	r = math.rad((obj.rand(0, 360, i, 9) + obj.rand(-100, 100, i, 12) * obj.time * vr)) * kz
	x0 = cx + math.cos(math.atan2(-h, -w) + r) * l
	x1 = cx + math.cos(math.atan2(-h, w) + r) * l
	x2 = cx + math.cos(math.atan2(h, w) + r) * l
	x3 = cx + math.cos(math.atan2(h, -w) + r) * l
	y0 = cy + math.sin(math.atan2(-h, -w) + r) * l
	y1 = cy + math.sin(math.atan2(-h, w) + r) * l
	y2 = cy + math.sin(math.atan2(h, w) + r) * l
	y3 = cy + math.sin(math.atan2(h, -w) + r) * l
	v0 = h * 2 * i
	v1 = h * 2 * (i + 1)
	obj.drawpoly(x0, y0, cz, x1, y1, cz, x2, y2, cz, x3, y3, cz, 0, v0, w * 2, v0, w * 2, v1, 0, v1)
end
