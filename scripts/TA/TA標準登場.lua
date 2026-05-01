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
---$track:拡大率
---min=0
---max=1000
local s = 100
---$track:登場順
---min=0
---max=5
---step=1
local jun = 0
---$check:フェード
local fade = 0

---$value:X距離
local x = 0

---$value:Y距離
local y = 0

---$value:Z距離
local z = 0

---$value:X軸回転
local rx = 0

---$value:Y軸回転
local ry = 0

---$value:Z軸回転
local rz = 0

---$value:加減速[1-5]
local beki = 2

---$check:タイプ
local type = 0


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
	i = (ta - obj.num * tb - obj.time + obj.totaltime + mode * tb) / ta
else
	i = (ta - obj.time + mode * tb) / ta
end
if i > 0 then
	if i > 1 then
		obj.alpha = 0
		i = 1
	end
	i = i ^ beki
	obj.ox = obj.ox + x * i
	obj.oy = obj.oy + y * i
	obj.oz = obj.oz + z * i
	obj.rx = obj.rx + rx * i
	obj.ry = obj.ry + ry * i
	obj.rz = obj.rz + rz * i
	obj.zoom = obj.zoom + i * (s - 100) / 100
	if fade == 1 then
		obj.alpha = obj.alpha * (1 - i)
	end
end
