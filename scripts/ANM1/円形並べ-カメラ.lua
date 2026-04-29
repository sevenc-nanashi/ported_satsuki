--track0:個数,0,100,10,1
--track1:距離,0,2000,200
--track2:拡大率,0,800,100
--track3:回転,-360,360,0
--check0:Y軸回転なし,0
n = obj.track0
l = obj.track1
k = obj.track2 / 100
rr = obj.track3
obj.effect()
for i = 0, n - 1 do
	r = 360 * i / n + rr
	x = math.sin(r * math.pi / 180) * l * k
	z = -math.cos(r * math.pi / 180) * l * k
	s = obj.zoom * k
	ry = -360 * i / n - rr
	if obj.check0 then
		ry = ry * 0
	end
	obj.draw(x, 0, z, s, 1, 0, ry, 0)
end
