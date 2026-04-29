---$track:X幅
---min=0
---max=20000
local track0 = 100
---$track:Y幅
---min=0
---max=20000
local track1 = 100
---$track:X中心%
---min=-100
---max=100
local track2 = 0
---$track:Y中心%
---min=-100
---max=100
local track3 = 0
--color:0xffffff
obj.load("figure", "四角形", color, 2)
sx = track0 / 2
sy = track1 / 2
cx = track2 / 100
cy = track3 / 100
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
