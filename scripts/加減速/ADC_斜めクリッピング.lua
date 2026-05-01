---$track:中心X1
---min=-2000
---max=2000
---step=1
local track0 = 0
---$track:中心Y1
---min=-2000
---max=2000
---step=1
local track1 = 0
---$track:角度1
---min=-720
---max=720
local track2 = 0
---$track:幅1
---min=-2000
---max=2000
---step=1
local track3 = 0
---$value:時間[s]
local ta = 1

---$value:加減速[1-5]
local beki = 2

---$value:減
local mode = 0

---$value:中心X2
local x2 = 0

---$value:中心Y2
local y2 = 0

---$value:角度2
local r2 = 0

---$value:幅2
local w2 = 0

---$value:ぼかし
local bk = 0


--共通部分
if ta == 0 then
	return
elseif ta < 0 then
	t = (ta - obj.time + obj.totaltime) / ta
else
	t = (ta - obj.time) / ta
end
t = math.max(0, t)

if mode < 1 then
	t = t ^ beki
elseif mode < 2 then
	t = 1 - (1 - t) ^ beki
else
	if t <= 0.5 then
		t = (2 * t) ^ beki / 2
	else
		t = (1 - (1 - (t - 0.5) * 2) ^ beki) / 2 + 0.5
	end
end

--フィルタ効果
x = track0 + x2 * t
y = track1 + y2 * t
r = track2 + r2 * t
w = track3 + w2 * t
obj.effect("斜めクリッピング", "中心X", x, "中心Y", y, "角度", r, "ぼかし", bk, "幅", w)
