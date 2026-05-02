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
---$track:角数
---min=3
---max=6
---step=1
local n = 4
---$color:色
local color = 0xffffff

h = math.min(track2, s / 2)
kaku = { "三角形", "四角形", "五角形", "六角形" }

obj.load("figure", kaku[n - 2], color, s, h)
obj.effect()
x = obj.w / 2
y = obj.h / 2
obj.drawpoly(-x, -y, w / 2, x, -y, w / 2, x, y, w / 2, -x, y, w / 2)
obj.drawpoly(-x, -y, -w / 2, x, -y, -w / 2, x, y, -w / 2, -x, y, -w / 2)

for k = 0, 1 do
	s = s - 2 * h * k
	if n == 4 then
		l = s / 2 * math.sqrt(2)
		sr = 45
	else
		l = s / 2
		sr = 90
	end
	obj.load("figure", "四角形", color, 2)
	obj.effect()
	r = 360 / n
	for i = 0, n - 1 do
		x0 = l * math.cos((sr + r * i) * math.pi / 180)
		x1 = l * math.cos((sr - r + r * i) * math.pi / 180)
		y0 = -l * math.sin((sr + r * i) * math.pi / 180)
		y1 = -l * math.sin((sr - r + r * i) * math.pi / 180)
		obj.drawpoly(x0, y0, -w / 2, x0, y0, w / 2, x1, y1, w / 2, x1, y1, -w / 2)
	end
end
