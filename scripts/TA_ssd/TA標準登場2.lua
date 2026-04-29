--track0:時間[s],0,5,0.3,0.01
--track1:イン[s],-1,5,1,0.01
--track2:アウト[s],-1,5,1,0.01
--track3:登場順,0,5,2,1
--dialog:フェード/chk,fade=1;X距離,x=0;Y距離,y=0;Z距離,z=0;拡大,s=100;X軸回転,rx=0;Y軸回転,ry=0;Z軸回転,rz=0;加減速[1-5],beki=2;アウトは逆方向/chk,gyaku=1;

--インアウトがマイナスの時は最初or最後の中間点でフェードインアウト。数値の時は指定した秒数でフェードインアウト。ゼロのときはフェードインアウトなし。

local jun = obj.track3

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

local ta = obj.track0

--シーンイン
if obj.track1 ~= 0 then
	if obj.track1 < 0 then
		in_time = obj.getvalue("time", 0, 1)
	else
		in_time = obj.track1
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
if obj.track2 ~= 0 then
	if obj.track2 < 0 then
		out_time = obj.totaltime - obj.getvalue("time", 0, obj.getoption("section_num") - 1)
	else
		out_time = obj.track2
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
