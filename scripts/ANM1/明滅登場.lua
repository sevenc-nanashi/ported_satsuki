--label:${ROOT_CATEGORY}\切り替え効果
---$track:登場[f]
---min=0
---max=150
---step=1
local fade_in_frames = 4
---$track:退場[f]
---min=0
---max=150
---step=1
local fade_out_frames = 4

if fade_in_frames > 0 and obj.frame <= fade_in_frames and obj.frame % 2 == 1 then
    obj.alpha = 0
end

if fade_out_frames > 0 and obj.totalframe - obj.frame <= fade_out_frames and obj.frame % 2 == 0 then
    obj.alpha = 0
end
