--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:半径
---min=1
---max=2000
local l = 200
---$track:ライン幅
---min=0
---max=2000
local w = 10
---$track:辺数
---min=3
---max=24
---step=1
local num_edges = 4
---$track:回転数
---min=1
---max=10
---step=1
local num_skips = 1
---$color:色
local color = 0xffffff

local n = math.floor(num_edges)
local m = math.floor(num_skips)
if w >= l then
    w = l
end
obj.load("figure", "四角形", color, 2)
obj.setoption("dst", "tmp", l * 2, l * 2)
obj.setoption("blend", "alpha_add")
for i = 0, n - 1 do
    r0 = math.rad(m * 360 * i / n)
    r1 = math.rad(m * 360 * (i + 1) / n)
    x0 = math.cos(r0) * l
    x1 = math.cos(r1) * l
    x2 = math.cos(r1) * l * (1 - w / l)
    x3 = math.cos(r0) * l * (1 - w / l)
    y0 = math.sin(r0) * l
    y1 = math.sin(r1) * l
    y2 = math.sin(r1) * l * (1 - w / l)
    y3 = math.sin(r0) * l * (1 - w / l)
    obj.drawpoly(x0, y0, 0, x1, y1, 0, x2, y2, 0, x3, y3, 0, 0, 0, 1, 0, 1, 1, 0, 1)
end
obj.load("tempbuffer")
