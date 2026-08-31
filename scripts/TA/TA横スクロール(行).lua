--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$script_tips:テキストを一行ごとにランダムに配置し、横方向にスクロールさせます。
---:※このスクリプトは「文字毎に個別オブジェクト」にチェックは不要です。
---$tips:行数を実際のテキストの行数に合わせて下さい。
---$track:行数
---min=1
---max=256
---step=1
local line_count = 5

---$tips:スクロールする移動速度を指定します。
---$track:移動速度
---min=-1000
---max=1000
---step=0.1
local scroll_speed = 100

---$tips:X,Y,Z軸ごとに散らばる範囲の基準を指定します。
---:数値は％で画面サイズが基準となっています(100%=画面サイズ)。
---$track:X軸範囲
---min=0
---max=1000
---step=0.1
local range_x = 100

---$tips:X,Y,Z軸ごとに散らばる範囲の基準を指定します。
---:数値は％で画面サイズが基準となっています(100%=画面サイズ)。
---$track:Y軸範囲
---min=0
---max=1000
---step=0.1
local range_y = 100

---$tips:X,Y,Z軸ごとに散らばる範囲の基準を指定します。
---:数値は％で画面サイズが基準となっています(100%=画面サイズ)。
---$track:Z軸範囲[%]
---min=0
---max=1000
---step=0.1
local range_z = 0

--trackgroup@range_x,range_y,range_z:範囲

---$tips:一行毎のの拡大率をランダムにします。
---:数値は、最小の拡大率をマイナスで指定し、その範囲でランダムな拡大率になります。
---:例えば、拡大最小=80(-%)と設定すると100-80=20%→20%〜100%の間でランダムな拡大率となります。
---$track:拡大最小[-%]
---min=0
---max=100
---step=0.1
local min_zoom_reduction = 0

---$tips:移動速度をランダムにします。
---:例えば、速度最小=80(-%)と設定すると100-80=20%→20%〜100%の間でランダムな移動速度となります。
---$track:速度最小[-%]
---min=0
---max=100
---step=0.1
local min_speed_reduction = 0

obj.effect()
local half_width = obj.w / 2
local half_line_height = obj.h / 2 / line_count
local half_screen_width = obj.screen_w / 2
local half_screen_height = obj.screen_h / 2
local range_scale_x = range_x / 100
local range_scale_y = range_y / 100
local velocity = -scroll_speed / 100

for i = 0, line_count - 1 do
    local center_x = obj.rand(-half_screen_width - half_width, half_screen_width + half_width, i, 0) * range_scale_x
        + obj.rand(100 - min_speed_reduction, 100, i, 4) * obj.time * velocity
    local center_y = obj.rand(-half_screen_height - half_line_height, half_screen_height + half_line_height, i, 1)
            * range_scale_y
        - obj.h / 2
        + half_line_height
        + half_line_height * 2 * i
    local center_z = obj.rand(-half_screen_width - half_width, half_screen_width + half_width, i, 2) * range_z / 100
    local zoom = obj.rand(100 - min_zoom_reduction, 100, i, 3) / 100
    local x0 = center_x - half_width * zoom
    local x1 = center_x + half_width * zoom
    local y0 = center_y - half_line_height * zoom
    local y2 = center_y + half_line_height * zoom
    local v0 = half_line_height * 2 * i
    local v1 = half_line_height * 2 * (i + 1)
    obj.drawpoly(
        x0,
        y0,
        center_z,
        x1,
        y0,
        center_z,
        x1,
        y2,
        center_z,
        x0,
        y2,
        center_z,
        0,
        v0,
        half_width * 2,
        v0,
        half_width * 2,
        v1,
        0,
        v1
    )
end
