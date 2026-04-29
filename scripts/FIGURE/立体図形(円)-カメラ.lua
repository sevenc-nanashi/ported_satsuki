---$track:サイズ
---min=1
---max=1000
---step=1
local s = 100
---$track:奥行き
---min=1
---max=500
---step=1
local w = 20
---$track:ライン幅
---min=0
---max=4000
---step=1
local track2 = 4000
---$track:分割数
---min=3
---max=100
---step=1
local n = 50
--color:0xffffff
h = math.min(track2, s / 2)

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
