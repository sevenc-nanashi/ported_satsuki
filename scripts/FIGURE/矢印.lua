--track0:長さ,0,5000,100
--track1:幅,0,500,20
--track2:3サイズ,0,1000,50
--track3:3横幅,0,1000,100
--color:0xffffff

l = obj.track0
w = obj.track1
s = obj.track2
tw = obj.track3 / 100
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
