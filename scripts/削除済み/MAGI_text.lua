--track0:半径調整,0,150,100
--track1:速度調整,-200,200,100
l = obj.track0
tr = 360 * obj.index / obj.num + r * obj.track0 / 100
obj.ox = math.sin(tr * math.pi / 180) * s * 0.95 / 2 * l / 100
obj.oy = -math.cos(tr * math.pi / 180) * s * 0.95 / 2 * l / 100
obj.rz = tr
