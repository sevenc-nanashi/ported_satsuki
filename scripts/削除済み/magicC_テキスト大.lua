--track0:半径調整,0,150,100
tbl = obj.track0

if t < 0 then
	tbt = (t / 10 - obj.time + obj.totaltime + t * 0.5 + obj.index / obj.num * t * 0.6) / t * 10
else
	tbt = (t / 10 - obj.time + t * 0.5 + obj.index / obj.num * t * 0.6) / t * 10
end

if tbt > 0 then
	if tbt > 1 then
		tbt = 1
		obj.alpha = 0
	end
else
	tbt = 0
end
tbt = tbt * tbt

tr = 360 * obj.index / obj.num - r
obj.ox = math.sin(tr * math.pi / 180) * s * 7 / 8 / 2 * tbl / 100
obj.oy = -math.cos(tr * math.pi / 180) * s * 7 / 8 / 2 * tbl / 100
obj.rz = tr
obj.alpha = 1 - tbt
g = math.floor(obj.num / 4)
if obj.index % g == 0 or obj.index % g == 1 or obj.index % g == g - 1 then
	obj.alpha = 0
end
