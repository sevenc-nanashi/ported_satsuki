---$track:半径調整
---min=0
---max=150
local l = 100
---$track:速度調整
---min=-200
---max=200
local track1 = 100
tr = 360 * obj.index / obj.num + r * l / 100
obj.ox = math.sin(tr * math.pi / 180) * s * 0.95 / 2 * l / 100
obj.oy = -math.cos(tr * math.pi / 180) * s * 0.95 / 2 * l / 100
obj.rz = tr
