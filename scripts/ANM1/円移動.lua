--label:${ROOT_CATEGORY}\アニメーション効果
---$track:半径
---min=-2000
---max=2000
local track0 = 100
---$track:速さ
---min=-2000
---max=2000
local track1 = 500
---$check:内向き
local __rename_me_check0 = false

r = track1 * obj.time / 1000
obj.ox = math.sin(r * math.pi * 2) * track0
obj.oy = -math.cos(r * math.pi * 2) * track0
obj.rz = r * 360 + 180
if __rename_me_check0 then
	obj.rz = obj.rz - 180
end
