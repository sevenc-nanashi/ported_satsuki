--label:${ROOT_CATEGORY}\切り替え効果
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 0.6
---$track:勢い
---min=0
---max=8
---step=0.01
local momentum = 2.0
---$track:揺れ幅[%]
---min=0
---max=800
local amplitude = 100
---$select:種類
---拡大縮小=0
---縦方向=1
---横方向=2
---縦伸び=3
---横伸び=4
local pattern = 0

local function calculate_progress()
    if duration < 0 then
        return (duration - obj.time + obj.totaltime) / duration
    end

    return (duration - obj.time) / duration
end

local function calculate_bounce(progress)
    local count = momentum * 2 + 1

    if count <= 1 then
        return progress * progress
    elseif progress > 1 - 1 / count then
        return 1 - (1 - progress) * count
    end

    local bounce_progress = progress * count / (count - 1)
    return math.sin((bounce_progress - 1) * (count - 1) * math.pi)
        * bounce_progress
        * 0.4
        / (1 + (1 - bounce_progress) * 3)
end

local function get_pattern_axes()
    if pattern == 0 then
        return 1, 1
    elseif pattern == 1 then
        return 0, 1
    elseif pattern == 2 then
        return 1, 0
    elseif pattern == 3 then
        return -1, 1
    end

    return 1, -1
end

if duration == 0 then
    return
end

local progress = calculate_progress()
if progress < 0 then
    return
end

local bounce = calculate_bounce(progress)
local x_axis, y_axis = get_pattern_axes()
local x_scale = math.max(0, 100 - bounce * x_axis * amplitude)
local y_scale = math.max(0, 100 - bounce * y_axis * amplitude)
local max_scale = math.max(x_scale, y_scale)

obj.zoom = max_scale / 100
if max_scale == 0 then
    obj.aspect = 0
elseif x_scale > y_scale then
    obj.aspect = y_scale / x_scale - 1
else
    obj.aspect = 1 - x_scale / y_scale
end
