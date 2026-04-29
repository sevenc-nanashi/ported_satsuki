---$track:羽ばたき
---min=0
---max=500
local track0 = 100
---$track:角度
---min=0
---max=180
local track1 = 120
---$track:上下
---min=0
---max=200
local track2 = 30
---$track:羽(手動)
---min=-720
---max=720
local track3 = 0
obj.effect()
r = math.sin(math.pi * 2 * obj.time * track0 / 100)
f = (track1 * r + track3) * math.pi / 180
x = -obj.w / 2 * (1 + math.cos(f)) / 2
z = -obj.w / 2 * math.sin(f / 2)
obj.oy = r * track2
obj.rx = -30
w = obj.w / 2
h = obj.h / 2
obj.drawpoly(x, -h, z, 0, -h, 0, 0, h, 0, x, h, z, 0, 0, w, 0, w, h * 2, 0, h * 2)
obj.drawpoly(0, -h, 0, -x, -h, z, -x, h, z, 0, h, 0, w, 0, w * 2, 0, w * 2, h * 2, w, h * 2)
