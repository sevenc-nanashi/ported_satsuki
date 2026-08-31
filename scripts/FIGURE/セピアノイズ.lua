--label:${ROOT_CATEGORY}\画面効果
---$script_tips:セピアフィルム風のノイズを作ります。
---:合成モードを「乗算」で合成して下さい。
---$tips:ゴミ状のノイズの量を調整します。
---$track:ゴミ閾値
---min=0
---max=100
---step=1
local dust_threshold = 90
---$tips:ゴミ状のノイズのサイズを指定します。
---$track:ゴミサイズ
---min=0
---max=200
---step=1
local dust_size = 100
---$tips:縦線状のノイズの量を調整します。
---$track:縦線閾値
---min=0
---max=100
---step=1
local vertical_line_threshold = 90
---$tips:輝度の点滅の大きさを調整します。
---:100で点滅がなくなります。
---$track:輝度変化
---min=0
---max=100
---step=1
local brightness_variation = 90
---$tips:周囲を縁取っているグラデーションの色を指定します。
---:デフォルトではセピア色に設定しています。
---$color:縁色
local edge_color = 0x6b4a2b

---$tips:ゴミ状のノイズや縦線ノイズの色を指定します。
---$color:ノイズ色
local noise_color = 0x000000

---$tips:周囲を縁取っているグラデーションの縦横比を選択します。
---:チェックしない場合は円形となり、チェックすると画面のアス比と同じになります。
---$check:縁アス比
local edge_aspect_ratio = false

---$tips:チェックすると周囲をグラデーションで縁取ります。
---$check:縁あり
local show_edge = true
--hide@edge_aspect_ratio:show_edge==0

---$tips:チェックすると輝度を反転します。
---:反転した場合は、合成モード「加算」などで合成して下さい。
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
obj.effect("反転", "輝度反転", invert_brightness and 1 or 0)
