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
---$track:範囲
---min=0
---max=300
---step=1
local blur_range = 10
---$select:登場順
---順番=0
---逆順=1
---ランダム順=2
---ランダム間隔=3
---内側から=4
---外側から=5
local order = 0
---$check:左から
local from_left = false

local direction = 1

local order_index
if order == 0 then
    order_index = obj.index -- 順番に登場
elseif order == 1 then
    order_index = obj.num - 1 - obj.index -- 後ろから登場
elseif order == 2 then
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
    order_index = indexes[obj.index + 1] -- ランダム順に登場
elseif order == 3 then
    order_index = rand(0, 100 * (obj.num - 1), obj.index, 0) / 100 -- ランダム間隔に登場
elseif order == 4 then
    order_index = math.abs((obj.num - 1) / 2 - obj.index) -- 内側から登場
else
    order_index = (obj.num - 1) / 2 - math.abs((obj.num - 1) / 2 - obj.index) -- 外側から登場
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

    progress = progress * progress
    if from_left then
        direction = -direction
    end
    obj.ox = obj.ox + (obj.screen_w + obj.w) * progress * direction
    obj.oy = obj.oy + obj.h / 2
    obj.zoom = obj.zoom + 2
    obj.aspect = obj.aspect - 0.9
    obj.effect("ぼかし", "範囲", blur_range, "縦横比", 100)
end
