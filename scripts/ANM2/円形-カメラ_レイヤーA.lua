---$track:個数
---min=0
---max=100
---step=1
local n = 6
---$track:距離
---min=-20000
---max=20000
local l = 500
---$track:拡大率
---min=0
---max=800
local track2 = 100
---$track:回転
---min=-720
---max=720
local k = 0
s = track2 / 100
lay = obj.layer
r = 360 * (obj.layer - lay) / n + k
obj.ox = math.sin(r * math.pi / 180) * l * s
obj.oz = -math.cos(r * math.pi / 180) * l * s
obj.zoom = obj.zoom * s
x = obj.x
y = obj.y
z = obj.z
