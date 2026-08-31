---$script_tips:画像が円の軌道を描いて回り続けます。
--label:${ROOT_CATEGORY}\アニメーション効果
---$tips:円軌道の半径を指定します。
---$track:半径
---min=-2000
---max=2000
---step=0.1
local radius = 100

---$tips:移動の速さを指定します。速さ=1000だと1秒間に1周します。
---$track:速さ
---min=-2000
---max=2000
---step=0.1
local speed = 500

---$tips:チェックすると、画像の向きを円の内向きにします。
---$check:内向き
local inward = false

local rotation = speed * obj.time / 1000
obj.ox = math.sin(rotation * math.pi * 2) * radius
obj.oy = -math.cos(rotation * math.pi * 2) * radius
obj.rz = rotation * 360 + 180
if inward then
    obj.rz = obj.rz - 180
end
