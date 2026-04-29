---$track:個数
---min=1
---max=50
---step=1
local n = 5
---$track:回転速度
---min=0
---max=800
local track1 = 100
---$track:回転範囲
---min=0
---max=800
local rv = 100
---$track:拡大範囲
---min=0
---max=100
local ms = 100
obj.effect()
v = track1 / 100
for i = 0, n - 1 do
	s = obj.rand(ms, 100, i, 6) / 100
	rx = obj.rand(0, 360, i, 0) + obj.rand(-rv, rv, i, 3) * obj.time * v
	ry = obj.rand(0, 360, i, 1) + obj.rand(-rv, rv, i, 4) * obj.time * v
	rz = obj.rand(0, 360, i, 2) + obj.rand(-rv, rv, i, 5) * obj.time * v
	obj.draw(0, 0, 0, s, 1, rx, ry, rz)
end
