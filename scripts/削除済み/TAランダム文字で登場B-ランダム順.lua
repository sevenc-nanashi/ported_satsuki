--label:${ROOT_CATEGORY}\切り替え効果\TA
if ta < 0 then
	i = (ta - obj.num * tb - obj.time + obj.totaltime + rand(0, 100 * (obj.num - 1), -(obj.index + 1), 0) / 100 * tb)
		/ ta
else
	i = (ta - obj.time + rand(0, 100 * (obj.num - 1), -(obj.index + 1), 0) / 100 * tb) / ta
end
if i > 0 then
	if i > 1 then
		obj.alpha = 0
		i = 1
	end
	i = i * i
	obj.alpha = obj.alpha * (1 - i * fade)
	obj.zoom = obj.zoom + i * (s - 100) / 100
	obj.oy = obj.oy + y * i
else
	obj.alpha = 0
end
