--track0:イン,0,10,0.5,0.01
--track1:アウト,0,10,0.5,0.01
--color:0xffffff
obj.load("figure", "背景", color, 100)
obj.alpha = 0
if obj.time < obj.track0 then
	ta = (obj.track0 - obj.time) / obj.track0
	if obj.track0 == 0 then
		ta = 1
	end
	obj.alpha = ta
end
if obj.time > obj.totaltime - obj.track1 then
	tb = -(-obj.track1 - obj.time + obj.totaltime) / obj.track1
	if obj.track1 == 0 then
		tb = 1
	end
	obj.alpha = tb
end
