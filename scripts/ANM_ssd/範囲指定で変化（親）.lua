--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:範囲
---min=0
---max=4000
---step=1
local track0 = 200
---$track:幅
---min=1
---max=4000
---step=1
local track1 = 4000
---$track:親obj表示
---min=0
---max=1
---step=1
local track2 = 1
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

---$value:減
local adc = 2

---$value:加減速[1-5]
local beki = 2

---$value:自動移動[0-2]
local jido = 0

---$check:自動時回転あり
local jdk = 1


obj.effect()

h_sz = track0 / 2
h_hb = math.min(h_sz, track1)
px = obj.x
py = obj.y
obj.draw(0, 0, 0, 1, track2)

--範囲表示
if track3 == 1 then
	obj.load("figure", "円", 0xff0000, h_sz * 2, h_hb)
	obj.draw(0, 0, 0, 100 / obj.getvalue("zoom"), 0.5)
end
