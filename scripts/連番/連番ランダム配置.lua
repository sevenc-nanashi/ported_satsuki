--label:${ROOT_CATEGORY}\画像ファイル
---$track:個数
---min=0
---max=1000
---step=1
local count = 5
---$track:範囲
---min=0
---max=1000
local spread = 100
---$track:移動速度
---min=0
---max=1000
local movement_speed = 0
---$track:回転速度
---min=0
---max=1000
local rotation_speed = 0

--trackgroup@x_range,y_range,z_range:軸範囲
---$track:X軸範囲%
---min=-1000
---max=1000
---step=1
local x_range = 100
---$track:Y軸範囲%
---min=-1000
---max=1000
---step=1
local y_range = 100
---$track:Z軸範囲%
---min=-1000
---max=1000
---step=1
local z_range = 0

---$check:X回転
local enable_rotation_x = false

---$check:Y回転
local enable_rotation_y = false

---$check:Z回転
local enable_rotation_z = true

---$track:拡大最小[-%]
---min=0
---max=100
---step=1
local min_zoom_reduction = 0

--separator:連番
---$track:File数
---min=0
---max=500
---step=1
local file_count = 10
---$track:連番桁
---min=1
---max=8
---step=1
local serial_digits = 4
---$file:ファイル
local file = ""

local function load_sequence_image(index)
    local extension = file:match("(%.[^%.\\/]*)$") or ""
    local path = file:sub(1, #file - serial_digits - #extension)
    local file_index = obj.rand(1, file_count, 0, index)
    local name = string.format("%0" .. serial_digits .. "d", file_index) .. extension
    obj.load("image", path .. name)
end

local spread_ratio = spread / 100
local movement_speed_ratio = movement_speed / 100
local rotation_speed_ratio = rotation_speed / 100
local rotation_x_multiplier = enable_rotation_x and 1 or 0
local rotation_y_multiplier = enable_rotation_y and 1 or 0
local rotation_z_multiplier = enable_rotation_z and 1 or 0

for index = 0, count - 1 do
    load_sequence_image(index)
    obj.effect()

    local x = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, index, 0) / 2 * spread_ratio
        + obj.rand(-100, 100, index, 3) * obj.time * movement_speed_ratio
    )
        * x_range
        / 100
    local y = (
        obj.rand(-obj.screen_h - obj.h, obj.screen_h + obj.h, index, 1) / 2 * spread_ratio
        + obj.rand(-100, 100, index, 4) * obj.time * movement_speed_ratio
    )
        * y_range
        / 100
    local z = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, index, 2) / 2 * spread_ratio
        + obj.rand(-100, 100, index, 5) * obj.time * movement_speed_ratio
    )
        * z_range
        / 100
    local zoom = obj.rand(100 - min_zoom_reduction, 100, index, 6) / 100
    local rotation_x = (obj.rand(0, 360, index, 7) + obj.rand(-100, 100, index, 10) * obj.time * rotation_speed_ratio)
        * rotation_x_multiplier
    local rotation_y = (obj.rand(0, 360, index, 8) + obj.rand(-100, 100, index, 11) * obj.time * rotation_speed_ratio)
        * rotation_y_multiplier
    local rotation_z = (obj.rand(0, 360, index, 9) + obj.rand(-100, 100, index, 12) * obj.time * rotation_speed_ratio)
        * rotation_z_multiplier

    obj.draw(x, y, z, zoom, 1, rotation_x, rotation_y, rotation_z)
end
