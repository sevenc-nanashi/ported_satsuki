--track0:個数,1,50,5,1
--track1:回転速度,0,800,100
--track2:回転範囲,0,800,100
--track3:拡大範囲,0,100,100
obj.effect()
n = obj.track0
v = obj.track1 / 100
rv = obj.track2
ms = obj.track3
for i = 0, n - 1 do
	s = obj.rand(ms, 100, i, 6) / 100
	rx = obj.rand(0, 360, i, 0) + obj.rand(-rv, rv, i, 3) * obj.time * v
	ry = obj.rand(0, 360, i, 1) + obj.rand(-rv, rv, i, 4) * obj.time * v
	rz = obj.rand(0, 360, i, 2) + obj.rand(-rv, rv, i, 5) * obj.time * v
	obj.draw(0, 0, 0, s, 1, rx, ry, rz)
end
