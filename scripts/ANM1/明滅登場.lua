---$track:登場[f]
---min=0
---max=150
---step=1
local t0 = 4
---$track:退場[f]
---min=0
---max=150
---step=1
local t1 = 4
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
