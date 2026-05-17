--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:時間[s]
---min=-10
---max=10
---step=0.01
local duration = 3

---$track:角度
---min=-720
---max=720
---step=0.1
local rotation_angle = 360

---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

---$check:文字回転
local rotates_character = true

if duration == 0 then
    return
end

local order_index = (obj.num - 1) / 2 - math.abs((obj.num - 1) / 2 - obj.index)
local adjusted_duration = duration * (1 - order_index / obj.num)
local interval = duration / obj.num

local progress
if duration < 0 then
    progress = (adjusted_duration - obj.time + obj.totaltime + interval * order_index) / adjusted_duration
else
    progress = (adjusted_duration - obj.time + interval * order_index) / adjusted_duration
end

if progress > 0 then
    if progress > 1 then
        progress = 1
    end
    progress = progress ^ easing_power
    local x = obj.ox * (1 - progress)
    local y = obj.oy
    local rotation = math.rad(rotation_angle) * progress
    obj.ox = x * math.cos(rotation) - y * math.sin(rotation)
    obj.oy = x * math.sin(rotation) + y * math.cos(rotation)
    if rotates_character then
        obj.rz = obj.rz + math.deg(rotation)
    end
end
