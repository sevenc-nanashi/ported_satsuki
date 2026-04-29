--track0:表示速度,0,100,5
v = 1 / obj.track0 --単位：秒/文字
n = obj.num
if obj.index == 0 then
	if tp == null then
		tp = {}
	end
end
tp[obj.index + 1] = { obj.ox, obj.oy, obj.w, obj.h }
if obj.time < obj.index * v + v then
	obj.alpha = 0
end
