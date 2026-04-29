--track0:範囲,0,1000,50,1
--track1:Z基準,-20000,20000,0
--track2:最大値,0,1000,300,1
--dialog:奥をぼかす/chk,oku=1;手前をぼかす/chk,mae=1;
if obj.z > obj.track1 then
	l = (obj.z - obj.track1) / 10000 * oku
else
	l = (obj.track1 - obj.z) / 10000 * mae
end
l = math.min(l * obj.track0, obj.track2)
obj.effect("ぼかし", "範囲", l)
