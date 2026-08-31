--label:${ROOT_CATEGORY}\画像ファイル
---$script_tips:「画像ループ2」を連番画像で適用します。
---$tips:各画像間の間隔を、XY方向にそれぞれ指定します。
---$track:X間隔
---min=-10000
---max=10000
local x_spacing = 100
---$tips:各画像間の間隔を、XY方向にそれぞれ指定します。
---$track:Y間隔
---min=-10000
---max=10000
local y_spacing = 100
---$tips:Z軸方向にループした場合に、Z軸方向の間隔を指定します。
---$track:Z間隔
---min=-10000
---max=10000
local z_spacing = 300
---$tips:各軸方向にループする回数を指定します。
---$track:X個数
---min=1
---max=100
---step=1
local x_count = 3
---$tips:各軸方向にループする回数を指定します。
---$track:Y個数
---min=1
---max=100
---step=1
local y_count = 3
---$tips:Z軸方向にループする回数を指定します。
---$track:Z個数
---min=1
---max=100
---step=1
local z_count = 1

---$tips:XY軸平面上で段違いにループします。
---$check:XY軸段違い
local stagger_xy = false

---$tips:ZY軸平面上で段違いにループします。
---$check:ZY軸段違い
local stagger_zy = false

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

local function load_sequence_image(x_index, y_index, z_index)
    local extension = file:match("(%.[^%.\\/]*)$") or ""
    local path = file:sub(1, #file - serial_digits - #extension)
    local file_index = obj.rand(1, file_count, y_index + 500, x_index + 1000 * z_index)
    local name = string.format("%0" .. serial_digits .. "d", file_index) .. extension
    obj.load("image", path .. name)
end

for z_index = 0, z_count - 1 do
    local z = -z_spacing * (z_count - 1) / 2 + z_index * z_spacing
    for y_index = 0, y_count - 1 do
        local y = -y_spacing * (y_count - 1) / 2 + y_index * y_spacing
        if stagger_zy and z_index % 2 == 0 then
            y = y + y_spacing / 2
        end

        for x_index = 0, x_count - 1 do
            local x = -x_spacing * (x_count - 1) / 2 + x_index * x_spacing
            if stagger_xy and y_index % 2 == 0 then
                x = x + x_spacing / 2
            end

            load_sequence_image(x_index, y_index, z_index)
            obj.effect()
            obj.draw(x, y, z)
        end
    end
end
