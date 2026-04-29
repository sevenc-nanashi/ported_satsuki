--track0:間隔[s],-5,5,0.3,0.01
--track1:速度,-1000,1000,270
--track2:待機[s],0,10,0,0.01
--track3:登場順,0,5,0,1
--dialog:X軸回転/chk,rx=0;Y軸回転/chk,ry=0;Z軸回転/chk,rz=1;移動距離,id_len=0;移動角度,id_r=0;

local ts = obj.time - obj.track2
local tb = math.abs(obj.track0)
local rv = obj.track1
local jun = obj.track3
local ta = math.abs(360 / rv)

if jun < 1 then --順番に登場
	mode = obj.index
elseif jun < 2 then --後ろから登場
	mode = obj.num - 1 - obj.index
elseif jun < 3 then --ランダム順に登場
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
	mode = indexes[obj.index + 1]
elseif jun < 4 then --ランダム間隔に登場
	mode = rand(0, 100 * (obj.num - 1), obj.index, 0) / 100
elseif jun < 5 then --内側から登場
	mode = math.abs((obj.num - 1) / 2 - obj.index)
else --外側から登場
	mode = (obj.num - 1) / 2 - math.abs((obj.num - 1) / 2 - obj.index)
end

if obj.track0 < 0 then
	i = -(-ta - obj.num * tb - obj.time - obj.track2 + obj.totaltime + mode * tb) / ta
else
	i = (ta - ts + mode * tb) / ta
end

if i > 0 then
	if id_r == 20101118 then --隠しパラメータ
		id_r = obj.rand(0, 360, 0, obj.index)
	end
	obj.ox = obj.ox + math.cos(math.rad(id_r)) * i * id_len
	obj.oy = obj.oy + math.sin(math.rad(id_r)) * i * id_len
	obj.rx = obj.rx + rv * i * rx
	obj.ry = obj.ry + rv * i * ry
	obj.rz = obj.rz + rv * i * rz
end
