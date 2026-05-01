--label:${ROOT_CATEGORY}\オブジェクト制御
---$track:透明度2
---min=0
---max=100
local transparency2 = 0
---$track:角度
---min=-720
---max=720
local angle = 0
---$select:回転軸
---X=0
---Y=1
---Z=2
local jiku = 0
obj.load("figure", "四角形", 0xffffff, 1)
obj.drawpoly(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
S_GRP_x = obj.getvalue("x")
S_GRP_y = obj.getvalue("y")
S_GRP_z = obj.getvalue("z")
S_GRP_zoom = obj.getvalue("zoom") / 100
S_GRP_alpha = 1 - transparency2 / 100
S_GRP_r = angle
S_GRP_jiku = jiku
