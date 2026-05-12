--label:${ROOT_CATEGORY}\図形
---$track:長さ
---min=0
---max=5000
local length = 100
---$track:幅
---min=0
---max=500
local weight = 20
---$track:3サイズ
---min=0
---max=1000
local tip_size = 50
---$track:3横幅
---min=0
---max=1000
local tip_width = 100
---$color:色
local color = 0xffffff

local tw = tip_width / 100
local b = 2 --位置調整

obj.load("figure", "三角形", color, tip_size * 2)
local sx = tip_size / 2 * tw
local sy = -length - tip_size / 2 - tip_size / 2 * math.sin(math.pi * 30 / 180) + b
obj.setoption("drawtarget", "tempbuffer", (length + tip_size) * 2, (length + tip_size) * 2)
obj.drawpoly(-sx, sy, 0, sx, sy, 0, sx, sy + tip_size, 0, -sx, sy + tip_size, 0)

obj.load("figure", "四角形", color, 2)
obj.setoption("drawtarget", "tempbuffer")
obj.drawpoly(-weight / 2, -length, 0, weight / 2, -length, 0, weight / 2, 0, 0, -weight / 2, 0, 0)

obj.load("tempbuffer")
