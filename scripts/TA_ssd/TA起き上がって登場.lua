--track0:時間[s],-5,5,0.6,0.01
--track1:間隔[s],0,5,0.1,0.01
--track2:勢い,0,8,2.0,0.01
--track3:登場順,0,5,0,1
--check0:タイプ,0
s = obj.track2
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

ta = obj.track0
tb = obj.track1
if obj.check0 then
	ta = obj.track0 * (1 - mode / obj.num)
	tb = obj.track1 / obj.num
end

if ta < 0 then
	i = (ta - obj.num * tb - obj.time + obj.totaltime + mode * tb) / ta
else
	i = (ta - obj.time + mode * tb) / ta
end
if i > 0 then
	if i > 1 then
		obj.alpha = 0
		i = 1
	end
	if i >= 0 then
		n = obj.track2 * 2 + 1
		if n <= 1 then
			i = i * i
		elseif i > 1 - 1 / n then
			i = 1 - (1 - i) * n
		else
			i = i * n / (n - 1)
			i = math.sin((i - 1) * (n - 1) * math.pi) * i * 0.4 / (1 + (1 - i) * 3)
		end
		obj.rx = obj.rx - 90 * i
		obj.oy = obj.oy + obj.h * (1 - math.cos(i * math.pi / 2)) / 2
		obj.oz = obj.oz + obj.h * math.sin(i * math.pi / 2) / 2
	end
end
