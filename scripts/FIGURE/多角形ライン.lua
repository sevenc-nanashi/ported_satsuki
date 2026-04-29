--track0:半径,1,2000,200
--track1:ライン幅,0,2000,10
--track2:辺数,3,24,4,1
--track3:回転数,1,10,1,1
--color:0xffffff
l = obj.track0
w = obj.track1
n = math.floor(obj.track2)
m = math.floor(obj.track3)
if w >= l then
	w = l
end
obj.load("figure", "四角形", color, 2)
obj.setoption("dst", "tmp", l * 2, l * 2)
obj.setoption("blend", "alpha_add")
for i = 0, n - 1 do
	r0 = math.rad(m * 360 * i / n)
	r1 = math.rad(m * 360 * (i + 1) / n)
	x0 = math.cos(r0) * l
	x1 = math.cos(r1) * l
	x2 = math.cos(r1) * l * (1 - w / l)
	x3 = math.cos(r0) * l * (1 - w / l)
	y0 = math.sin(r0) * l
	y1 = math.sin(r1) * l
	y2 = math.sin(r1) * l * (1 - w / l)
	y3 = math.sin(r0) * l * (1 - w / l)
	obj.drawpoly(x0, y0, 0, x1, y1, 0, x2, y2, 0, x3, y3, 0, 0, 0, 1, 0, 1, 1, 0, 1)
end
obj.load("tempbuffer")
