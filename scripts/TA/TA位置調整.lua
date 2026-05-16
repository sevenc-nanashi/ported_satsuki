--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:散逸度
---min=0
---max=100
---step=0.1
local dispersion = 100

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
