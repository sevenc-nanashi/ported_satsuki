--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:間隔[s]
---min=-5
---max=5
---step=0.01
local interval = 0.3

---$track:速度
---min=-1000
---max=1000
---step=0.1
local rotation_speed = 270

---$track:待機[s]
---min=0
---max=10
---step=0.01
local wait_time = 0

---$select:登場順
---順番=0
---後ろから=1
---ランダム順=2
---ランダム間隔=3
---内側から=4
---外側から=5
local order_mode = 0

---$check:X軸回転
local rotates_x = false

---$check:Y軸回転
local rotates_y = false

---$check:Z軸回転
local rotates_z = true

---$track:移動距離
---min=0
---max=2000
---step=0.1
local move_distance = 0

---$track:移動角度
---min=-360
---max=360
---step=0.1
local move_angle = 0

---$check:ランダム角度
local random_angle = false

local elapsed_time = obj.time - wait_time
local interval_length = math.abs(interval)
local rotation_duration = math.abs(360 / rotation_speed)

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
    end
    return (obj.num - 1) / 2 - math.abs((obj.num - 1) / 2 - obj.index)
end

local order_index = get_order_index()
local progress
if interval < 0 then
    progress = -(
            -rotation_duration
            - obj.num * interval_length
            - obj.time
            - wait_time
            + obj.totaltime
            + order_index * interval_length
        ) / rotation_duration
else
    progress = (rotation_duration - elapsed_time + order_index * interval_length) / rotation_duration
end

if progress > 0 then
    local angle = move_angle
    if random_angle then
        angle = obj.rand(0, 360, 0, obj.index)
    end
    local x_rotation_factor = rotates_x and 1 or 0
    local y_rotation_factor = rotates_y and 1 or 0
    local z_rotation_factor = rotates_z and 1 or 0

    obj.ox = obj.ox + math.cos(math.rad(angle)) * progress * move_distance
    obj.oy = obj.oy + math.sin(math.rad(angle)) * progress * move_distance
    obj.rx = obj.rx + rotation_speed * progress * x_rotation_factor
    obj.ry = obj.ry + rotation_speed * progress * y_rotation_factor
    obj.rz = obj.rz + rotation_speed * progress * z_rotation_factor
end
