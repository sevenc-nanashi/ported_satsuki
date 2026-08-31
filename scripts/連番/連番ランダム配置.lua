--label:${ROOT_CATEGORY}\画像ファイル
---$script_tips:「ランダム配置」を連番画像で適用します。
---$tips:配置する画像の数を指定します。
---$track:個数
---min=0
---max=1000
---step=1
local count = 5
---$tips:散らばる範囲を一括して調整します。
---:ゼロにすると中心に収束し、トラックバーを直線移動することにより、
---:だんだんと散らばっていくように表現することも出来ます。
---$track:範囲
---min=0
---max=1000
local spread = 100
---$tips:移動速度を設定すると、各画像がランダムな方向・速度で移動します。
---$track:移動速度
---min=0
---max=1000
local movement_speed = 0
---$tips:回転速度を設定すると、各画像がランダムな方向・速度で回転します。
---$track:回転速度
---min=0
---max=1000
local rotation_speed = 0

--trackgroup@x_range,y_range,z_range:軸範囲
---$tips:X,Y,Z軸ごとに散らばる範囲の基準を指定します。
---:数値は％で画面サイズが基準となっています(100%=画面サイズ)。
---$track:X軸範囲%
---min=-1000
---max=1000
---step=1
local x_range = 100
---$tips:X,Y,Z軸ごとに散らばる範囲の基準を指定します。
---:数値は％で画面サイズが基準となっています(100%=画面サイズ)。
---$track:Y軸範囲%
---min=-1000
---max=1000
---step=1
local y_range = 100
---$tips:X,Y,Z軸ごとに散らばる範囲の基準を指定します。
---:数値は％で画面サイズが基準となっています(100%=画面サイズ)。
---$track:Z軸範囲%
---min=-1000
---max=1000
---step=1
local z_range = 0

---$tips:X,Y,Z軸ごとに、ランダムに回転させるか指定します。
---$check:X回転
local enable_rotation_x = false

---$tips:X,Y,Z軸ごとに、ランダムに回転させるか指定します。
---$check:Y回転
local enable_rotation_y = false

---$tips:X,Y,Z軸ごとに、ランダムに回転させるか指定します。
---$check:Z回転
local enable_rotation_z = true

---$tips:画像の拡大率をランダムにします。
---:数値は、最小の拡大率をマイナスで指定し、その範囲でランダムな拡大率になります。
---:例えば、拡大最小=80(-%)と設定すると100-80=20%→20%〜100%の間でランダムな拡大率となります。
---$track:拡大最小[-%]
---min=0
---max=100
---step=1
local min_zoom_reduction = 0

--separator:連番
---$tips:読み込むファイルの範囲を指定します。
---$track:File数
---min=0
---max=500
---step=1
local file_count = 10
---$tips:連番部分の桁数を指定します。
---$track:連番桁
---min=1
---max=8
---step=1
local serial_digits = 4
---$tips:読み込む連番ファイルを指定します。
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
