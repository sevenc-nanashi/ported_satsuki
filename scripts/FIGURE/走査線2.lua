--label:${ROOT_CATEGORY}\画面効果
---$track:ライン幅
---min=1
---max=100
local l0 = 20
---$track:間隔補正
---min=0
---max=500
local track1 = 100
---$track:範囲拡大
---min=0
---max=500
local track2 = 100
--color:0xffffff
obj.load("figure", "四角形", color, 2)
w = obj.screen_w * track2 / 100
h = obj.screen_h * track2 / 100
l1 = l0 * track1 / 100
n = math.floor(h / (l0 + l1))
obj.setoption("dst", "tmp", w, h)
for i = 0, n do
	x0 = -w / 2
	x1 = w / 2
	y0 = -h / 2 + (l0 + l1) * i
	y2 = -h / 2 + l0 + (l0 + l1) * i
	obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0)
end
obj.load("tempbuffer")
