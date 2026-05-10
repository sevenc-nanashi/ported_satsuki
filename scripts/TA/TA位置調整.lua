--label:${ROOT_CATEGORY}\切り替え効果\TA
---$track:散逸度
---min=0
---max=100
local track0 = 100
---$value:座標
local pos = {}

obj.effect()
r = track0 / 100
obj.setanchor("pos", obj.num, "line")

if obj.index == 0 then
    if pp == null then
        pp = {}
    end
end
pp[obj.index + 1] = { obj.ox, obj.oy }

for i = 0, obj.num - 1 do
    x = pos[i * 2 + 1] - pp[i + 1][1]
    y = pos[i * 2 + 2] - pp[i + 1][2]
    if i == obj.index then
        alp = 1
    else
        alp = 0
    end
    obj.draw(x * r, y * r, 0, 1, alp)
end
