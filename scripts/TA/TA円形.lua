---$track:距離
---min=0
---max=2000
local track0 = 200
---$track:拡大率
---min=0
---max=800
local track1 = 100
---$track:回転
---min=-360
---max=360
local track2 = 0
---$track:文字数
---min=-200
---max=200
local track3 = 0
--check0:外向き,0
r = 360 * obj.index / (obj.num + track3) + track2
obj.ox = math.sin(r * math.pi / 180) * track0 * track1 / 100
obj.oy = -math.cos(r * math.pi / 180) * track0 * track1 / 100
obj.zoom = obj.zoom * track1 / 100
obj.rz = 360 * obj.index / (obj.num + track3) + track2
if obj.check0 then
	obj.ox = -obj.ox
	obj.rz = -obj.rz - 180
end
