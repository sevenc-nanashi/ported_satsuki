--label:${ROOT_CATEGORY}\クリッピング
---$track:回転1
---min=-720
---max=720
local track0 = 0
---$track:回転2
---min=-720
---max=720
local r2 = 0
---$track:サイズ1
---min=0
---max=2000
local track1 = 100
---$track:サイズ2
---min=-2000
---max=2000
---step=1
local s2 = 0
---$track:縦横比1
---min=-100
---max=100
local track2 = 0
---$track:縦横比2[%]
---min=-100
---max=100
local as2 = 0
---$track:ぼかし1
---min=0
---max=200
---step=1
local track3 = 0
---$track:ぼかし2
---min=-200
---max=200
---step=1
local bk2 = 0
---$value:マスクの種類
local ty = 2

---$track:X
---min=-2000
---max=2000
---step=1
local x = 0

---$track:Y
---min=-2000
---max=2000
---step=1
local y = 0

---$check:反転
local ht = 0

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
local r = track0 + r2 * t
local s = track1 + s2 * t
local as = track2 + as2 * t
local bk = track3 + bk2 * t
obj.effect(
	"マスク",
	"X",
	x,
	"Y",
	y,
	"回転",
	r,
	"サイズ",
	s,
	"縦横比",
	as,
	"ぼかし",
	bk,
	"マスクの反転",
	ht,
	"type",
	ty
)
