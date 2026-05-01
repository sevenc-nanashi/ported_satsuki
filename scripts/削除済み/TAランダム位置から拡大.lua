--label:${ROOT_CATEGORY}\切り替え効果\TA
---$track:時間[s]
---min=0
---max=10
---step=0.01
local ta = 2
---$track:間隔[s]
---min=0
---max=10
---step=0.01
local tb = 1
---$track:傾き範囲
---min=0
---max=360
local rz = 30
---$check:縮小
local __rename_me_check0 = false


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
if __rename_me_check0 then
	obj.zoom = t
end
