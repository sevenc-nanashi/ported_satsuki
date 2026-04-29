---$track:個数
---min=0
---max=100
---step=1
local n = 10
---$track:距離
---min=0
---max=2000
local l = 200
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local a = 0.3
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local b = 0.3
--check0:外向き,0
obj.effect()
for i = 0, n - 1 do
	if a == 0 then
		return
	elseif a < 0 then
		t = (a - (n - 1) * b - obj.time + obj.totaltime + i * b) / a
	else
		t = (a - obj.time + i * b) / a
	end
	t = math.min(1, math.max(t, 0))
	r = 360 * i / n
	x = math.sin(r * math.pi / 180) * l
	y = -math.cos(r * math.pi / 180) * l
	rz = 360 * i / n
	if obj.check0 then
		x = -x
		rz = -rz - 180
	end
	obj.draw(x, y, 0, 1, 1 - t, 0, 0, rz)
end
