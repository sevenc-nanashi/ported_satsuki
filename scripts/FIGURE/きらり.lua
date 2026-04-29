---$track:サイズ
---min=1
---max=2000
local s = 300
---$track:幅
---min=0
---max=500
local track1 = 100
---$track:円透明
---min=0
---max=100
local track2 = 70
--color:0xffffff
obj.setoption("dst", "tmp", s, s)
obj.load("figure", "三角形", color, s / 2)
obj.effect("ぼかし", "範囲", s / 15, "縦横比", 100)
w = s / 200 * track1 / 100
h = s / 4 * 3 / 2
obj.drawpoly(-w, -h, 0, w, -h, 0, w, h / 3, 0, -w, h / 3, 0)
obj.drawpoly(h, -w, 0, h, w, 0, -h / 3, w, 0, -h / 3, -w, 0)
obj.drawpoly(w, h, 0, -w, h, 0, -w, -h / 3, 0, w, -h / 3, 0)
obj.drawpoly(-h, w, 0, -h, -w, 0, h / 3, -w, 0, h / 3, w, 0)

obj.load("tempbuffer")
obj.draw(0, 0, 0, 0.5, 1, 0, 0, 45)
obj.alpha = 0

obj.load("figure", "円", color, s / 3, s / 25)
obj.effect("ぼかし", "範囲", s / 7.5)
obj.draw(0, 0, 0, 1, track2 / 100)

obj.load("figure", "円", color, s / 15)
obj.effect("ぼかし", "範囲", s / 60)
obj.draw()
obj.load("tempbuffer")
