--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:時間[s]
---min=0
---max=5
---step=0.01
local duration = 0.3

---$track:イン[s]
---min=-1
---max=5
---step=0.01
local in_duration = 1

---$track:アウト[s]
---min=-1
---max=5
---step=0.01
local out_duration = 1

---$select:登場順
---順番=0
---逆順=1
---ランダム順=2
---ランダム間隔=3
---内側から=4
---外側から=5
local order_mode = 2

---$check:フェード
local fades = true

---$track:X距離
---min=-2000
---max=2000
---step=0.1
local distance_x = 0

---$track:Y距離
---min=-2000
---max=2000
---step=0.1
local distance_y = 0

---$track:Z距離
---min=-2000
---max=2000
---step=0.1
local distance_z = 0

--trackgroup@distance_x,distance_y,distance_z:距離

---$track:拡大
---min=0
---max=1000
---step=0.1
local zoom_rate = 100

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

---$check:アウトは逆方向
local reverses_out = true

--インアウトがマイナスの時は最初or最後の中間点でフェードインアウト。数値の時は指定した秒数でフェードインアウト。ゼロのときはフェードインアウトなし。

if duration == 0 then
    return
end

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

local function apply_transform(progress, direction)
    if progress <= 0 then
        return
    end

    if progress > 1 then
        obj.alpha = 0
        progress = 1
    end
    progress = progress ^ easing_power

    obj.ox = obj.ox + distance_x * progress * direction
    obj.oy = obj.oy + distance_y * progress * direction
    obj.oz = obj.oz + distance_z * progress * direction
    obj.rx = obj.rx + rotation_x * progress * direction
    obj.ry = obj.ry + rotation_y * progress * direction
    obj.rz = obj.rz + rotation_z * progress * direction
    obj.zoom = obj.zoom + progress * (zoom_rate - 100) / 100
    if fades then
        obj.alpha = obj.alpha * (1 - progress)
    end
end

local order_index = get_order_index()

--シーンイン
if in_duration ~= 0 then
    if in_duration < 0 then
        in_duration = obj.getvalue("time", 0, 1)
    end

    local progress = (duration - obj.time + order_index * in_duration / obj.num) / duration
    apply_transform(progress, 1)
end

--シーンアウト
if out_duration ~= 0 then
    if out_duration < 0 then
        out_duration = obj.totaltime - obj.getvalue("time", 0, obj.getoption("section_num") - 1)
    end

    local progress = -(
            -duration
            - obj.num * out_duration / obj.num
            - obj.time
            + obj.totaltime
            + order_index * out_duration / obj.num
        ) / duration
    local out_direction = reverses_out and -1 or 1
    apply_transform(progress, out_direction)
end
