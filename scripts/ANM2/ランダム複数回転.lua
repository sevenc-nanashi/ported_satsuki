--label:${ROOT_CATEGORY}\アニメーション効果
---$track:個数
---min=1
---max=50
---step=1
local count = 5

---$track:回転速度
---min=0
---max=800
---step=0.1
local rotation_speed = 100

---$track:回転範囲
---min=0
---max=800
---step=0.1
local rotation_range = 100

---$track:拡大範囲
---min=0
---max=100
---step=0.1
local min_zoom_rate = 100

obj.effect()

local velocity = rotation_speed / 100
for i = 0, count - 1 do
    local zoom = obj.rand(min_zoom_rate, 100, i, 6) / 100
    local rotation_x = obj.rand(0, 360, i, 0) + obj.rand(-rotation_range, rotation_range, i, 3) * obj.time * velocity
    local rotation_y = obj.rand(0, 360, i, 1) + obj.rand(-rotation_range, rotation_range, i, 4) * obj.time * velocity
    local rotation_z = obj.rand(0, 360, i, 2) + obj.rand(-rotation_range, rotation_range, i, 5) * obj.time * velocity
    obj.draw(0, 0, 0, zoom, 1, rotation_x, rotation_y, rotation_z)
end
