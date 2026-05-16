--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:Zランダム
---min=0
---max=500
---step=1
local z_random = 0
---$track:回転ランダム
---min=0
---max=500
local rotation_random = 0
---$track:移動速度
---min=0
---max=100
local move_speed = 0

---$string:テキスト
local text = "さんぷる"

---$value:(XY座標)
local positions = {}

---$track:基準サイズ
---min=0
---max=512
---step=1
local base_size = 50
local s = base_size

---$value:サイズ(基準:s)
local sizes = {}

---$font:基準フォント
local base_font = "Yu Gothic UI"
local f = base_font

---$value:フォント(基準:f)
local fonts = {}

---$color:基準色
local base_color = 0xffffff

local c = base_color

---$value:色(基準:c)
local colors = {}

---$value:Z座標
local z_positions = {}

---$value:Z回転
local z_rotations = {}

---$value:縦横比
local aspects = {}

local z_random_scale = z_random / 100
local rotation_random_scale = rotation_random / 100
local move_distance = obj.time * move_speed

local function resolve_reference(values, index, reference_name, default_value)
    local value = values[index]
    if value == nil or value == reference_name then
        return default_value
    end
    return value
end

local function split_utf8(text_value)
    local characters = {}
    for character in string.gmatch(text_value, "[%z\1-\127\194-\244][\128-\191]*") do
        characters[#characters + 1] = character
    end
    return characters
end

local characters = split_utf8(text)
obj.setanchor("positions", #characters, "line")

for index, character in ipairs(characters) do
    local character_size = resolve_reference(sizes, index, "s", s)
    local character_font = resolve_reference(fonts, index, "f", f)
    local character_color = resolve_reference(colors, index, "c", c)
    local z_position = resolve_reference(z_positions, index, nil, 0)
    local z_rotation = resolve_reference(z_rotations, index, nil, 0)
    local aspect = resolve_reference(aspects, index, nil, 0)

    obj.setfont(character_font, character_size * 2, 0, character_color)
    obj.load("text", character)
    obj.effect()

    local x = (positions[index * 2 - 1] or 0) + obj.rand(-100, 100, index, 0) / 100 * move_distance
    local y = (positions[index * 2] or 0) + obj.rand(-100, 100, index, 1) / 100 * move_distance
    local z = z_position
        + obj.rand(-100, 100, index, 3) / 100 * move_distance
        + obj.rand(-100, 100, index, 4) * z_random_scale
    local rz = z_rotation + obj.rand(-180, 180, index, 6) * rotation_random_scale

    obj.aspect = aspect / 100
    obj.draw(x, y, z, 0.5, 1, 0, 0, rz)
end
