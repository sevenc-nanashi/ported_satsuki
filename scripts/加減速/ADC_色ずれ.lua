--label:${ROOT_CATEGORY}\光効果
---$track:幅1
---min=0
---max=500
---step=1
local base_shift_width = 5
---$track:角度1
---min=-720
---max=720
---step=1
local base_angle = 0
---$select:色ずれの種類
---赤緑A=0
---赤青A=1
---緑青A=2
---赤緑B=3
---赤青B=4
---緑青B=5
local shift_type = 0

--separator:加減速
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 1
---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2
---$select:モード
---減速=0
---加速=1
---S字=2
local mode = 0

---$track:幅2
---min=-500
---max=500
---step=1
local shift_width_delta = 0
---$track:角度2
---min=-720
---max=720
---step=1
local angle_delta = 0

--共通部分
local progress
if duration == 0 then
    return
elseif duration < 0 then
    progress = (duration - obj.time + obj.totaltime) / duration
else
    progress = (duration - obj.time) / duration
end
progress = math.max(0, progress)

if mode < 1 then
    progress = progress ^ easing_power
elseif mode < 2 then
    progress = 1 - (1 - progress) ^ easing_power
else
    if progress <= 0.5 then
        progress = (2 * progress) ^ easing_power / 2
    else
        progress = (1 - (1 - (progress - 0.5) * 2) ^ easing_power) / 2 + 0.5
    end
end

--フィルタ効果
local shift_width = base_shift_width + shift_width_delta * progress
local angle = base_angle + angle_delta * progress
obj.effect("色ずれ", "ずれ幅", shift_width, "角度", angle, "type", shift_type)
