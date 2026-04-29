--track0:角度範囲,-360,360,60
--track1:方向,-360,360,0
--track2:字間,-800,800,100
--track3:拡大,1,100,100
--dialog:回転あり/chk,rc=0;ランダム種,seed=1;

r = obj.track0 / 2
off_r = obj.track1

--字間の配列
if obj.index == 0 then
	if tj == null then
		tj = {}
	end
end
tj[obj.index + 1] = { obj.ox, obj.oy }

--ランダム拡大の配列
rzoom = {}
idz = 0
for i = 1, obj.num + 1 do
	zz = obj.rand(obj.track3, 100, -11 - seed, i) / 100
	idz = idz + 1
	rzoom[idz] = zz
end

--メイン
for i = 0, obj.num - 1 do
	if obj.index == i then
		xx = 0
		yy = 0
		if i > 0 then
			for j = 1, i do
				l = obj.track2 / 100 * (tj[j + 1][1] - tj[j][1]) * (rzoom[j] + rzoom[j + 1]) / 2
				xx = xx + l * math.cos(math.rad(off_r + obj.rand(-r, r, -1 - seed, j)))
				yy = yy + l * math.sin(math.rad(off_r + obj.rand(-r, r, -1 - seed, j)))
			end
		end
		obj.ox = xx
		obj.oy = yy
		if rc == 1 then
			obj.rz = obj.rz + off_r + (obj.rand(-r, r, -1, i) + obj.rand(-r, r, -1 - seed, i + 1)) / 2
		end
		obj.zoom = obj.zoom * rzoom[i + 1]
	end
end
