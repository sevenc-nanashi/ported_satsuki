--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:X
---min=-2000
---max=2000
local track0 = 0
---$track:Y
---min=-2000
---max=2000
local track1 = 0
---$track:範囲
---min=0
---max=2000
---step=1
local track2 = 100
---$track:範囲表示
---min=0
---max=1
---step=1
local track3 = 1
---$value:X
local x = 0

---$value:Y
local y = 0

---$value:Z
local z = 0

---$value:拡大率
local s = 50

---$value:透明度
local alp = 0

---$value:X回転
local rx = 0

---$value:Y回転
local ry = 0

---$value:Z回転
local rz = 0

---$value:加減速[1-5]
local beki = 2

---$value:自動移動[0-2]
local jido = 0

---$value:幅
local h_hb0 = 2000

obj.effect()
h_sz = track2 / 2
h_hb = math.min(h_sz, h_hb0)

obj.setanchor("track", 0, "line")
local px = obj.getvalue(0)
local py = obj.getvalue(1)

local i = (h_sz - math.sqrt((px - obj.ox) ^ 2 + (py - obj.oy) ^ 2)) / h_hb

if i > 0 then
	if i > 1 then
		i = 1
	end
	if i <= 0.5 then
		i = (2 * i) ^ beki / 2
	else
		i = (1 - (1 - (i - 0.5) * 2) ^ beki) / 2 + 0.5
	end

	if jido == 1 or 2 then
		J_rz = math.atan2(py - obj.oy, px - obj.ox)

		if jido == 1 then
			x = -h_sz * math.cos(J_rz)
			y = -h_sz * math.sin(J_rz)
			rz = math.deg(J_rz)
		elseif jido == 2 then
			x = px - obj.ox
			y = py - obj.oy
		end
	end

	obj.draw(x * i, y * i, z * i, 1 + i * (s - 100) / 100, 1 - i * alp / 100, rx * i, ry * i, rz * i)
else
	obj.draw()
end

--範囲表示
if track3 == 1 then
	obj.load("figure", "円", 0xff0000, h_sz * 2, h_hb)
	obj.draw(px, py, 0, 1, 0.5 / obj.num)
end
