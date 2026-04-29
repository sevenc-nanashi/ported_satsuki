--track0:透明度2,0,100,0
--track1:角度,-720,720,0
--track2:回転軸,0,2,0,1
jiku = obj.track2
obj.load("figure", "四角形", 0xffffff, 1)
obj.drawpoly(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
x = obj.getvalue("x")
y = obj.getvalue("y")
z = obj.getvalue("z")
zoom = obj.getvalue("zoom") / 100
alpha = 1 - obj.getvalue(0) / 100
r = obj.getvalue(1)
