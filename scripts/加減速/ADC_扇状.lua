--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:中心角1
---min=0
---max=360
local track1 = 360
---$track:中心角2
---min=-360
---max=360
---step=1
local c2 = 0
---$track:サイズ1
---min=0
---max=4000
---step=1
local track2 = 100
---$track:サイズ2
---min=-4000
---max=4000
---step=1
local s2 = 0
---$track:ライン幅1
---min=0
---max=4000
---step=1
local track3 = 4000
---$track:ライン幅2
---min=-4000
---max=4000
---step=1
local h2 = 0
---$color:色
local col = 0xffffff

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

--フィルタ効果(「扇状」を改変)
local c = track1 + c2 * t
local s = track2 + s2 * t
local h = track3 + h2 * t
local l = math.floor(s / 2)
obj.load("figure", "円", col, l * 2, h)
obj.effect("斜めクリッピング", "角度", 180 - c / 2)
obj.effect("ミラー", "境目調整", -l)
obj.rz = -c / 2 - 90
