--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:時間[s]
---min=-10
---max=10
---step=0.01
local duration = 3

---$track:字間率[%]
---min=-1000
---max=1000
---step=0.1
local spacing_rate = 300

---$track:中心座標
---min=-1000
---max=1000
---step=0.1
local center_position = 0

---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

---$check:縦書き
local vertical = false

---$check:フェード
local fades = false

if duration == 0 then
    return
end

local progress
if duration < 0 then
    progress = (duration - obj.time + obj.totaltime) / duration
else
    progress = (duration - obj.time) / duration
end

if progress <= 0 then
    return
end

progress = math.min(progress, 1) ^ easing_power
local spacing_scale = 1 + spacing_rate / 100 * progress
if vertical then
    obj.oy = center_position + (obj.oy - center_position) * spacing_scale
else
    obj.ox = center_position + (obj.ox - center_position) * spacing_scale
end

if fades then
    obj.alpha = obj.alpha * (1 - progress)
end
