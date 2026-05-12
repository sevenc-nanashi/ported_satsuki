--label:${ROOT_CATEGORY}\図形\立体図形
---$track:サイズ
---min=1
---max=1000
---step=1
local size = 100
---$track:奥行き
---min=1
---max=500
---step=1
local length = 20
---$track:ライン幅
---min=0
---max=4000
---step=1
local weight = 4000
---$color:色
local color = 0xffffff

local h = math.min(weight, size / 2)

obj.load("figure", "星型", color, size, h)
obj.effect()
local x = obj.w / 2
local y = obj.h / 2
obj.drawpoly(-x, -y, length / 2, x, -y, length / 2, x, y, length / 2, -x, y, length / 2)
obj.drawpoly(-x, -y, -length / 2, x, -y, -length / 2, x, y, -length / 2, -x, y, -length / 2)

for k = 0, 1 do
    size = size - 2 * h * k
    obj.load("figure", "四角形", color, size / 2)
    obj.effect()
    local l = size / 2 * math.sin(18 * math.pi / 180) / math.cos(36 * math.pi / 180) - 1
    for i = 0, 4 do
        for j = 0, 1 do
            local x0 = -size / 2 * math.sin(72 * i * math.pi / 180)
            local x1 = l * math.cos((54 + 72 * i + 72 * j) * math.pi / 180)
            local y0 = -size / 2 * math.cos(72 * i * math.pi / 180)
            local y1 = -l * math.sin((54 + 72 * i + 72 * j) * math.pi / 180)
            obj.drawpoly(x0, y0, -length / 2, x0, y0, length / 2, x1, y1, length / 2, x1, y1, -length / 2)
        end
    end
end
