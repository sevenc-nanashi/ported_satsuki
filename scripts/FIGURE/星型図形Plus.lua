--label:${ROOT_CATEGORY}\図形
---$track:半径
---min=1
---max=2000
local radius = 100
---$track:内角
---min=1
---max=108
local inner_angle = 36
---$track:ライン幅
---min=0
---max=100
local weight = 0
---$track:透明度
---min=0
---max=100
local alpha = 0
---$color:色
local color = 0xffffff

local r = math.rad(inner_angle)

obj.load("figure", "四角形", color, 2)
local x = math.tan(r / 2) * radius
obj.setoption("drawtarget", "tempbuffer", radius * 2, radius * 2)
obj.drawpoly(-x, 0, 0, -x, 0, 0, 0, -radius, 0, x, 0, 0)

obj.load("tempbuffer")
obj.effect("斜めクリッピング", "中心Y", 5, "角度", inner_angle * 54 / 108)
obj.effect("斜めクリッピング", "中心Y", 5, "角度", -inner_angle * 54 / 108)
obj.setoption("dst", "tmp", radius * 2, radius * 2)
for i = 0, 4 do
    obj.draw(0, 0, 0, 1, 1, 0, 0, 72 * i)
end

obj.load("tempbuffer")
obj.setoption("drawtarget", "tempbuffer")
obj.setoption("blend", "alpha_sub")
obj.draw(0, 0, 0, weight / 100, 1 - alpha / 100)
obj.load("tempbuffer")
