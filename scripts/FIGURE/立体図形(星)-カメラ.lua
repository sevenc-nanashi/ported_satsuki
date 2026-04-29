--track0:サイズ,1,1000,100,1
--track1:奥行き,1,500,20,1
--track2:ライン幅,0,4000,4000,1
--color:0xffffff
s = obj.track0
w = obj.track1
h = math.min(obj.track2, s / 2)

obj.load("figure", "星型", color, s, h)
obj.effect()
x = obj.w / 2
y = obj.h / 2
obj.drawpoly(-x, -y, w / 2, x, -y, w / 2, x, y, w / 2, -x, y, w / 2)
obj.drawpoly(-x, -y, -w / 2, x, -y, -w / 2, x, y, -w / 2, -x, y, -w / 2)

for k = 0, 1 do
	s = s - 2 * h * k
	obj.load("figure", "四角形", color, s / 2)
	obj.effect()
	l = s / 2 * math.sin(18 * math.pi / 180) / math.cos(36 * math.pi / 180)
	for i = 0, 4 do
		for j = 0, 1 do
			x0 = -s / 2 * math.sin(72 * i * math.pi / 180)
			x1 = l * math.cos((54 + 72 * i + 72 * j) * math.pi / 180)
			y0 = -s / 2 * math.cos(72 * i * math.pi / 180)
			y1 = -l * math.sin((54 + 72 * i + 72 * j) * math.pi / 180)
			obj.drawpoly(x0, y0, -w / 2, x0, y0, w / 2, x1, y1, w / 2, x1, y1, -w / 2)
		end
	end
end
