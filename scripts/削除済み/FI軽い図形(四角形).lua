--track0:X幅,0,20000,100
--track1:Y幅,0,20000,100
--track2:X中心%,-100,100,0
--track3:Y中心%,-100,100,0
--color:0xffffff
obj.load("figure", "四角形", color, 2)
sx = obj.track0 / 2
sy = obj.track1 / 2
cx = obj.track2 / 100
cy = obj.track3 / 100
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
