--track0:屈曲率,10,500,10
--track1:中心[%],-100,100,0
--dialog:縦ロール/chk,tate=0;反転/chk,hanten=0;軸を中心に/chk,m=0;分割数,n=28;
obj.effect()
nd = n * obj.track0 / 10
c = math.floor(n / 2 * obj.track1 / 100)
if tate == 0 then
	r = obj.w / n / math.sin(math.pi * 2 / nd)
	if hanten == 1 then
		obj.effect("反転", "左右反転", "1")
		obj.ry = 180
	end
	y0 = -obj.h / 2
	y1 = obj.h / 2
	v0 = 0
	v1 = obj.h
	for x = -n / 2 + c, n / 2 + c - 1 do
		x0 = r * math.sin(math.pi * 2 * x / nd)
		x1 = r * math.sin(math.pi * 2 * (x + 1) / nd)
		z0 = -r * math.cos(math.pi * 2 * x / nd) + r * (1 - m)
		z1 = -r * math.cos(math.pi * 2 * (x + 1) / nd) + r * (1 - m)
		u0 = obj.w * (x + n / 2 - c) / n
		u1 = obj.w * (x + n / 2 + 1 - c) / n
		obj.drawpoly(x0, y0, z0, x1, y0, z1, x1, y1, z1, x0, y1, z0, u0, v0, u1, v0, u1, v1, u0, v1)
	end
else
	r = obj.h / n / math.sin(math.pi * 2 / nd)
	if hanten == 1 then
		obj.effect("反転", "上下反転", "1")
		obj.rx = 180
	end
	x0 = -obj.w / 2
	x1 = obj.w / 2
	u0 = 0
	u1 = obj.w
	for y = -n / 2 + c, n / 2 + c - 1 do
		y0 = r * math.cos(math.pi * (2 * y / nd - 0.5))
		y1 = r * math.cos(math.pi * (2 * (y + 1) / nd - 0.5))
		z0 = r * math.sin(math.pi * (2 * y / nd - 0.5)) + r * (1 - m)
		z1 = r * math.sin(math.pi * (2 * (y + 1) / nd - 0.5)) + r * (1 - m)
		v0 = obj.h * (y + n / 2 - c) / n
		v1 = obj.h * (y + n / 2 - c + 1) / n
		obj.drawpoly(x0, y0, z0, x1, y0, z0, x1, y1, z1, x0, y1, z1, u0, v0, u1, v0, u1, v1, u0, v1)
	end
end
