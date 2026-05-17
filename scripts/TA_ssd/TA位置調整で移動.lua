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

---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

---$select:減/加/S
---減速=0
---加速=1
---減速加速=2
local easing_mode = 0

---$check:タイプ
local overall_appearance = false

---$value:座標
local positions = {}

obj.effect()

obj.setanchor("positions", obj.num, "line")

if obj.index == 0 then
    if S_position_move_states == nil then
        S_position_move_states = {}
    end
end
S_position_move_states[obj.index + 1] = { obj.ox, obj.oy }

local function get_random_order_index()
    local indexes = {}
    for i = 0, obj.num - 1 do
        indexes[i + 1] = i
    end
    for i = 0, obj.num - 1 do
        local dest = 0
        dest = rand(0, obj.num - 1, -obj.num, i + 1)
        local swap = indexes[i + 1]
        indexes[i + 1] = indexes[dest + 1]
        indexes[dest + 1] = swap
    end
    return indexes[obj.index + 1]
end

local function get_order_index()
    if order_mode == 0 then
        return obj.index
    elseif order_mode == 1 then
        return obj.num - 1 - obj.index
    elseif order_mode == 2 then
        return get_random_order_index()
    elseif order_mode == 3 then
        return rand(0, 100 * (obj.num - 1), obj.index, 0) / 100
    elseif order_mode == 4 then
        return math.abs((obj.num - 1) / 2 - obj.index)
    else
        return (obj.num - 1) / 2 - math.abs((obj.num - 1) / 2 - obj.index)
    end
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

if progress <= 0 then
    return
end

progress = apply_easing(math.min(progress, 1))
for i = 0, obj.num - 1 do
    local position_state = S_position_move_states[i + 1]
    local x = positions[i * 2 + 1] - position_state[1]
    local y = positions[i * 2 + 2] - position_state[2]
    local alpha = 0
    if i == obj.index then
        alpha = 1
    end
    obj.draw(x * progress, y * progress, 0, 1, alpha)
end
