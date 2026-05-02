--label:${ROOT_CATEGORY}\カスタムオブジェクト
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
---$color:色
local color = 0xffffff

h = math.min(track2, s / 2)

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
