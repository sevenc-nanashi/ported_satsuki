--label:${ROOT_CATEGORY}\アニメーション効果
---$track:X間隔
---min=-1000
---max=1000
local track0 = 100
---$track:Y間隔
---min=-1000
---max=1000
local track1 = 100
---$track:X個数
---min=1
---max=100
---step=1
local nx = 5
---$track:Y個数
---min=1
---max=100
---step=1
local ny = 3
---$value:明滅最大[s]
local max = 5

---$value:明滅最小[s]
local min = 1

---$value:開始位置[s]
local f = 3

---$value:閾値[%]
local s = 0

gx = track0 / 100
gy = track1 / 100
w = obj.w
h = obj.h
w_size = (nx + (nx - 1) * (gx - 1)) * w
h_size = (ny + (ny - 1) * (gy - 1)) * h
obj.setoption("dst", "tmp", w_size, h_size)
for j = 0, ny - 1 do
	y0 = -h_size / 2 + h * j * gy
	y2 = -h_size / 2 + h * (j * gy + 1)
	for i = 0, nx - 1 do
		x0 = -w_size / 2 + w * i * gx
		x1 = -w_size / 2 + w * (i * gx + 1)
		t = obj.rand(min * 1000, max * 1000, j, i) / 1000
		alp = math.cos(2 * math.pi * (obj.time + f) * (1 / t)) * (0.5 + 0.5 * s / 100) + 0.5 - 0.5 * s / 100
		obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, 0, 0, obj.w, 0, obj.w, obj.h, 0, obj.h, alp)
	end
end
obj.load("tempbuffer")
