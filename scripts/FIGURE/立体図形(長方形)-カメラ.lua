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
---$track:縦横比
---min=-100
---max=100
local aspect = 0
---$color:色
local color = 0xffffff

local h = math.min(weight, size / 2)
local asx = math.max(aspect, 0)
local asy = math.max(-aspect, 0)

obj.load("figure", "四角形", color, size, h)
obj.effect()
local x0 = size / 2 * (1 - asx / 100)
local y0 = size / 2 * (1 - asy / 100)
obj.drawpoly(-x0, -y0, length / 2, x0, -y0, length / 2, x0, y0, length / 2, -x0, y0, length / 2)
obj.drawpoly(-x0, -y0, -length / 2, x0, -y0, -length / 2, x0, y0, -length / 2, -x0, y0, -length / 2)

for k = 0, 1 do
    size = size - 2 * h * k
    obj.load("figure", "四角形", color, size / 2)
    obj.effect()
    x0 = size / 2 * (1 - asx / 100)
    y0 = -size / 2 * (1 - asy / 100)
    obj.drawpoly(x0, y0, -length / 2, x0, y0, length / 2, x0, -y0, length / 2, x0, -y0, -length / 2)
    obj.drawpoly(-x0, y0, -length / 2, -x0, y0, length / 2, -x0, -y0, length / 2, -x0, -y0, -length / 2)
    obj.drawpoly(-x0, y0, -length / 2, -x0, y0, length / 2, x0, y0, length / 2, x0, y0, -length / 2)
    obj.drawpoly(-x0, -y0, -length / 2, -x0, -y0, length / 2, x0, -y0, length / 2, x0, -y0, -length / 2)
end
