--track0:時間[s],-5,5,0.3,0.01
--track1:間隔[s],0,5,0.3,0.01
--track2:範囲,0,300,10,1
--track3:登場順,0,5,0,1
--dialog:フェード/chk,fade=0;縦横比(-100〜100),as=0;拡大率,s=150;
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
	if i > 1 then
		obj.alpha = 0
		i = 1
	end
	i = i * i
	obj.zoom = obj.zoom + i * (s - 100) / 100
	if fade == 1 then
		obj.alpha = obj.alpha * (1 - i)
	end
	obj.effect("ぼかし", "範囲", obj.track2 * i, "縦横比", as)
end
