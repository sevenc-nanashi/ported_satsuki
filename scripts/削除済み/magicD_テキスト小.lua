--track0:半径調整,0,150,100
tsl = obj.track0

if t < 0 then
	tst = (t / 10 - obj.time + obj.totaltime + t * 0.5 + (obj.num - obj.index) / obj.num * t * 0.6) / t * 10
else
	tst = (t / 10 - obj.time + t * 0.5 + (obj.num - obj.index) / obj.num * t * 0.6) / t * 10
end

if tst > 0 then
	if tst > 1 then
		tst = 1
		obj.alpha = 0
	end
else
	tst = 0
end
tst = tst * tst

tr = 360 * obj.index / obj.num + r
obj.ox = math.sin(tr * math.pi / 180) * s * 0.465 / 2 * tsl / 100
obj.oy = -math.cos(tr * math.pi / 180) * s * 0.465 / 2 * tsl / 100
obj.rz = tr
obj.alpha = 1 - tst
if obj.index % (obj.num / 4) == 0 then
	obj.zoom = 1.2
end
