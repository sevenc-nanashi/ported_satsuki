--label:${ROOT_CATEGORY}\画面効果
---$track:ゴミ閾値
---min=0
---max=100
---step=1
local dust_threshold = 90
---$track:ゴミサイズ
---min=0
---max=200
---step=1
local dust_size = 100
---$track:縦線閾値
---min=0
---max=100
---step=1
local vertical_line_threshold = 90
---$track:輝度変化
---min=0
---max=100
---step=1
local brightness_variation = 90
---$color:縁色
local edge_color = 0x6b4a2b

---$color:ノイズ色
local noise_color = 0x000000

---$check:縁アス比
local edge_aspect_ratio = false

---$check:縁あり
local show_edge = true

---$check:輝度反転
local invert_brightness = false

local dust_scale = dust_size / 100

--白背景
obj.load("figure", "背景", 0xffffff)
obj.effect("色調補正", "輝度", obj.rand(brightness_variation, 100))
obj.setoption("dst", "tmp", obj.screen_w, obj.screen_h)
obj.draw()

--色付き背景
obj.load("figure", "背景", edge_color)
obj.setoption("dst", "tmp")
obj.draw(0, 0, 0, 1, 0.2)

--縁
if show_edge then
    local edge_size = 50
    obj.load("figure", "四角形", edge_color, edge_size * 2)
    obj.effect("マスク", "type", 1, "サイズ", edge_size, "マスクの反転", 1)
    obj.effect("ぼかし", "範囲", 10, "サイズ固定", 1)
    local edge_width = obj.screen_w / 2
    local edge_height = edge_width
    if edge_aspect_ratio then
        edge_height = obj.screen_h / 2
    end
    obj.setoption("dst", "tmp")
    obj.drawpoly(
        -edge_width,
        -edge_height,
        0,
        edge_width,
        -edge_height,
        0,
        edge_width,
        edge_height,
        0,
        -edge_width,
        edge_height,
        0,
        edge_size / 2,
        edge_size / 2,
        edge_size * 3 / 2,
        edge_size / 2,
        edge_size * 3 / 2,
        edge_size * 3 / 2,
        edge_size / 2,
        edge_size * 3 / 2
    )
end

--ゴミノイズ
obj.load("figure", "四角形", noise_color, obj.screen_w)
obj.effect(
    "ノイズ",
    "変化速度",
    50,
    "周期X",
    10 * dust_scale,
    "周期Y",
    10 * dust_scale,
    "しきい値",
    dust_threshold
)
local dust_x = obj.rand(-obj.screen_w / 2, obj.screen_w / 2)
local dust_y = obj.rand(-obj.screen_h / 2, obj.screen_h / 2)
obj.setoption("dst", "tmp")
obj.draw(dust_x, dust_y, 0, 2)

--縦線ノイズ
obj.load("figure", "四角形", noise_color, obj.screen_w)
obj.effect("ノイズ", "変化速度", 50, "周期X", 20, "周期Y", 0.01, "しきい値", vertical_line_threshold)
obj.setoption("dst", "tmp")
obj.draw()

--描画
obj.load("tempbuffer")
obj.effect("反転", "輝度反転", invert_brightness)
