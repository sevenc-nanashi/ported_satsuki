--label:${ROOT_CATEGORY}\クリッピング
---$track:上1
---min=0
---max=2000
local track0 = 0
---$track:上2
---min=-2000
---max=2000
---step=1
local up2 = 0
---$track:下1
---min=0
---max=2000
local track1 = 0
---$track:下2
---min=-2000
---max=2000
---step=1
local dw2 = 0
---$track:左1
---min=0
---max=2000
local track2 = 0
---$track:左2
---min=-2000
---max=2000
---step=1
local lf2 = 0
---$track:右1
---min=0
---max=2000
local track3 = 0
---$track:右2
---min=-2000
---max=2000
---step=1
local rt2 = 0
--separator:加減速
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local ta = 1
---$track:加減速
---min=1
---max=5
---step=1
local beki = 2
---$select:モード
---減速=0
---加速=1
---S字=2
local mode = 0

--共通部分
local t
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
local up = track0 + up2 * t
local dw = track1 + dw2 * t
local lf = track2 + lf2 * t
local rt = track3 + rt2 * t
obj.effect("クリッピング", "上", up, "下", dw, "左", lf, "右", rt)
