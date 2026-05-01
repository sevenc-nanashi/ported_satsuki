--label:${ROOT_CATEGORY}\切り替え効果\TA
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local ta = 0.3
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local tb = 0.3
---$track:開始[s]
---min=0
---max=100
---step=0.01
local st = 0
---$track:登場順
---min=0
---max=5
---step=1
local jun = 0
---$value:加減速[1-5]
local beki = 2

---$value:減
local adc = 0

---$check:タイプ
local type = 0

---$value:座標
local pos = {}

obj.effect()

obj.setanchor("pos", obj.num, "line")

if obj.index == 0 then
	if pp == null then
		pp = {}
	end
end
pp[obj.index + 1] = { obj.ox, obj.oy }

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

if type < 1 then
else
	ta = ta * (1 - mode / obj.num)
	tb = tb / obj.num
end

if ta < 0 then
	r = (ta - obj.num * tb - obj.time - st + obj.totaltime + mode * tb) / ta
else
	r = (ta - obj.time + st + mode * tb) / ta
end
if r > 0 then
	if r > 1 then
		r = 1
	end
	if adc < 1 then
		r = r ^ beki
	elseif adc < 2 then
		r = 1 - (1 - r) ^ beki
	else
		if r <= 0.5 then
			r = (2 * r) ^ beki / 2
		else
			r = (1 - (1 - (r - 0.5) * 2) ^ beki) / 2 + 0.5
		end
	end
	for i = 0, obj.num - 1 do
		x = pos[i * 2 + 1] - pp[i + 1][1]
		y = pos[i * 2 + 2] - pp[i + 1][2]
		if i == obj.index then
			alp = 1
		else
			alp = 0
		end
		obj.draw(x * r, y * r, 0, 1, alp)
	end
end
