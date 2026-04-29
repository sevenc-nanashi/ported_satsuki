--track0:横幅,0,2000,640
--track1:縦幅%,0,800,100
--track2:ライン幅,0,500,10,1
--track3:分割数,1,1024,50,1
--color:0xffffff
W = obj.track0
H = obj.track1 / 100
l = obj.track2
div = obj.track3 + 1
buf = {}
n = obj.getaudio(buf, "audiobuffer", "pcm", div)
w = W / (n - 1)

obj.load("figure", "四角形", color, 2)
obj.setoption("dst", "tmp", W, W)
obj.setoption("blend", "alpha_add")
for i = 1, n - 1 do
	x0 = (i - 1) * w - W / 2
	x1 = i * w - W / 2
	y0 = -buf[i] / 100 * H - l / 2
	y1 = -buf[i + 1] / 100 * H - l / 2
	y2 = -buf[i + 1] / 100 * H + l / 2
	y3 = -buf[i] / 100 * H + l / 2
	obj.drawpoly(x0, y0, 0, x1, y1, 0, x1, y2, 0, x0, y3, 0)
end
obj.load("tempbuffer")
