--track0:サイズ,1,1000,100,1
--track1:奥行き,1,500,20,1
--track2:ライン幅,0,4000,4000,1
--track3:分割数,3,100,50,1
--color:0xffffff
s = obj.track0
w = obj.track1
h = math.min(obj.track2, s / 2)
n = obj.track3

obj.load("figure", "円", color, s, h)
obj.effect()
x = obj.w / 2
y = obj.h / 2
obj.drawpoly(-x, -y, w / 2, x, -y, w / 2, x, y, w / 2, -x, y, w / 2)
obj.drawpoly(-x, -y, -w / 2, x, -y, -w / 2, x, y, -w / 2, -x, y, -w / 2)

for k = 0, 1 do
	s = s - 2 * h * k
	obj.load("figure", "四角形", color, s / n)
	obj.effect()
	l = s / 2
	r = 360 / n
	for i = 0, n - 1 do
		x0 = l * math.cos(math.pi / 180 * r * (i + 1))
		x1 = l * math.cos(math.pi / 180 * r * i)
		y0 = l * math.sin(math.pi / 180 * r * (i + 1))
		y1 = l * math.sin(math.pi / 180 * r * i)
		obj.drawpoly(x0, y0, -w / 2, x0, y0, w / 2, x1, y1, w / 2, x1, y1, -w / 2)
	end
end
