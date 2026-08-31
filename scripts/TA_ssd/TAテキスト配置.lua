--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$script_tips:テキストを一文字ずつドラッグして配置します。
---:テキストオブジェクトの制御文字でも同様のことができますが、それを柔軟?にしたイメージ
---:図形などの適当なオブジェクトに、(A)→(B)の順に適用して下さい。
---$tips:テキストを一文字毎に、ランダムにZ軸方向にずらします。
---$track:Zランダム
---min=0
---max=500
---step=1
local z_random = 0
---$tips:テキストを一文字毎に、ランダムにZ軸回転します。
---$track:回転ランダム
---min=0
---max=500
local rotation_random = 0
---$tips:テキストをランダム方向(X,Y,Z)に移動させます。
---$track:移動速度
---min=0
---max=100
local move_speed = 0

---$tips:表示したいテキストを入力します。最大16文字程度まで。
---$string:テキスト
local text = "さんぷる"

---$tips:XY座標を数値で指定することも出来ます。通常は設定する必要はありません。
---$value:(XY座標)
local positions = {}

---$tips:テキストの基準となるサイズを指定します。
---$track:基準サイズ
---min=0
---max=512
---step=1
local base_size = 50
local s = base_size

---$tips:任意の文字のサイズを指定します。
---:{1文字目のサイズ,2文字目のサイズ,…}というリストになってます。
---:設定した基準サイズと同じ場合は、具体的な数値ではなく"s"でもOKです。
---:【例】3文字目と5文字目のサイズを変える場合
---:{s,s,100,s,120}
---$value:サイズ(基準:s)
local sizes = {}

---$tips:基準となるフォントを指定します。
---$font:基準フォント
local base_font = "Yu Gothic UI"
local f = base_font

---$tips:任意の文字のフォントを指定します。
---:【例】3文字目のフォントを指定する場合
---:{f,f,"HGP明朝B"}
---$value:フォント(基準:f)
local fonts = {}

---$tips:基準となるテキストの色を指定します。
---$color:基準色
local base_color = 0xffffff

local c = base_color

---$tips:任意の文字の色を指定します。
---:【例】3文字目の色を指定する場合
---:{c,c,0x00ffff}
---$value:色(基準:c)
local colors = {}

---$tips:任意の文字のZ座標を指定します。
---$value:Z座標
local z_positions = {}

---$tips:任意の文字のZ回転を指定します。
---$value:Z回転
local z_rotations = {}

---$tips:任意の文字の縦横比を指定します(-100〜100)。
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
