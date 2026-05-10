--label:${ROOT_CATEGORY}\光効果
---$track:幅1
---min=0
---max=500
---step=1
local track0 = 5
---$track:幅2
---min=-500
---max=500
---step=1
local track1 = 0
---$track:角度1
---min=-720
---max=720
local track2 = 0
---$track:角度2
---min=-720
---max=720
local track3 = 0
---$value:色ずれの種類[0-2]
local ty = 0

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
local h = track0 + track1 * t
local r = track2 + track3 * t
obj.effect("色ずれ", "ずれ幅", h, "角度", r, "type", ty)
