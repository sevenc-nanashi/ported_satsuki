--label:${ROOT_CATEGORY}\画像ファイル
---$track:個数
---min=0
---max=100
---step=1
local count = 10
---$track:距離
---min=0
---max=2000
---step=1
local distance = 200
---$track:拡大率
---min=0
---max=800
local scale = 100
---$track:回転
---min=-360
---max=360
local rotation = 0
---$check:回転なし
local no_rotation = false

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
---$select:読み込み順
---ランダム=0
---連番=1
local order_mode = 0
---$file:ファイル
local file = ""

local function load_sequence_image(index)
    local extension = file:match("(%.[^%.\\/]*)$") or ""
    local path = file:sub(1, #file - serial_digits - #extension)
    local file_index = index + 1
    if order_mode == 0 then
        file_index = obj.rand(1, file_count, 0, index)
    end
    local name = string.format("%0" .. serial_digits .. "d", file_index) .. extension
    obj.load("image", path .. name)
end

local scale_rate = scale / 100

for index = 0, count - 1 do
    load_sequence_image(index)
    obj.effect()

    local angle = 360 * index / count + rotation
    local x = math.sin(math.rad(angle)) * distance * scale_rate
    local y = -math.cos(math.rad(angle)) * distance * scale_rate
    local zoom = obj.zoom * scale_rate
    local draw_rotation = angle
    if no_rotation then
        draw_rotation = 0
    end

    obj.draw(x, y, 0, zoom, 1, 0, 0, draw_rotation)
end
