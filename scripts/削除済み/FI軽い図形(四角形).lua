--label:${ROOT_CATEGORY}\カスタムオブジェクト\削除済み
---$track:X幅
---min=0
---max=20000
local width = 100
---$track:Y幅
---min=0
---max=20000
local height = 100
---$track:X中心%
---min=-100
---max=100
local center_x = 0
---$track:Y中心%
---min=-100
---max=100
local center_y = 0
---$color:色
local color = 0xffffff

obj.load("figure", "四角形", color, 2)
local sx = width / 2
local sy = height / 2
local cx = center_x / 100
local cy = center_y / 100
obj.drawpoly(
	-sx * (1 + cx),
	-sy * (1 + cy),
	0,
	sx * (1 - cx),
	-sy * (1 + cy),
	0,
	sx * (1 - cx),
	sy * (1 - cy),
	0,
	-sx * (1 + cx),
	sy * (1 - cy),
	0
)
