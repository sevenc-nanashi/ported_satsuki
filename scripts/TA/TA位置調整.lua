--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$script_tips:一文字毎のテキストの位置を、マウスドラッグで調整します。
---:※テキストは16文字以下で使用して下さい。
---:また、Ctrlを押しながら各アンカーポイント(破線の円)をドラッグすると、
---:元座標を動かさずに全体を移動できます。
---$tips:散逸度をゼロにすると、テキストの位置が元の位置に戻ります。
---$track:散逸度
---min=0
---max=100
---step=0.1
local dispersion = 100

---$tips:数値入力により、各テキストの座標を指定することもできます。
---:なお、マウスドラッグにより値が自動的に更新される項目なので、
---:通常は調整する必要のない項目かもしれません。
---$value:座標
local positions = {}

obj.effect()
local dispersion_rate = dispersion / 100
obj.setanchor("positions", obj.num, "line")

if obj.index == 0 then
    if S_position_adjust_states == nil then
        S_position_adjust_states = {}
    end
end
S_position_adjust_states[obj.index + 1] = { obj.ox, obj.oy }

for i = 0, obj.num - 1 do
    local position_state = S_position_adjust_states[i + 1]
    local x = positions[i * 2 + 1] - position_state[1]
    local y = positions[i * 2 + 2] - position_state[2]
    if i == obj.index then
        obj.draw(x * dispersion_rate, y * dispersion_rate)
    end
end
