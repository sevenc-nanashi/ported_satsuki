--track0:時間,-5,5,0.6,0.01
--track1:勢い,0,8,2.0,0.01
--track2:揺れ幅,0,800,100
--track3:種類,0,4,0,1
if obj.track0 == 0 then
	return
elseif obj.track0 < 0 then
	t = (obj.track0 - obj.time + obj.totaltime) / obj.track0
else
	t = (obj.track0 - obj.time) / obj.track0
end
if t >= 0 then
	n = obj.track1 * 2 + 1
	if n <= 1 then
		t = t * t
	elseif t > 1 - 1 / n then
		t = 1 - (1 - t) * n
	else
		t = t * n / (n - 1)
		t = math.sin((t - 1) * (n - 1) * math.pi) * t * 0.4 / (1 + (1 - t) * 3)
	end
	if obj.track3 == 0 then
		x = 1
		y = 1
	elseif obj.track3 == 1 then
		x = 0
		y = 1
	elseif obj.track3 == 2 then
		x = 1
		y = 0
	elseif obj.track3 == 3 then
		x = -1
		y = 1
	else
		x = 1
		y = -1
	end
	xscale = math.max(0, 100 - t * x * obj.track2)
	yscale = math.max(0, 100 - t * y * obj.track2)
	obj.zoom = math.max(xscale, yscale) / 100
	if xscale > yscale then
		obj.aspect = yscale / xscale - 1
	else
		obj.aspect = 1 - xscale / yscale
	end
end
