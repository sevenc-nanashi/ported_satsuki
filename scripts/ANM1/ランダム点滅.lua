--track0:しきい値,0,100,50,1
--track1:透明度,0,100,0
--track2:間隔[s],0.01,5,0.01,0.01
a = rand(0, 99, 1, math.floor(obj.time / obj.track2))
if a >= obj.track0 then
	obj.alpha = obj.alpha * obj.track1 / 100
end
