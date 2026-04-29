--track0:個数,0,100,10,1
--track1:距離,0,2000,200
--track2:時間[s],-5,5,0.3,0.01
--track3:間隔[s],0,5,0.3,0.01
--check0:外向き,0
obj.effect()
n = obj.track0
l = obj.track1
a = obj.track2
b = obj.track3
for i = 0, n - 1 do
	if a == 0 then
		return
	elseif a < 0 then
		t = (a - (n - 1) * b - obj.time + obj.totaltime + i * b) / a
	else
		t = (a - obj.time + i * b) / a
	end
	t = math.min(1, math.max(t, 0))
	r = 360 * i / n
	x = math.sin(r * math.pi / 180) * l
	y = -math.cos(r * math.pi / 180) * l
	rz = 360 * i / n
	if obj.check0 then
		x = -x
		rz = -rz - 180
	end
	obj.draw(x, y, 0, 1, 1 - t, 0, 0, rz)
end
