--label:${ROOT_CATEGORY}\ぼかし
---$track:範囲1
---min=0
---max=300
---step=1
local track1 = 0
---$track:範囲2
---min=-300
---max=300
---step=1
local track2 = 0
---$track:縦横比
---min=-100
---max=100
local track3 = 0
---$track:光の強さ
---min=0
---max=5
---step=0.01
local br = 2

---$check:サイズ固定
local fix = 0

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
local h = track1 + track2 * t
obj.effect("ぼかし", "範囲", h, "縦横比", track3, "光の強さ", br, "サイズ固定", fix)
