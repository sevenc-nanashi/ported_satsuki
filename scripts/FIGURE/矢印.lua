---$track:長さ
---min=0
---max=5000
local l = 100
---$track:幅
---min=0
---max=500
local w = 20
---$track:3サイズ
---min=0
---max=1000
local s = 50
---$track:3横幅
---min=0
---max=1000
local track3 = 100
--color:0xffffff

tw = track3 / 100
b = 2 --位置調整

obj.load("figure", "三角形", color, s * 2)
sx = s / 2 * tw
sy = -l - s / 2 - s / 2 * math.sin(math.pi * 30 / 180) + b
obj.setoption("dst", "tmp", (l + s) * 2, (l + s) * 2)
obj.drawpoly(-sx, sy, 0, sx, sy, 0, sx, sy + s, 0, -sx, sy + s, 0)

obj.load("figure", "四角形", color, 2)
obj.setoption("dst", "tmp")
obj.drawpoly(-w / 2, -l, 0, w / 2, -l, 0, w / 2, 0, 0, -w / 2, 0, 0)

obj.load("tempbuffer")
