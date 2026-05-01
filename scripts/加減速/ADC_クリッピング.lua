--label:${ROOT_CATEGORY}\クリッピング
---$track:上1
---min=0
---max=2000
local track0 = 0
---$track:下1
---min=0
---max=2000
local track1 = 0
---$track:左1
---min=0
---max=2000
local track2 = 0
---$track:右1
---min=0
---max=2000
local track3 = 0
---$value:時間[s]
local ta = 1

---$value:加減速[1-5]
local beki = 2

---$value:減
local mode = 0

---$value:上2
local up2 = 0

---$value:下2
local dw2 = 0

---$value:左2
local lf2 = 0

---$value:右2
local rt2 = 0


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
up = track0 + up2 * t
dw = track1 + dw2 * t
lf = track2 + lf2 * t
rt = track3 + rt2 * t
obj.effect("クリッピング", "上", up, "下", dw, "左", lf, "右", rt)
