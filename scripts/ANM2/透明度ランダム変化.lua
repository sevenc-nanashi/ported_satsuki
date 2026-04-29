--track0:X間隔,-1000,1000,100
--track1:Y間隔,-1000,1000,100
--track2:X個数,1,100,5,1
--track3:Y個数,1,100,3,1
--dialog:間隔[s],f=0.5;透明最小値[%],m=0;
nx = obj.track2
ny = obj.track3
gx = obj.track0 / 100
gy = obj.track1 / 100
w = obj.w
h = obj.h
w_size = (nx + (nx - 1) * (gx - 1)) * w
h_size = (ny + (ny - 1) * (gy - 1)) * h
obj.setoption("dst", "tmp", w_size, h_size)
for j = 0, ny - 1 do
	y0 = -h_size / 2 + h * j * gy
	y2 = -h_size / 2 + h * (j * gy + 1)
	for i = 0, nx - 1 do
		x0 = -w_size / 2 + w * i * gx
		x1 = -w_size / 2 + w * (i * gx + 1)
		ran = obj.rand(0, 100, j, i)
		alp = obj.rand(m, 100, ran, ran + math.floor(obj.time / f)) / 100
		obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, 0, 0, obj.w, 0, obj.w, obj.h, 0, obj.h, alp)
	end
end
obj.load("tempbuffer")
