--track0:X拡大率,0,1000,100
--track1:中心X,-1000,1000,0
--track2:Y拡大率,0,1000,100
--track3:中心Y,-1000,1000,0
--check0:自動調節,1
if obj.check0 then
	s = obj.getvalue("zoom") / 100
else
	s = 1
end
obj.ox = obj.track1 + (obj.ox - obj.track1) * obj.track0 / 100 * s
obj.oy = obj.track3 + (obj.oy - obj.track3) * obj.track2 / 100 * s

--自動調節は、「文字毎に個別オブジェクト」にチェックした状態で拡大率を変化させても、字間が自動で調節されるようにします。
