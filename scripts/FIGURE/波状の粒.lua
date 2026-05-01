--label:${ROOT_CATEGORY}\加工
---$track:個数
---min=2
---max=200
---step=1
local track0 = 100
---$track:サイズ
---min=0
---max=100
local size = 4
---$track:高さ
---min=0
---max=500
local lmax = 100
---$track:幅
---min=0
---max=500
local wmax = 50
---$figure:種類
local fig = "円"

---$color:色
local col = 0xffffff

---$value:ライン幅
local line = 4000

---$value:変化速度[ms]
local fs = 100

---$value:増加率
local pl = 0


n = math.floor(track0 / 2)
obj.setoption("dst", "tmp", n * 5 * 2, lmax * 2 * 1.5)
obj.load("figure", fig, col, size, line)
obj.effect()
f = obj.time / fs * 1000
k = obj.rand(0, wmax, 1, math.floor(f))
l = obj.rand(0, lmax, 0, math.floor(f))
for i = -n, n - 1 do
	x = 5 * i
	y = math.sin(math.pi * k * i / 180) * l * (1 + math.abs(i / 100 * pl / 100))
	obj.draw(x, y)
end
obj.load("tempbuffer")
