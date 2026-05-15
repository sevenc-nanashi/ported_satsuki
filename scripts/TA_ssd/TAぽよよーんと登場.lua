--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 0.6
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local interval = 0.1
---$track:勢い
---min=0
---max=8
---step=0.01
local momentum = 2.0
---$select:登場順
---順番=0
---逆順=1
---ランダム順=2
---ランダム間隔=3
---内側から=4
---外側から=5
local order = 0
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

---$check:タイプ
local scale_timing_by_order = false

local function get_random_order_index()
    local indexes = {}
    for i = 0, obj.num - 1 do
        indexes[i + 1] = i
    end

    for i = 0, obj.num - 1 do
        local dest = rand(0, obj.num - 1, -obj.num, i + 1)
        local swap = indexes[i + 1]
        indexes[i + 1] = indexes[dest + 1]
        indexes[dest + 1] = swap
    end

    return indexes[obj.index + 1]
end

local function get_order_index()
    if order == 0 then
        return obj.index
    elseif order == 1 then
        return obj.num - 1 - obj.index
    elseif order == 2 then
        return get_random_order_index()
    elseif order == 3 then
        return rand(0, 100 * (obj.num - 1), obj.index, 0) / 100
    elseif order == 4 then
        return math.abs((obj.num - 1) / 2 - obj.index)
    end

    return (obj.num - 1) / 2 - math.abs((obj.num - 1) / 2 - obj.index)
end

local function calculate_progress(timing_index, current_duration, current_interval)
    if current_duration < 0 then
        return (
            current_duration
            - obj.num * current_interval
            - obj.time
            + obj.totaltime
            + timing_index * current_interval
        ) / current_duration
    end

    return (current_duration - obj.time + timing_index * current_interval) / current_duration
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

local timing_index = get_order_index()
local current_duration = duration
local current_interval = interval

if scale_timing_by_order then
    current_duration = current_duration * (1 - timing_index / obj.num)
    current_interval = current_interval / obj.num
end

local progress = calculate_progress(timing_index, current_duration, current_interval)
if progress > 0 then
    if progress > 1 then
        obj.alpha = 0
        progress = 1
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
end
