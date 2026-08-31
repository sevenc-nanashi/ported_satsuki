--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$script_tips:テキストを表示する際にタイピングするように、アルファベットを一瞬表示させます。
---:カーソルも表示されます。ただし厳密なものではなく、雰囲気だけのものです。
---:テキストオブジェクトに(A)を適用し、すぐ下のレイヤーに別のテキストを配置＆(B)を適用して下さい。
---:(B)のテキストには適当なアルファベットを入力すると、そのアルファベットが一瞬表示されます。
---$tips:テキストの表示速度を指定します。
---:数値は1秒間に表示される文字の数を表します。
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
