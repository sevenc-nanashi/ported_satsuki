--label:${ROOT_CATEGORY}\アニメーション効果
---$track:個数
---min=0
---max=1000
---step=1
local count = 5

---$track:範囲
---min=0
---max=1000
---step=0.1
local range_rate = 100

---$track:移動速度
---min=0
---max=1000
---step=0.1
local move_speed = 0

---$track:回転速度
---min=0
---max=1000
---step=0.1
local rotation_speed = 0

---$track:明滅最大[秒]
---min=0.01
---max=60
---step=0.01
local max_blink_interval = 5

---$track:明滅最小[秒]
---min=0.01
---max=60
---step=0.01
local min_blink_interval = 1

---$track:開始位置[秒]
---min=-60
---max=60
---step=0.01
local start_time = 3

---$track:閾値[%]
---min=0
---max=100
---step=0.1
local threshold_rate = 0

---$track:X軸範囲[%]
---min=0
---max=1000
---step=0.1
local range_x = 100

---$track:Y軸範囲[%]
---min=0
---max=1000
---step=0.1
local range_y = 100

---$track:Z軸範囲[%]
---min=0
---max=1000
---step=0.1
local range_z = 0

--trackgroup@range_x,range_y,range_z:範囲

---$check:X回転
local rotates_x = false

---$check:Y回転
local rotates_y = false

---$check:Z回転
local rotates_z = true

---$track:拡大最小[-%]
---min=0
---max=100
---step=0.1
local min_zoom_reduction = 0

obj.effect()
local range_scale = range_rate / 100
local velocity = move_speed / 100
local rotation_velocity = rotation_speed / 100
local rotates_x_factor = rotates_x and 1 or 0
local rotates_y_factor = rotates_y and 1 or 0
local rotates_z_factor = rotates_z and 1 or 0

for i = 0, count - 1 do
    local x = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, i, 0) / 2 * range_scale
        + obj.rand(-100, 100, i, 3) * obj.time * velocity
    )
        * range_x
        / 100
    local y = (
        obj.rand(-obj.screen_h - obj.h, obj.screen_h + obj.h, i, 1) / 2 * range_scale
        + obj.rand(-100, 100, i, 4) * obj.time * velocity
    )
        * range_y
        / 100
    local z = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, i, 2) / 2 * range_scale
        + obj.rand(-100, 100, i, 5) * obj.time * velocity
    )
        * range_z
        / 100
    local zoom = obj.rand(100 - min_zoom_reduction, 100, i, 6) / 100
    local rx = (obj.rand(0, 360, i, 7) + obj.rand(-100, 100, i, 10) * obj.time * rotation_velocity) * rotates_x_factor
    local ry = (obj.rand(0, 360, i, 8) + obj.rand(-100, 100, i, 11) * obj.time * rotation_velocity) * rotates_y_factor
    local rz = (obj.rand(0, 360, i, 9) + obj.rand(-100, 100, i, 12) * obj.time * rotation_velocity) * rotates_z_factor
    local blink_interval = obj.rand(min_blink_interval * 1000, max_blink_interval * 1000, 0, i) / 1000
    local alpha = math.cos(2 * math.pi * (obj.time + start_time) / blink_interval) * (0.5 + 0.5 * threshold_rate / 100)
        + 0.5
        - 0.5 * threshold_rate / 100
    obj.draw(x, y, z, zoom, alpha, rx, ry, rz)
end
