--track0:拡大率,0,800,100
--track1:X軸回転,-720,720,0
--track2:Y軸回転,-720,720,0
--track3:Z軸回転,-720,720,0

x = obj.ox
y = obj.oy
rz = obj.track3 * math.pi / 180
obj.ox = x * math.cos(rz) - y * math.sin(rz)
obj.oy = x * math.sin(rz) + y * math.cos(rz)
obj.rz = obj.rz + obj.track3

y = obj.oy
z = obj.oz
rx = obj.track1 * math.pi / 180
obj.oy = y * math.cos(rx) - z * math.sin(rx)
obj.oz = y * math.sin(rx) + z * math.cos(rx)
obj.rx = obj.rx + obj.track1

x = obj.ox
z = obj.oz
ry = obj.track2 * math.pi / 180
obj.oz = z * math.cos(ry) - x * math.sin(ry)
obj.ox = z * math.sin(ry) + x * math.cos(ry)
obj.ry = obj.ry + obj.track2

obj.ox = obj.ox * obj.track0 / 100
obj.oy = obj.oy * obj.track0 / 100
obj.zoom = obj.zoom * obj.track0 / 100
