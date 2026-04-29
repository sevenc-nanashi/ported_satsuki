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
---$track:縦横比
---min=-100
---max=100
local aspect = 0
--color:0xffffff
h = math.min(track2, s / 2)
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
