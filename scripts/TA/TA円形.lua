--label:${ROOT_CATEGORY}\切り替え効果\TA
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
---$check:外向き
local __rename_me_check0 = false

r = 360 * obj.index / (obj.num + track3) + track2
obj.ox = math.sin(r * math.pi / 180) * track0 * track1 / 100
obj.oy = -math.cos(r * math.pi / 180) * track0 * track1 / 100
obj.zoom = obj.zoom * track1 / 100
obj.rz = 360 * obj.index / (obj.num + track3) + track2
if __rename_me_check0 then
    obj.ox = -obj.ox
    obj.rz = -obj.rz - 180
end
