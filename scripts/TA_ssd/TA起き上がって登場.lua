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
---後ろから=1
---ランダム順=2
---ランダム間隔=3
---内側から=4
---外側から=5
local order_mode = 0

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

local function apply_rising_easing(progress)
    local bounce_count = momentum * 2 + 1
    if bounce_count <= 1 then
        return progress * progress
    elseif progress > 1 - 1 / bounce_count then
        return 1 - (1 - progress) * bounce_count
    end

    progress = progress * bounce_count / (bounce_count - 1)
    return math.sin((progress - 1) * (bounce_count - 1) * math.pi) * progress * 0.4 / (1 + (1 - progress) * 3)
end

local order_index = get_order_index()
if overall_appearance then
    duration = duration * (1 - order_index / obj.num)
    interval = interval / obj.num
end

if duration == 0 then
    return
end

local progress
if duration < 0 then
    progress = (duration - obj.num * interval - obj.time + obj.totaltime + order_index * interval) / duration
else
    progress = (duration - obj.time + order_index * interval) / duration
end

if progress > 0 then
    if progress > 1 then
        obj.alpha = 0
        progress = 1
    end
    progress = apply_rising_easing(progress)
    obj.rx = obj.rx - 90 * progress
    obj.oy = obj.oy + obj.h * (1 - math.cos(progress * math.pi / 2)) / 2
    obj.oz = obj.oz + obj.h * math.sin(progress * math.pi / 2) / 2
end
