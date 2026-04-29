---$track:時間[s]
---min=-5
---max=5
---step=0.01
local ta = 0.6
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local tb = 0.1
---$track:勢い
---min=0
---max=8
---step=0.01
local s = 2.0
---$track:登場順
---min=0
---max=5
---step=1
local jun = 0
--check0:タイプ,0

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

if obj.check0 then
	ta = ta * (1 - mode / obj.num)
	tb = tb / obj.num
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
		n = s * 2 + 1
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
