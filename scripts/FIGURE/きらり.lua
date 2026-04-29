--track0:サイズ,1,2000,300
--track1:幅,0,500,100
--track2:円透明,0,100,70
--color:0xffffff
s = obj.track0
obj.setoption("dst", "tmp", s, s)
obj.load("figure", "三角形", color, s / 2)
obj.effect("ぼかし", "範囲", s / 15, "縦横比", 100)
w = s / 200 * obj.track1 / 100
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
obj.draw(0, 0, 0, 1, obj.track2 / 100)

obj.load("figure", "円", color, s / 15)
obj.effect("ぼかし", "範囲", s / 60)
obj.draw()
obj.load("tempbuffer")
