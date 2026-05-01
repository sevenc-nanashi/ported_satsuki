--label:${ROOT_CATEGORY}\オブジェクト制御
---$track:透明度2
---min=0
---max=100
local track0 = 0
---$track:角度
---min=-720
---max=720
local track1 = 0
---$track:回転軸
---min=0
---max=2
---step=1
local jiku = 0
obj.load("figure", "四角形", 0xffffff, 1)
obj.drawpoly(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
x = obj.getvalue("x")
y = obj.getvalue("y")
z = obj.getvalue("z")
zoom = obj.getvalue("zoom") / 100
alpha = 1 - obj.getvalue(0) / 100
r = obj.getvalue(1)
