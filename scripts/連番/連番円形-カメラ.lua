--label:${ROOT_CATEGORY}\画像ファイル
---$track:個数
---min=0
---max=100
---step=1
local count = 10
---$track:距離
---min=0
---max=2000
---step=0.1
local radius = 200
---$track:拡大率
---min=0
---max=800
---step=0.1
local scale = 100
---$track:回転
---min=-360
---max=360
---step=0.1
local rotation = 0
---$check:Y軸回転なし
local disable_y_rotation = false

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
---$select:順番
---ランダム=0
---連番=1
local sequence_order = 0
---$file:ファイル
local file = ""

local function load_sequence_image(index)
    local extension = file:match("(%.[^%.\\/]*)$") or ""
    local path = file:sub(1, #file - serial_digits - #extension)
    local file_index
    if sequence_order < 1 then
        file_index = obj.rand(1, file_count, 0, index)
    else
        file_index = index + 1
    end

    local name = string.format("%0" .. serial_digits .. "d", file_index) .. extension
    obj.load("image", path .. name)
end

local scale_ratio = scale / 100

for index = 0, count - 1 do
    load_sequence_image(index)

    obj.effect()
    local angle = 360 * index / count + rotation
    local x = math.sin(angle * math.pi / 180) * radius * scale_ratio
    local z = -math.cos(angle * math.pi / 180) * radius * scale_ratio
    local zoom = obj.zoom * scale_ratio
    local rotation_y = -360 * index / count - rotation
    if disable_y_rotation then
        rotation_y = 0
    end

    obj.draw(x, 0, z, zoom, 1, 0, rotation_y, 0)
end
