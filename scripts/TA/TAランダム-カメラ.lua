--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:散逸度
---min=0
---max=100
---step=1
local dispersion = 50

---$track:X速度
---min=0
---max=200
---step=1
local x_speed = 50

---$track:Y速度
---min=0
---max=200
---step=1
local y_speed = 45

---$track:Z速度
---min=0
---max=200
---step=1
local z_speed = 55

---$track:X軸範囲
---min=0
---max=2
---step=0.01
local x_axis_range = 0.5

---$track:Y軸範囲
---min=0
---max=2
---step=0.01
local y_axis_range = 0.5

---$track:Z軸範囲
---min=0
---max=2
---step=0.01
local z_axis_range = 0.5

--trackgroup@x_axis_range,y_axis_range,z_axis_range:軸範囲

---$check:拡大/透明
local changes_zoom_alpha = false

local original_x = obj.ox
local original_y = obj.oy
local original_z = obj.oz
local x_direction = obj.rand(0, 1, obj.index, 1) == 1 and 1 or -1
local y_direction = obj.rand(0, 1, obj.index, 2) == 1 and 1 or -1
local z_direction = obj.rand(0, 1, obj.index, 3) == 1 and 1 or -1
local original_ratio = (100 - dispersion) / 100
local random_ratio = dispersion / 100

local random_x = obj.rand(-obj.screen_w, obj.screen_w, obj.index, x_speed) * x_axis_range
    + obj.rand(1, x_speed, obj.index, x_speed) * x_direction * obj.time
local random_y = obj.rand(-obj.screen_h, obj.screen_h, obj.index, y_speed) * y_axis_range
    + obj.rand(1, y_speed, obj.index, y_speed) * y_direction * obj.time
local random_z = obj.rand(-obj.screen_w, obj.screen_w, obj.index, z_speed) * z_axis_range
    + obj.rand(1, z_speed, obj.index, z_speed) * z_direction * obj.time
local random_rx = obj.rand(0, 359, obj.index, x_speed) + obj.rand(8, 64, obj.index, x_speed) * x_direction * obj.time
local random_ry = obj.rand(0, 359, obj.index, y_speed) + obj.rand(8, 64, obj.index, y_speed) * y_direction * obj.time
local random_rz = obj.rand(0, 359, obj.index, z_speed) + obj.rand(8, 64, obj.index, z_speed) * z_direction * obj.time

obj.ox = original_x * original_ratio + random_x * random_ratio
obj.oy = original_y * original_ratio + random_y * random_ratio
obj.oz = original_z * original_ratio + random_z * random_ratio
obj.rx = random_rx * random_ratio
obj.ry = random_ry * random_ratio
obj.rz = random_rz * random_ratio

if changes_zoom_alpha then
    local random_zoom = obj.rand(1, 150, obj.index, x_speed) / 100
    local random_alpha = obj.rand(1, 100, obj.index, x_speed) / 100

    obj.zoom = original_ratio + random_zoom * random_ratio
    obj.alpha = original_ratio + random_alpha * random_ratio
end
