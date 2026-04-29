--track0:サイズ,5,500,50,1
--track1:半径,0,2000,100
--track2:中心X,-2000,2000,0
--track3:中心Y,-2000,2000,0
--check0:反転,0

obj.copybuffer("tmp", "obj")
s = obj.track0
r = obj.track1
cx = -obj.track2
cy = -obj.track3

w = obj.w / obj.getvalue("zoom") * 100
h = obj.h / obj.getvalue("zoom") * 100
nx = math.ceil(w / s / 2)
ny = math.ceil(h / s / 2)
obj.load("figure", "四角形", 0xffffff, s)
obj.setoption("dst", "tmp")
obj.setoption("blend", "alpha_sub")
for j = -ny, ny do
	y = j * s
	for i = -nx, nx do
		x = i * s
		a = 0.5
		if obj.check0 then
			a = -0.5
		end
		l = math.sqrt((x + cx) ^ 2 + (y + cy) ^ 2)
		if l < r then
			alp = 0.5 + a
		else
			alp = 0.5 - a
		end
		obj.draw(x, y, 0, 1, alp)
	end
end
obj.load("tempbuffer")
