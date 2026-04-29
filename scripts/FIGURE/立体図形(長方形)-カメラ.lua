--track0:サイズ,1,1000,100,1
--track1:奥行き,1,500,20,1
--track2:ライン幅,0,4000,4000,1
--track3:縦横比,-100,100,0
--color:0xffffff
s = obj.track0
w = obj.track1
h = math.min(obj.track2, s / 2)
aspect = obj.track3
asx = math.max(aspect, 0)
asy = math.max(-aspect, 0)

obj.load("figure", "四角形", color, s, h)
obj.effect()
x0 = s / 2 * (1 - asx / 100)
y0 = s / 2 * (1 - asy / 100)
obj.drawpoly(-x0, -y0, w / 2, x0, -y0, w / 2, x0, y0, w / 2, -x0, y0, w / 2)
obj.drawpoly(-x0, -y0, -w / 2, x0, -y0, -w / 2, x0, y0, -w / 2, -x0, y0, -w / 2)

for k = 0, 1 do
	s = s - 2 * h * k
	obj.load("figure", "四角形", color, s / 2)
	obj.effect()
	x0 = s / 2 * (1 - asx / 100)
	y0 = -s / 2 * (1 - asy / 100)
	obj.drawpoly(x0, y0, -w / 2, x0, y0, w / 2, x0, -y0, w / 2, x0, -y0, -w / 2)
	obj.drawpoly(-x0, y0, -w / 2, -x0, y0, w / 2, -x0, -y0, w / 2, -x0, -y0, -w / 2)
	obj.drawpoly(-x0, y0, -w / 2, -x0, y0, w / 2, x0, y0, w / 2, x0, y0, -w / 2)
	obj.drawpoly(-x0, -y0, -w / 2, -x0, -y0, w / 2, x0, -y0, w / 2, x0, -y0, -w / 2)
end
