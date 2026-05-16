--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:行数
---min=1
---max=256
---step=1
local row_count = 5

---$track:範囲
---min=0
---max=1000
---step=0.1
local range = 100

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

---$track:X軸範囲[%]
---min=0
---max=200
---step=0.1
local x_axis_range = 100

---$track:Y軸範囲[%]
---min=0
---max=200
---step=0.1
local y_axis_range = 100

---$track:Z軸範囲[%]
---min=0
---max=200
---step=0.1
local z_axis_range = 100

--trackgroup@x_axis_range,y_axis_range,z_axis_range:軸範囲

---$check:Z回転
local rotates_z = true

---$track:拡大最小[-%]
---min=0
---max=100
---step=0.1
local min_zoom_reduction = 0

obj.effect()
local half_width = obj.w / 2
local half_row_height = obj.h / 2 / row_count
local half_screen_width = obj.screen_w / 2
local half_screen_height = obj.screen_h / 2
local range_scale = range / 100
local move_speed_scale = move_speed / 100
local rotation_speed_scale = rotation_speed / 100
local z_rotation_factor = rotates_z and 1 or 0

for i = 0, row_count - 1 do
    local cx = (
        obj.rand(-half_screen_width - half_width, half_screen_width + half_width, i, 0) * range_scale
        + obj.rand(-100, 100, i, 3) * obj.time * move_speed_scale
    )
        * x_axis_range
        / 100
    local cy = (
        obj.rand(-half_screen_height - half_row_height, half_screen_height + half_row_height, i, 1) * range_scale
        + obj.rand(-100, 100, i, 4) * obj.time * move_speed_scale
    )
            * y_axis_range
            / 100
        - obj.h / 2
        + half_row_height
        + half_row_height * 2 * i
    local cz = (
        obj.rand(-half_screen_width - half_width, half_screen_width + half_width, i, 2) * range_scale
        + obj.rand(-100, 100, i, 5) * obj.time * move_speed_scale
    )
        * z_axis_range
        / 100
    local corner_radius = math.sqrt(half_width ^ 2 + half_row_height ^ 2)
        * (1 + obj.rand(100 - min_zoom_reduction, 100, i, 6) / 100)
    local rotation = math.rad(obj.rand(0, 360, i, 9) + obj.rand(-100, 100, i, 12) * obj.time * rotation_speed_scale)
        * z_rotation_factor

    local x0 = cx + math.cos(math.atan2(-half_row_height, -half_width) + rotation) * corner_radius
    local x1 = cx + math.cos(math.atan2(-half_row_height, half_width) + rotation) * corner_radius
    local x2 = cx + math.cos(math.atan2(half_row_height, half_width) + rotation) * corner_radius
    local x3 = cx + math.cos(math.atan2(half_row_height, -half_width) + rotation) * corner_radius
    local y0 = cy + math.sin(math.atan2(-half_row_height, -half_width) + rotation) * corner_radius
    local y1 = cy + math.sin(math.atan2(-half_row_height, half_width) + rotation) * corner_radius
    local y2 = cy + math.sin(math.atan2(half_row_height, half_width) + rotation) * corner_radius
    local y3 = cy + math.sin(math.atan2(half_row_height, -half_width) + rotation) * corner_radius
    local v0 = half_row_height * 2 * i
    local v1 = half_row_height * 2 * (i + 1)
    obj.drawpoly(x0, y0, cz, x1, y1, cz, x2, y2, cz, x3, y3, cz, 0, v0, half_width * 2, v0, half_width * 2, v1, 0, v1)
end
