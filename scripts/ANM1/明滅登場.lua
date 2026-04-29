--track0:登場[f],0,150,4,1
--track1:退場[f],0,150,4,1
t0 = obj.track0
t1 = obj.track1
if t0 > 0 then
	if obj.frame <= t0 and obj.frame % 2 == 1 then
		obj.alpha = 0
	end
end
if t1 > 0 then
	if obj.totalframe - obj.frame <= t1 and obj.frame % 2 == 0 then
		obj.alpha = 0
	end
end
