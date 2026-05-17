--label:${ROOT_CATEGORY}\切り替え効果\@TA\削除済み
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 1

---$track:間隔[s]
---min=0
---max=2
---step=0.01
local interval = 0.3

---$track:拡大率
---min=0
---max=800
---step=0.1
local zoom_rate = 100

---$track:Y軸距離
---min=-1000
---max=1000
---step=0.1
local y_distance = -200

---$check:フェード
local fades = false

S_random_text_duration = duration
S_random_text_interval = interval
S_random_text_zoom_rate = zoom_rate
S_random_text_y_distance = y_distance
S_random_text_fade_rate = fades and 1 or 0

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
    obj.alpha = 0
end
