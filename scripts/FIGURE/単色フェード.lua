--label:${ROOT_CATEGORY}\切り替え効果
---$track:イン
---min=0
---max=10
---step=0.01
local fade_in_duration = 0.5
---$track:アウト
---min=0
---max=10
---step=0.01
local fade_out_duration = 0.5
---$color:色
local fade_color = 0xffffff

obj.load("figure", "背景", fade_color, 100)
obj.alpha = 0

if fade_in_duration > 0 and obj.time < fade_in_duration then
    local fade_in_alpha = (fade_in_duration - obj.time) / fade_in_duration
    obj.alpha = fade_in_alpha
end

if fade_out_duration > 0 and obj.time > obj.totaltime - fade_out_duration then
    local fade_out_alpha = (fade_out_duration + obj.time - obj.totaltime) / fade_out_duration
    obj.alpha = fade_out_alpha
end
