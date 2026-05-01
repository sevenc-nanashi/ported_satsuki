--label:${ROOT_CATEGORY}\切り替え効果\TA
---$track:時間[s]
---min=0
---max=5
---step=0.01
local ta = 0.3
---$track:イン[s]
---min=-1
---max=5
---step=0.01
local in_time = 1
---$track:アウト[s]
---min=-1
---max=5
---step=0.01
local out_time = 1
---$track:登場順
---min=0
---max=5
---step=1
local jun = 2
---$check:フェード
local fade = 1

---$value:X距離
local x = 0

---$value:Y距離
local y = 0

---$value:Z距離
local z = 0

---$value:拡大
local s = 100

---$value:X軸回転
local rx = 0

---$value:Y軸回転
local ry = 0

---$value:Z軸回転
local rz = 0

---$value:加減速[1-5]
local beki = 2

---$check:アウトは逆方向
local gyaku = 1


--インアウトがマイナスの時は最初or最後の中間点でフェードインアウト。数値の時は指定した秒数でフェードインアウト。ゼロのときはフェードインアウトなし。

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

--シーンイン
if in_time ~= 0 then
	if in_time < 0 then
		in_time = obj.getvalue("time", 0, 1)
	else
	end

	local i = (ta - obj.time + mode * in_time / obj.num) / ta

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
end

--シーンアウト
if out_time ~= 0 then
	if out_time < 0 then
		out_time = obj.totaltime - obj.getvalue("time", 0, obj.getoption("section_num") - 1)
	else
	end

	local r = -(-ta - obj.num * out_time / obj.num - obj.time + obj.totaltime + mode * out_time / obj.num) / ta

	if r > 0 then
		if r > 1 then
			obj.alpha = 0
			r = 1
		end
		r = r ^ beki
		obj.ox = obj.ox + x * r * (1 - 2 * gyaku)
		obj.oy = obj.oy + y * r * (1 - 2 * gyaku)
		obj.oz = obj.oz + z * r * (1 - 2 * gyaku)
		obj.rx = obj.rx + rx * r * (1 - 2 * gyaku)
		obj.ry = obj.ry + ry * r * (1 - 2 * gyaku)
		obj.rz = obj.rz + rz * r * (1 - 2 * gyaku)
		obj.zoom = obj.zoom + r * (s - 100) / 100
		if fade == 1 then
			obj.alpha = obj.alpha * (1 - r)
		end
	end
end
