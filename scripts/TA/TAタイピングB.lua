--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$script_tips:テキストオブジェクトに適用して下さい。
---$tips:カーソルの横幅を指定した値だけ短くします、
---$track:-横幅
---min=0
---max=256
local cursor_width_reduction = 0
---$tips:カーソルの太さを指定します。
---$track:太さ
---min=0
---max=256
local cursor_thickness = 1
---$tips:カーソルの色を指定します。
---$color:色
local cursor_color = 0xffffff

local positions = S_ta_typing_positions
local character_interval = S_ta_typing_interval
local character_count = S_ta_typing_count

if positions == nil or character_interval == nil or character_count == nil then
    obj.alpha = 0
else
    obj.effect()
    if obj.index <= character_count - 1 then
        local position = positions[obj.index + 1]
        if position then
            obj.ox = position[1] - position[3] / 2 + obj.w / 2
            obj.oy = position[2]
            if
                obj.time < character_interval * (obj.index + 0.5)
                or obj.time >= character_interval * (obj.index + 1)
            then
                obj.alpha = 0
            end
        else
            obj.alpha = 0
        end
    else
        obj.alpha = 0
    end
    obj.draw()

    -- カーソル
    if obj.time < character_interval * character_count and positions[1] then
        local cursor_height = positions[1][4]
        local cursor_index = math.floor(obj.time / character_interval)
        local cursor_position = positions[cursor_index + 1]
        if cursor_position then
            obj.load("figure", "四角形", cursor_color, cursor_height)
            obj.effect("クリッピング", "上", cursor_height - cursor_thickness, "右", cursor_width_reduction)
            obj.effect()
            local cursor_x = cursor_position[1] + cursor_height / 2 - cursor_position[3] / 2
            local cursor_y = cursor_position[2]
            obj.draw(cursor_x, cursor_y)
        end
    end
end
