--track0:個数,0,100,6,1
--track1:距離,-20000,20000,500
--track2:拡大率,0,800,100
--track3:回転,-720,720,0
n = obj.track0
l = obj.track1
s = obj.track2 / 100
k = obj.track3
lay = obj.layer
r = 360 * (obj.layer - lay) / n + k
obj.ox = math.sin(r * math.pi / 180) * l * s
obj.oz = -math.cos(r * math.pi / 180) * l * s
obj.zoom = obj.zoom * s
x = obj.x
y = obj.y
z = obj.z
