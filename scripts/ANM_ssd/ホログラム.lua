--label:${ROOT_CATEGORY}\カスタムオブジェクト\模様
---$track:サイズ
---min=10
---max=1000
---step=1
local size = 80
---$track:回転
---min=-720
---max=720
local rotation = 0
---$track:虹角度
---min=-720
---max=720
local rainbow_angle = -60
---$select:タイプ
---赤緑=0
---単色=1
---虹=2
local mode = 1
---$track:横サイズ
---min=1
---max=5000
---step=1
local width = 800
---$track:縦サイズ
---min=1
---max=5000
---step=1
local height = 450
---$color:単色
local monochrome_color = 0xffffff

--[[
【素材】フォトショップでプリズムもどき【メイキング】
http://www.pixiv.net/member_illust.php?mode=medium&illust_id=8359819
を元に作成しました。感謝を。
スクリプト上で完全再現は挫折しました…orz
]]

--[[pixelshader@hologram_tile_repeat:
---$include "./shaders/hologram_tile_repeat.hlsl"
]]

local tile_size = math.floor(size / 2) * 2

local thin_light_width = tile_size * 0.12
local color_width = tile_size * 0.15
local thin_color_width = tile_size * 0.15
local black_width = tile_size * 0.10
local thick_black_width = tile_size * 0.6

local function draw_polar_band(color, angle, offset_angle, blur, band_width, alpha)
    obj.load("figure", "四角形", color, tile_size * math.sqrt(2) + 1)
    obj.effect("斜めクリッピング", "角度", 90, "ぼかし", blur, "幅", band_width)
    obj.effect("極座標変換", "回転", angle + offset_angle + rotation)
    if alpha == nil then
        obj.draw()
    else
        obj.draw(0, 0, 0, 1, alpha)
    end
end

obj.setoption("drawtarget", "tempbuffer", tile_size, tile_size)

-- 背景
obj.load("figure", "四角形", 0x8d8d8d, 2)
obj.drawpoly(
    -tile_size / 2,
    -tile_size / 2,
    0,
    tile_size / 2,
    -tile_size / 2,
    0,
    tile_size / 2,
    tile_size / 2,
    0,
    -tile_size / 2,
    tile_size / 2,
    0
)

-- 黒（太）
draw_polar_band(0x000000, -30, 0, thick_black_width, thick_black_width, 0.2)
draw_polar_band(0x000000, -30, 180, thick_black_width, thick_black_width, 0.2)

-- 黒
draw_polar_band(0x000000, -30, 0, black_width / 2, black_width, 0.2)
draw_polar_band(0x000000, -30, 180, black_width / 2, black_width, 0.2)

-- 色細（赤）
draw_polar_band(0xff0000, 75, 0, thin_color_width / 2, thin_color_width)
draw_polar_band(0xff0000, 75, 180, thin_color_width / 2, thin_color_width)

-- 色（緑）
draw_polar_band(0x00ff00, 45, 0, color_width / 2, color_width)
draw_polar_band(0x00ff00, 45, 180, color_width / 2, color_width)

-- 光（白）
draw_polar_band(0xffffff, 60, 0, thin_light_width / 2, thin_light_width)
draw_polar_band(0xffffff, 60, 180, thin_light_width / 2, thin_light_width)

obj.copybuffer("cache:hologram_tile", "tempbuffer")
obj.setoption("drawtarget", "tempbuffer", width, height)
obj.load("figure", "四角形", 0xffffff, 2)
obj.drawpoly(-width / 2, -height / 2, 0, width / 2, -height / 2, 0, width / 2, height / 2, 0, -width / 2, height / 2, 0)
obj.pixelshader("hologram_tile_repeat", "tempbuffer", { "cache:hologram_tile" }, {
    tile_size,
    width,
    height,
})

-- グラデーション（虹）
if mode == 2 then
    obj.load("tempbuffer")
    obj.setoption("drawtarget", "tempbuffer", width, height)

    local gradient_strength = 50
    local gradient_blend = 9
    local gradient_length = math.sqrt(width ^ 2 + height ^ 2)
    local gradient_width = gradient_length / 5
    local angle_rad = -rainbow_angle * math.pi / 180
    local gradient_colors = {
        0xff0000,
        0xffff00,
        0x00ff00,
        0x00ffff,
        0x0000ff,
        0xff00ff,
        0xff0000,
    }

    for color_index, color in ipairs(gradient_colors) do
        local offset = gradient_length / 2 - gradient_length / 7 * (color_index - 1)
        local center_x = math.sin(angle_rad) * offset
        local center_y = math.cos(angle_rad) * offset
        obj.effect(
            "グラデーション",
            "強さ",
            gradient_strength,
            "color",
            color,
            "no_color2",
            1,
            "中心X",
            center_x,
            "中心Y",
            center_y,
            "幅",
            gradient_width,
            "角度",
            rainbow_angle,
            "blend",
            gradient_blend
        )
    end

    obj.draw()
end

obj.load("tempbuffer")

if mode == 1 then
    obj.effect("単色化", "color", monochrome_color)
end

obj.setoption("drawtarget", "tempbuffer", width, height)
obj.effect("グロー", "しきい値", 72)
obj.draw()
obj.load("tempbuffer")
