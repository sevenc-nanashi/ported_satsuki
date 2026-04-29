--track0:個数,0,100,6,1
--track1:距離,0,2000,200
--track2:拡大率,0,800,100
--track3:回転,-720,720,0
--check0:外向き,0
n = obj.track0
l = obj.track1
s = obj.track2 / 100
k = obj.track3
lay = obj.layer
soto = 0
r = 360 * (obj.layer - lay) / n + k
obj.ox = math.sin(r * math.pi / 180) * l * s
obj.oy = -math.cos(r * math.pi / 180) * l * s
obj.zoom = obj.zoom * s
obj.rz = r
if obj.check0 then
	obj.ox = -obj.ox
	obj.rz = -obj.rz - 180
	soto = 1
end
x = obj.x
y = obj.y
z = obj.z
