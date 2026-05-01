--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:拡大率
---min=0
---max=800
local track0 = 100
---$track:X軸回転
---min=-720
---max=720
local track1 = 0
---$track:Y軸回転
---min=-720
---max=720
local track2 = 0
---$track:Z軸回転
---min=-720
---max=720
local track3 = 0

x = obj.ox
y = obj.oy
rz = track3 * math.pi / 180
obj.ox = x * math.cos(rz) - y * math.sin(rz)
obj.oy = x * math.sin(rz) + y * math.cos(rz)
obj.rz = obj.rz + track3

y = obj.oy
z = obj.oz
rx = track1 * math.pi / 180
obj.oy = y * math.cos(rx) - z * math.sin(rx)
obj.oz = y * math.sin(rx) + z * math.cos(rx)
obj.rx = obj.rx + track1

x = obj.ox
z = obj.oz
ry = track2 * math.pi / 180
obj.oz = z * math.cos(ry) - x * math.sin(ry)
obj.ox = z * math.sin(ry) + x * math.cos(ry)
obj.ry = obj.ry + track2

obj.ox = obj.ox * track0 / 100
obj.oy = obj.oy * track0 / 100
obj.zoom = obj.zoom * track0 / 100
