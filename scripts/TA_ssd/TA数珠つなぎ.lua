---$track:角度範囲
---min=-360
---max=360
local track0 = 60
---$track:方向
---min=-360
---max=360
local off_r = 0
---$track:字間
---min=-800
---max=800
local track2 = 100
---$track:拡大
---min=1
---max=100
local track3 = 100
--dialog:回転あり/chk,rc=0;ランダム種,seed=1;

r = track0 / 2

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
	zz = obj.rand(track3, 100, -11 - seed, i) / 100
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
				l = track2 / 100 * (tj[j + 1][1] - tj[j][1]) * (rzoom[j] + rzoom[j + 1]) / 2
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
