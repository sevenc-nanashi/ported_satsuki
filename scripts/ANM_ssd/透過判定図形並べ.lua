--label:${ROOT_CATEGORY}\配置
---$track:サイズ
---min=5
---max=2000
---step=1
local base_size = 50
---$track:拡大率
---min=0
---max=500
---step=1
local scale = 100
---$track:回転
---min=-720
---max=720
---step=1
local rotation = 0
---$track:ライン幅
---min=0
---max=4000
---step=1
local line_width = 4000
---$figure:図形
local figure_name = "円"

---$color:色
local color = nil

---$check:反転
local invert_alpha = false

---$check:交互
local alternate = true

---$track:個別拡大
---min=0
---max=500
---step=1
local individual_scale = 100

---$track:縦隙間
---min=0.1
---max=10
---step=0.1
local vertical_spacing = 1

---$track:横隙間
---min=0.1
---max=10
---step=0.1
local horizontal_spacing = 1

---$check:横六角形
local horizontal_hexagon = false

obj.effect("反転", "透明度反転", invert_alpha and 1 or 0)
local width, height = obj.getpixel()
local scale_ratio = scale / 100
local figure_size = math.min(base_size, width, height)
local positions_x = {}
local positions_y = {}
local alphas = {}
local source_colors = {}
local count = 0

local adjusted_y
if alternate then
    if figure_name == "円" or figure_name == "六角形" then
        adjusted_y = math.sin(math.rad(60)) * vertical_spacing
    else
        adjusted_y = vertical_spacing
    end
else
    adjusted_y = vertical_spacing
end

--六角形横
local adjusted_x
if horizontal_hexagon then
    adjusted_x = 1 + math.sin(math.rad(30))
    adjusted_y = adjusted_y - math.cos(math.rad(30)) / 2
    rotation = rotation + 30
else
    adjusted_x = horizontal_spacing
end

local count_x = math.floor(width / figure_size / 2 / adjusted_x) + 1
local count_y = math.floor(height / figure_size / 2 / adjusted_y) + 1
local ffi = require("ffi")
local userdata, w, h = obj.getpixeldata("object", "rgba")
local userdata_ptr = ffi.cast("uint8_t*", userdata)
for grid_y = -count_y - 1, count_y + 1 do
    local dot_y = height / 2 + (grid_y * adjusted_y + 0.5) * figure_size
    local position_y = grid_y * adjusted_y * figure_size
    local alternate_offset = alternate and 0.5 * grid_y % 2 or 0
    for grid_x = -count_x - 1, count_x + 1 do
        local dot_x = width / 2 + (grid_x + alternate_offset) * figure_size * adjusted_x + 0.5 * figure_size
        local position_x = (grid_x + alternate_offset) * figure_size * adjusted_x
        -- local _, _, _, alpha = obj.getpixel(dot_x, dot_y, "yc")
        -- local source_color = obj.getpixel(dot_x, dot_y, "col")
        local alpha, source_color
        if dot_x < 0 or dot_x >= width or dot_y < 0 or dot_y >= height then
            alpha = 0
            source_color = RGB(0, 0, 0)
        else
            alpha = userdata_ptr[(math.floor(dot_y) * w + math.floor(dot_x)) * 4 + 3] / 255
            source_color = RGB(
                userdata_ptr[(math.floor(dot_y) * w + math.floor(dot_x)) * 4 + 0],
                userdata_ptr[(math.floor(dot_y) * w + math.floor(dot_x)) * 4 + 1],
                userdata_ptr[(math.floor(dot_y) * w + math.floor(dot_x)) * 4 + 2]
            )
        end
        count = count + 1
        positions_x[count] = position_x
        positions_y[count] = position_y
        source_colors[count] = source_color
        alphas[count] = alpha
    end
end

obj.setoption("drawtarget", "tempbuffer", width + figure_size, height + figure_size)
-- TODO:
-- 大きな画像を用意したあとにdrawpolyして、色は別で色指定drawpolyをして、それら2枚を組み合わせることで高速化できそう
for i = 1, count do
    local alpha = alphas[i] > 0 and 1 or 0

    if alpha > 0 then
        local draw_color = color or source_colors[i]
        obj.load("figure", figure_name, draw_color, figure_size * scale_ratio, line_width)
        obj.draw(
            positions_x[i] + figure_size / 2,
            positions_y[i] + figure_size / 2,
            0,
            individual_scale / 100,
            alpha,
            0,
            0,
            rotation
        )
    end
end
obj.load("tempbuffer")
