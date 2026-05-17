--label:${ROOT_CATEGORY}\切り替え効果\@TA\削除済み
local duration = S_random_text_duration or 1
local interval = S_random_text_interval or 0.3
local zoom_rate = S_random_text_zoom_rate or 100
local y_distance = S_random_text_y_distance or -200
local fade_rate = S_random_text_fade_rate or 0

local order_index = obj.rand(0, 100 * (obj.num - 1), -(obj.index + 1), 0) / 100
local progress
if duration == 0 then
    return
elseif duration < 0 then
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
    obj.alpha = obj.alpha * (1 - progress * fade_rate)
    obj.zoom = obj.zoom + progress * (zoom_rate - 100) / 100
    obj.oy = obj.oy + y_distance * progress
else
    obj.alpha = 0
end
