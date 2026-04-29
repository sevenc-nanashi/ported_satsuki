--track0:時間[s],-5,5,0.3,0.01
--track1:間隔[s],0,5,0.3,0.01
--track2:角度,-360,360,0
--track3:登場順,0,5,0,1
--dialog:拡大率,s=100;
ta = obj.track0
tb = obj.track1
jun = obj.track3

if jun < 1 then
	mode = obj.index --順番に登場
elseif jun < 2 then
	mode = obj.num - 1 - obj.index --後ろから登場
elseif jun < 3 then
	local indexes = {}
	for i = 0, obj.num - 1 do
		indexes[i + 1] = i
	end
	for i = 0, obj.num - 1 do
		local dest = 0
		dest = rand(0, obj.num - 1, -obj.num, i + 1)
		local swap = indexes[i + 1]
		indexes[i + 1] = indexes[dest + 1]
		indexes[dest + 1] = swap
	end
	mode = indexes[obj.index + 1] --ランダム順に登場
elseif jun < 4 then
	mode = rand(0, 100 * (obj.num - 1), obj.index, 0) / 100 --ランダム間隔に登場
elseif jun < 5 then
	mode = math.abs((obj.num - 1) / 2 - obj.index) --内側から登場
else
	mode = (obj.num - 1) / 2 - math.abs((obj.num - 1) / 2 - obj.index) --外側から登場
end

if obj.track0 < 0 then
	i = (ta - obj.num * tb - obj.time + obj.totaltime + mode * tb) / ta
else
	i = (ta - obj.time + mode * tb) / ta
end
if i > 0 then
	r = math.pi * obj.track2 / 180
	l = math.sqrt(obj.screen_w * obj.screen_w + obj.screen_h * obj.screen_h)
	i = i * l
	obj.ox = obj.ox + math.sin(r) * i
	obj.oy = obj.oy - math.cos(r) * i
	obj.zoom = obj.zoom + i / l * (s / 100 - 100) / 100
	l = l / (math.abs(ta) * 60)
	if l < 1 then
		l = 1
	elseif l > 100 then
		l = 100
	end
	obj.effect("方向ブラー", "角度", obj.track2, "範囲", l)
end
