--track0:拡大率,0,800,100
--track1:高さ,0,800,100
--track2:分割数,1,1024,50,1
--track3:奥行き,0,800,50
obj.effect()
div = obj.track2
hh = obj.track1 / 100
s = obj.track0 / 100
z = obj.track3 / 2
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
