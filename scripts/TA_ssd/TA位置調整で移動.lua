--track0:時間[s],-5,5,0.3,0.01
--track1:間隔[s],0,5,0.3,0.01
--track2:開始[s],0,100,0,0.01
--track3:登場順,0,5,0,1
--dialog:加減速[1-5],beki=2;減/加/S[0-2],adc=0;タイプ/chk,type=0;座標,pos={};
obj.effect()
st = obj.track2
jun = obj.track3

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
	ta = obj.track0
	tb = obj.track1
else
	ta = obj.track0 * (1 - mode / obj.num)
	tb = obj.track1 / obj.num
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
