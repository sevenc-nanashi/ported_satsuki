--label:${ROOT_CATEGORY}\アニメーション効果
---$track:半径
---min=-2000
---max=2000
---step=0.1
local radius = 100

---$track:速さ
---min=-2000
---max=2000
---step=0.1
local speed = 500

---$check:内向き
local inward = false

local rotation = speed * obj.time / 1000
obj.ox = math.sin(rotation * math.pi * 2) * radius
obj.oy = -math.cos(rotation * math.pi * 2) * radius
obj.rz = rotation * 360 + 180
if inward then
    obj.rz = obj.rz - 180
end
