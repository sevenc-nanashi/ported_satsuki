--label:${ROOT_CATEGORY}\カスタムオブジェクト
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
---$track:分割数
---min=3
---max=100
---step=1
local divisions = 50
---$color:色
local color = 0xffffff

local h = math.min(weight, size / 2)

obj.load("figure", "円", color, size, h)
obj.effect()
local x = obj.w / 2
local y = obj.h / 2
obj.drawpoly(-x, -y, length / 2, x, -y, length / 2, x, y, length / 2, -x, y, length / 2)
obj.drawpoly(-x, -y, -length / 2, x, -y, -length / 2, x, y, -length / 2, -x, y, -length / 2)

for k = 0, 1 do
    size = size - 2 * h * k
    obj.load("figure", "四角形", color, math.ceil(size / divisions))
    obj.effect()
    local l = size / 2 + (k * 2 - 1)
    local r = 360 / divisions
    local polygons = {}
    for i = 0, divisions - 1 do
        local x0 = l * math.cos(math.pi / 180 * r * (i + 1))
        local x1 = l * math.cos(math.pi / 180 * r * i)
        local y0 = l * math.sin(math.pi / 180 * r * (i + 1))
        local y1 = l * math.sin(math.pi / 180 * r * i)
        table.insert(polygons, {
            x0,
            y0,
            -length / 2,
            x0,
            y0,
            length / 2,
            x1,
            y1,
            length / 2,
            x1,
            y1,
            -length / 2,
            0,
            0,
            obj.w,
            0,
            obj.w,
            obj.h,
            0,
            obj.h,
        })
    end
    obj.drawpoly(polygons)
end
