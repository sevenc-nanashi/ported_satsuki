--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 0.3

---$track:間隔[s]
---min=0
---max=5
---step=0.01
local interval = 0.3

---$track:開始[s]
---min=0
---max=100
---step=0.01
local start_time = 0

---$select:登場順
---順番=0
---後ろから=1
---ランダム順=2
---ランダム間隔=3
---内側から=4
---外側から=5
local order_mode = 0

---$track:拡大率
---min=0
---max=1000
---step=0.1
local zoom_rate = 100

---$track:X距離
---min=-2000
---max=2000
---step=0.1
local distance_x = 0

---$track:Y距離
---min=-2000
---max=2000
---step=0.1
local distance_y = 100

---$track:Z距離
---min=-2000
---max=2000
---step=0.1
local distance_z = 0

--trackgroup@distance_x,distance_y,distance_z:距離

---$track:X軸回転
---min=-720
---max=720
---step=0.1
local rotation_x = 0

---$track:Y軸回転
---min=-720
---max=720
---step=0.1
local rotation_y = 0

---$track:Z軸回転
---min=-720
---max=720
---step=0.1
local rotation_z = 0

--trackgroup@rotation_x,rotation_y,rotation_z:回転

---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

---$select:モード
---減速=0
---加速=1
---S字=2
local easing_mode = 0

---$check:タイプ
local overall_appearance = false

local function get_random_order_index()
    local indexes = {}
    for i = 0, obj.num - 1 do
        indexes[i + 1] = i
    end
    for i = 0, obj.num - 1 do
        local dest = obj.rand(0, obj.num - 1, -obj.num, i + 1)
        local swap = indexes[i + 1]
        indexes[i + 1] = indexes[dest + 1]
        indexes[dest + 1] = swap
    end

    return indexes[obj.index + 1]
end

local function get_order_index()
    if order_mode == 0 then
        return obj.index --順番に登場
    elseif order_mode == 1 then
        return obj.num - 1 - obj.index --後ろから登場
    elseif order_mode == 2 then
        return get_random_order_index() --ランダム順に登場
    elseif order_mode == 3 then
        return obj.rand(0, 100 * (obj.num - 1), obj.index, 0) / 100 --ランダム間隔に登場
    elseif order_mode == 4 then
        return math.abs((obj.num - 1) / 2 - obj.index) --内側から登場
    end

    return (obj.num - 1) / 2 - math.abs((obj.num - 1) / 2 - obj.index) --外側から登場
end

local function apply_easing(progress)
    if easing_mode == 0 then
        return progress ^ easing_power
    elseif easing_mode == 1 then
        return 1 - (1 - progress) ^ easing_power
    end

    if progress <= 0.5 then
        return (2 * progress) ^ easing_power / 2
    end
    return (1 - (1 - (progress - 0.5) * 2) ^ easing_power) / 2 + 0.5
end

local order_index = get_order_index()
local adjusted_duration = duration
local adjusted_interval = interval
if overall_appearance then
    adjusted_duration = adjusted_duration * (1 - order_index / obj.num)
    adjusted_interval = adjusted_interval / obj.num
end

if adjusted_duration == 0 then
    return
end

local progress
if adjusted_duration < 0 then
    progress = (
        adjusted_duration
        - obj.num * adjusted_interval
        - obj.time
        - start_time
        + obj.totaltime
        + order_index * adjusted_interval
    ) / adjusted_duration
else
    progress = (adjusted_duration - obj.time + start_time + order_index * adjusted_interval) / adjusted_duration
end

if progress > 0 then
    progress = apply_easing(math.min(progress, 1))
    obj.ox = obj.ox + distance_x * progress
    obj.oy = obj.oy + distance_y * progress
    obj.oz = obj.oz + distance_z * progress
    obj.rx = obj.rx + rotation_x * progress
    obj.ry = obj.ry + rotation_y * progress
    obj.rz = obj.rz + rotation_z * progress
    obj.zoom = obj.zoom + progress * (zoom_rate - 100) / 100
end
