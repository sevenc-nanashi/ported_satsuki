---$track:振幅
---min=0
---max=500
local track0 = 200
---$track:間隔
---min=1
---max=500
local track1 = 100
---$track:個数
---min=1
---max=100
---step=1
local n = 3
--dialog:ランダムサイズ[-%],rs=0;ランダム透明度[-%],ralp=0;差分,sbn=7.7;

for i = 0, n - 1 do
	t = (obj.time + i * sbn) * 100 / track1
	p = math.floor(t)
	t = t - p
	x0 = obj.rand(-1000, 1000, 0 + i, p + 0) / 1000 * track0
	x1 = obj.rand(-1000, 1000, 0 + i, p + 1) / 1000 * track0
	x2 = obj.rand(-1000, 1000, 0 + i, p + 2) / 1000 * track0
	x3 = obj.rand(-1000, 1000, 0 + i, p + 3) / 1000 * track0
	y0 = obj.rand(-1000, 1000, 1 + i, p + 0) / 1000 * track0
	y1 = obj.rand(-1000, 1000, 1 + i, p + 1) / 1000 * track0
	y2 = obj.rand(-1000, 1000, 1 + i, p + 2) / 1000 * track0
	y3 = obj.rand(-1000, 1000, 1 + i, p + 3) / 1000 * track0
	x, y = obj.interpolation(t, x0, y0, x1, y1, x2, y2, x3, y3)
	xx, yy = obj.interpolation(t + 1 / obj.framerate, x0, y0, x1, y1, x2, y2, x3, y3)
	s = 1 - obj.rand(0, 1000, 10 + i, 10) / 1000 * rs / 100
	alp = 1 - obj.rand(0, 1000, 11 + i, 11) / 1000 * ralp / 100
	r = math.deg(math.atan2(yy - y, xx - x)) + 90
	obj.draw(x, y, 0, s, alp, 0, 0, r)
end
