--track0:X間隔,-1000,1000,100
--track1:Y間隔,-1000,1000,100
--track2:X個数,1,100,5,1
--track3:Y個数,1,100,3,1
obj.effect()
nx = obj.track2
ny = obj.track3
gx = obj.track0 / 100 - (1 - math.cos(math.pi * 30 / 180))
gy = obj.track1 / 100 - (1 - math.sin(math.pi * 30 / 180) * 1.5)
w = obj.w
h = obj.h
for j = 0, ny - 1 do
	y0 = -(ny + (ny - 1) * (gy - 1)) * h / 2 + h * j * gy
	y2 = -(ny + (ny - 1) * (gy - 1)) * h / 2 + h * (j * gy + 1)
	for i = 0, nx - 1 do
		x0 = -(nx + (nx - 1) * (gx - 1)) * w / 2 + w * i * gx
		x1 = -(nx + (nx - 1) * (gx - 1)) * w / 2 + w * (i * gx + 1)
		if j % 2 == 0 then
			x0 = x0 + w / 2 * gx
			x1 = x1 + w / 2 * gx
		end
		obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, 0, 0, w, 0, w, h, 0, h)
	end
end
