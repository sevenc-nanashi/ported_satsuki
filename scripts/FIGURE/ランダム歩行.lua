---$track:個数
---min=1
---max=50
---step=1
local track0 = 5
---$track:速さ
---min=0.1
---max=50
local v = 5
---$track:残像[s]
---min=0.01
---max=10
---step=0.01
local track2 = 2
---$track:サイズ
---min=0
---max=1000
---step=1
local track3 = 30
---$figure:図形
local fig = "円"

---$color:色
local col = 0xffffff

---$check:カラフル
local cful = 1

---$value:ランダムサイズ[-%]
local rsize = 50

---$check:縮小化
local dcsize = 0

---$check:フェードなし
local fade = 0

---$check:初期位置ランダム
local st = 0

---$value:平均数
local nj = 2

f = track2 * obj.framerate
n = track0 - 1
w = obj.screen_w / 2
h = obj.screen_h / 2
for k = 0, n do
	if cful == 1 then
		c = (obj.rand(0, 100, k, 100) - 50) / 100
		if c < 0 then
			c = math.floor(math.cos(math.pi * c) * 255) * 256 + math.floor(math.sin(math.pi * -c) * 255)
		else
			c = math.floor(math.cos(math.pi * c) * 255) * 256 + math.floor(math.sin(math.pi * c) * 255) * 65536
		end
	else
		c = col
	end

	obj.load("figure", fig, c, track3)
	obj.effect()
	x = 0
	y = 0
	for i = 0, obj.frame do
		xrand = 0
		yrand = 0
		for j = 0, nj do
			xrand = xrand + obj.rand(-100, 100, k + 0, i + j) / (j + 1)
			yrand = yrand + obj.rand(-100, 100, k + 1, i + j) / (j + 1)
		end
		x = x + xrand / v
		y = y + yrand / v
		xx = x + w + obj.rand(-w, w, k + 10, 0) * st
		yy = y + h + obj.rand(-w, w, k + 10, 0) * st
		rzoom = (1 - obj.rand(0, rsize, i + 51, k) / 100) * (1 - math.min(obj.frame - i, f) / f * dcsize)
		if fade == 0 then
			alp = 1 - math.min(obj.frame - i, f) / f
		elseif obj.frame - i > f then
			alp = 0
		else
			alp = 1
		end
		obj.draw(xx % (2 * w) - w, yy % (2 * h) - h, 0, rzoom, alp)
	end
end
