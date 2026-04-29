--track0:羽ばたき,0,500,100
--track1:角度,0,180,120
--track2:上下,0,200,30
--track3:羽(手動),-720,720,0
obj.effect()
r = math.sin(math.pi * 2 * obj.time * obj.track0 / 100)
f = (obj.track1 * r + obj.track3) * math.pi / 180
x = -obj.w / 2 * (1 + math.cos(f)) / 2
z = -obj.w / 2 * math.sin(f / 2)
obj.oy = r * obj.track2
obj.rx = -30
w = obj.w / 2
h = obj.h / 2
obj.drawpoly(x, -h, z, 0, -h, 0, 0, h, 0, x, h, z, 0, 0, w, 0, w, h * 2, 0, h * 2)
obj.drawpoly(0, -h, 0, -x, -h, z, -x, h, z, 0, h, 0, w, 0, w * 2, 0, w * 2, h * 2, w, h * 2)
