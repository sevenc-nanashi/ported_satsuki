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

---$track:角度
---min=-360
---max=360
---step=0.1
local direction_angle = 0

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

if duration == 0 then
    return
end

local order_index = get_order_index()
local progress
if duration < 0 then
    progress = (duration - obj.num * interval - obj.time + obj.totaltime + order_index * interval) / duration
else
    progress = (duration - obj.time + order_index * interval) / duration
end

if progress > 0 then
    local angle = math.rad(direction_angle)
    local screen_diagonal = math.sqrt(obj.screen_w * obj.screen_w + obj.screen_h * obj.screen_h)
    local distance = progress * screen_diagonal
    obj.ox = obj.ox + math.sin(angle) * distance
    obj.oy = obj.oy - math.cos(angle) * distance
    obj.zoom = obj.zoom + (distance / screen_diagonal) * (zoom_rate / 100 - 100) / 100

    local blur_range = screen_diagonal / (math.abs(duration) * 60)
    if blur_range < 1 then
        blur_range = 1
    elseif blur_range > 100 then
        blur_range = 100
    end
    obj.effect("方向ブラー", "角度", direction_angle, "範囲", blur_range)
end
