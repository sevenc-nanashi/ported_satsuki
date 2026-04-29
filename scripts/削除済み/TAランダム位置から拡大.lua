--track0:時間[s],0,10,2,0.01
--track1:間隔[s],0,10,1,0.01
--track2:傾き範囲,0,360,30
--check0:縮小,0

ta = obj.track0
tb = obj.track1
rz = obj.track2
t = (ta - obj.time + obj.index * tb) / ta
a = t
if t > 0 then
	if t > 1 then
		t = 1
		a = a * 0
	end
else
	t = 0
end
range_w = obj.screen_w / 2 - obj.w * obj.zoom
range_h = obj.screen_h / 2 - obj.h * obj.zoom
obj.ox = rand(-range_w, range_w, obj.index, 0)
obj.oy = rand(-range_h, range_h, obj.index, 0)
obj.zoom = 1 - t
obj.alpha = a
obj.rz = obj.rand(-rz / 2, rz / 2, 0, obj.index)
if obj.check0 then
	obj.zoom = t
end
