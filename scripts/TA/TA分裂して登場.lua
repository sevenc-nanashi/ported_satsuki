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

---$track:ぼかし
---min=0
---max=200
---step=0.1
local blur = 20

---$select:登場順
---順番=0
---後ろから=1
---ランダム順=2
---ランダム間隔=3
---内側から=4
---外側から=5
local order_mode = 0

---$check:横方向
local horizontal = false

obj.effect()

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

if progress <= 0 then
    return
end

if progress > 1 then
    obj.alpha = 0
    progress = 1
end
progress = progress * progress

local x = 0
local y = progress * obj.screen_w
local blur_aspect = -100
if horizontal then
    x = progress * obj.screen_w
    y = 0
    blur_aspect = 100
end

obj.effect("ぼかし", "範囲", blur, "縦横比", blur_aspect)
obj.draw(x, y)
obj.draw(-x, -y)
