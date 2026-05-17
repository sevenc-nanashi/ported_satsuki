--label:${ROOT_CATEGORY}\切り替え効果\@TA\削除済み
---$track:時間[s]
---min=0
---max=10
---step=0.01
local duration = 2

---$track:間隔[s]
---min=0
---max=10
---step=0.01
local interval = 1

---$track:傾き範囲
---min=0
---max=360
---step=0.1
local tilt_range = 30

---$check:縮小
local shrinks = false

if duration == 0 then
    return
end

local progress = (duration - obj.time + obj.index * interval) / duration
local alpha = progress
if progress > 0 then
    if progress > 1 then
        progress = 1
        alpha = 0
    end
else
    progress = 0
end

local range_width = obj.screen_w / 2 - obj.w * obj.zoom
local range_height = obj.screen_h / 2 - obj.h * obj.zoom
obj.ox = obj.rand(-range_width, range_width, obj.index, 0)
obj.oy = obj.rand(-range_height, range_height, obj.index, 0)
obj.zoom = 1 - progress
obj.alpha = alpha
obj.rz = obj.rand(-tilt_range / 2, tilt_range / 2, 0, obj.index)
if shrinks then
    obj.zoom = progress
end
