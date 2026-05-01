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
---$value:順番(0-9文字目)
local num0 = "00010203040506070809"

---$value:順番(10-19文字目)
local num1 = "10111213141516171819"

---$value:順番(20-29文字目)
local num2 = "20212223242526272829"

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

number = num0 .. num1 .. num2

if obj.index == 0 then
	if pp == null then
		pp = {}
	end
end
pp[obj.index + 1] = { obj.ox, obj.oy, obj.oz, obj.zoom, obj.alpha, obj.rx, obj.ry, obj.rz }

for j = 0, obj.num - 1 do
	jb = string.sub(number, j * 2 + 1, j * 2 + 1 + 1)
	if obj.index == j then
		if ta < 0 then
			i = (ta - obj.num * tb - obj.time + obj.totaltime + jb * tb) / ta
		else
			i = (ta - obj.time + jb * tb) / ta
		end
		if i > 0 then
			if i > 1 then
				fade = 1
				i = 1
			end
			i = i ^ beki
			obj.ox = pp[j + 1][1] + x * i
			obj.oy = pp[j + 1][2] + y * i
			obj.oz = pp[j + 1][3] + z * i
			obj.zoom = pp[j + 1][4] + i * (s - 100) / 100
			obj.alpha = pp[j + 1][5] * (1 - i * fade)
			obj.rx = pp[j + 1][6] + rx * i
			obj.ry = pp[j + 1][7] + ry * i
			obj.rz = pp[j + 1][8] + rz * i
		end
	end
end
