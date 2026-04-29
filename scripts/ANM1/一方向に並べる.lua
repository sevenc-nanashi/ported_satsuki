--track0:個数,1,200,5,1
--track1:間隔,-1000,1000,50
--track2:角度,-720,720,0
--track3:回転軸,0,2,0,1
--check0:双方向,sou=0
obj.effect()
n = obj.track0
l = obj.track1
r = obj.track2 + 90
w, h = obj.w, obj.h
aa = 0
bb = n - 1
if obj.check0 then
	aa = -n + 1
	bb = n - 1
end
for i = aa, bb do
	sin = math.sin(r * math.pi / 180) * l * i
	cos = -math.cos(r * math.pi / 180) * l * i
	if obj.track3 < 1 then
		cx = sin
		cy = cos
		z = 0
	elseif obj.track3 < 2 then
		cx = sin
		cy = 0
		z = cos
	else
		cx = 0
		cy = cos
		z = sin
	end
	x0, x1 = cx - w / 2, cx + w / 2
	y0, y2 = cy - h / 2, cy + h / 2
	obj.drawpoly(x0, y0, z, x1, y0, z, x1, y2, z, x0, y2, z)
end
