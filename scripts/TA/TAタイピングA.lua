--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:表示速度
---min=1
---max=100
local display_speed = 5

local character_interval = 1 / display_speed -- 単位：秒/文字
if obj.index == 0 or S_ta_typing_positions == nil then
    S_ta_typing_positions = {}
end
S_ta_typing_interval = character_interval
S_ta_typing_count = obj.num
S_ta_typing_positions[obj.index + 1] = { obj.ox, obj.oy, obj.w, obj.h }

if obj.time < obj.index * character_interval + character_interval then
    obj.alpha = 0
end
