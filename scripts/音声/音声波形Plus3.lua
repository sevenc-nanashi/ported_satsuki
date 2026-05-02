--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:横幅
---min=0
---max=2000
local W = 640
---$track:縦幅%
---min=0
---max=800
local track1 = 100
---$track:ライン幅
---min=0
---max=500
---step=1
local l = 10
---$track:分割数
---min=1
---max=1024
---step=1
local track3 = 50
---$color:色
local color = 0xffffff

H = track1 / 100
div = track3 + 1
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
