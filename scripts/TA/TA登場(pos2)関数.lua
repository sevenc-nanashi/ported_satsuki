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
---$track:加減速
---min=1
---max=5
---step=1
local beki = 2
if obj.index == 0 then
	if pp2 == null then
		pp2 = {}
	end
end
pp2[obj.index + 1] = { obj.ox, obj.oy, obj.oz, obj.zoom, obj.alpha, obj.aspect, obj.rx, obj.ry, obj.rz }

function pos2(j, jb, x, y, z, s, alp, as, rx, ry, rz)
	if x == null then
		x = 0
	end
	if y == null then
		y = 0
	end
	if z == null then
		z = 0
	end
	if s == null then
		s = 1
	end
	if alp == null then
		alp = 1
	end
	if as == null then
		as = 0
	end
	if rx == null then
		rx = 0
	end
	if ry == null then
		ry = 0
	end
	if rz == null then
		rz = 0
	end
	if obj.index == j then
		if ta < 0 then
			i = (ta - obj.num * tb - obj.time + obj.totaltime + jb * tb) / ta
		else
			i = (ta - obj.time + jb * tb) / ta
		end
		if i > 0 then
			if i > 1 then
				alp = 0
				i = 1
			end
			i = i ^ beki
			obj.ox = pp2[j + 1][1] + x * i
			obj.oy = pp2[j + 1][2] + y * i
			obj.oz = pp2[j + 1][3] + z * i
			obj.zoom = pp2[j + 1][4] + (s - 1) * i
			obj.alpha = pp2[j + 1][5] + (alp - 1) * i
			obj.aspect = pp2[j + 1][6] + as * i
			obj.rx = pp2[j + 1][7] + rx * i
			obj.ry = pp2[j + 1][8] + ry * i
			obj.rz = pp2[j + 1][9] + rz * i
		end
	end
end

--登場関数：一文字毎に登場パターンを設定
--形式：pos2(index,登場順[,X座標,Y座標,Z座標,拡大率,不透明度,縦横比,X軸回転,Y軸回転,Z軸回転])
--説明：座標は初期位置からの座標、X座標以降は省略可
--　　：登場順(0〜)、拡大率(1.0=等倍)、不透明度(0.0=透明/1.0=不透明)
