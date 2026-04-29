--track0:ライン幅,1,100,20
--track1:間隔補正,0,500,100
--track2:範囲拡大,0,500,100
--color:0xffffff
obj.load("figure", "四角形", color, 2)
w = obj.screen_w * obj.track2 / 100
h = obj.screen_h * obj.track2 / 100
l0 = obj.track0
l1 = l0 * obj.track1 / 100
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
