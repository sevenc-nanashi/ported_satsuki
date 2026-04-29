---$track:行数
---min=1
---max=256
---step=1
local n = 5
---$track:移動速度
---min=-1000
---max=1000
local track1 = 100
---$track:X軸範囲
---min=0
---max=1000
local track2 = 100
---$track:Y軸範囲
---min=0
---max=1000
local track3 = 100
--dialog:Z軸範囲[%],wz=0;拡大最小[-%],s_min=0;速度最小[-%],vx_min=0;
obj.effect()
w = obj.w / 2
h = obj.h / 2 / n
W = obj.screen_w / 2
H = obj.screen_h / 2
wx = track2 / 100 --X軸範囲
wy = track3 / 100 --Y軸範囲
v = -track1 / 100 --移動速度

for i = 0, n - 1 do
	cx = obj.rand(-W - w, W + w, i, 0) * wx + obj.rand(100 - vx_min, 100, i, 4) * obj.time * v
	cy = obj.rand(-H - h, H + h, i, 1) * wy - obj.h / 2 + h + h * 2 * i
	cz = obj.rand(-W - w, W + w, i, 2) * wz / 100
	s = obj.rand(100 - s_min, 100, i, 3) / 100
	x0 = cx - w * s
	x1 = cx + w * s
	y0 = cy - h * s
	y2 = cy + h * s
	v0 = h * 2 * i
	v1 = h * 2 * (i + 1)
	obj.drawpoly(x0, y0, cz, x1, y0, cz, x1, y2, cz, x0, y2, cz, 0, v0, w * 2, v0, w * 2, v1, 0, v1)
end
