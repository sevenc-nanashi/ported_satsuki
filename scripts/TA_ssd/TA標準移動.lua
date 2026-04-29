--track0:時間[s],-5,5,0.3,0.01
--track1:間隔[s],0,5,0.3,0.01
--track2:開始[s],0,100,0,0.01
--track3:登場順,0,5,0,1
--dialog:拡大率,s=100;X距離,x=0;Y距離,y=100;Z距離,z=0;X軸回転,rx=0;Y軸回転,ry=0;Z軸回転,rz=0;加減速[1-5],beki=2;減/加/S[0-2],adc=0;タイプ/chk,typ=0;
st = obj.track2
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

if typ < 1 then
	ta = obj.track0
	tb = obj.track1
else
	ta = obj.track0 * (1 - mode / obj.num)
	tb = obj.track1 / obj.num
end

if ta < 0 then
	i = (ta - obj.num * tb - obj.time - st + obj.totaltime + mode * tb) / ta
else
	i = (ta - obj.time + st + mode * tb) / ta
end
if i > 0 then
	if i > 1 then
		i = 1
	end
	if adc < 1 then
		i = i ^ beki
	elseif adc < 2 then
		i = 1 - (1 - i) ^ beki
	else
		if i <= 0.5 then
			i = (2 * i) ^ beki / 2
		else
			i = (1 - (1 - (i - 0.5) * 2) ^ beki) / 2 + 0.5
		end
	end
	obj.ox = obj.ox + x * i
	obj.oy = obj.oy + y * i
	obj.oz = obj.oz + z * i
	obj.rx = obj.rx + rx * i
	obj.ry = obj.ry + ry * i
	obj.rz = obj.rz + rz * i
	obj.zoom = obj.zoom + i * (s - 100) / 100
end
