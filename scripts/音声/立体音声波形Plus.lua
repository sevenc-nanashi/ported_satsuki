---$track:拡大率
---min=0
---max=800
local track0 = 100
---$track:高さ
---min=0
---max=800
local track1 = 100
---$track:分割数
---min=1
---max=1024
---step=1
local div = 50
---$track:奥行き
---min=0
---max=800
local track3 = 50
obj.effect()
hh = track1 / 100
s = track0 / 100
z = track3 / 2
buf = {}
n = obj.getaudio(buf, "audiobuffer", "spectrum", div)
w = obj.w / n
for i = 1, n do
	l = buf[i] / 10 * hh
	l = math.min(l, obj.h)
	x0 = ((i - 1) * w - obj.w / 2) * s
	y0 = (-l + obj.h / 2) * s
	x1 = (i * w - obj.w / 2) * s
	y2 = obj.h / 2 * s
	u0 = (i - 1) * w
	v0 = -l + obj.h
	u1 = i * w
	v2 = obj.h
	obj.drawpoly(x0, y0, -z, x1, y0, -z, x1, y2, -z, x0, y2, -z, u0, v0, u1, v0, u1, v2, u0, v2) --前
	obj.drawpoly(x0, y0, z, x1, y0, z, x1, y2, z, x0, y2, z, u0, v0, u1, v0, u1, v2, u0, v2) --後
	obj.drawpoly(x0, y0, -z, x0, y0, z, x0, y2, z, x0, y2, -z, u0, v0, u0, v0, u0, v2, u0, v2) --左
	obj.drawpoly(x1, y0, -z, x1, y0, z, x1, y2, z, x1, y2, -z, u1, v0, u1, v0, u1, v2, u1, v2) --右
	obj.drawpoly(x0, y0, -z, x1, y0, -z, x1, y0, z, x0, y0, z, u0, v0, u1, v0, u1, v0, u0, v0) --上
	obj.drawpoly(x0, y2, -z, x1, y2, -z, x1, y2, z, x0, y2, z, u0, v2, u1, v2, u1, v2, u0, v2) --下
end
