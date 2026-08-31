--label:${ROOT_CATEGORY}\画像ファイル
---$script_tips:こちらの螺旋配置スクリプトを連番画像にも対応させて改変したものです。
---:http://www.nicovideo.jp/watch/sm13546528
---:カメラ制御下で使用して下さい。
---$tips:描画する画像の数を指定します。
---$track:個数
---min=0
---max=300
---step=1
local count = 10
---$tips:次の画像を描画する際の角度の差分を指定します。
---:らせんを巻く回数のイメージです。
---$track:回転差分
---min=-360
---max=360
local rotation_delta = 10
---$tips:次の画像を描画する際の距離の差分を指定します。
---:らせんの長さを伸ばすイメージです。
---$track:座標差分
---min=-1000
---max=1000
local position_delta = 10
---$tips:らせん全体を回転させます。
---$track:回転
---min=-3600
---max=3600
local base_rotation = 0
---$tips:らせんの軸を指定します。
---$select:軸
---X軸=0
---Y軸=1
---Z軸=2
local axis = 2

---$tips:画像の向きを指定します。
---$select:向き
---回転なし=0
---外側=1
---内側=2
local direction = 1

---$tips:らせんの初期半径を指定します。
---$track:初期半径
---min=0
---max=5000
---step=1
local initial_radius = 100

---$tips:次の画像を描画する際の半径の差分を指定します。
---:らせんの広がりを調整するイメージです。
---$track:半径差分
---min=-5000
---max=5000
---step=1
local radius_delta = 0

---$tips:次の画像を描画する際の拡大率の差分を指定します。
---:画像がだんだん拡大したり縮小したりします。
---$track:大きさ
---min=-500
---max=500
---step=1
local zoom_delta = 0

---$tips:次の画像を描画する際の透明度の差分を指定します。
---:画像をだんだん透明にしたり、透明度を上げたりします。
---$track:透明度
---min=-100
---max=100
---step=1
local alpha_delta = 0

---$tips:チェックすると「回転」の項目で回転させた時、回転に同期して軸方向に移動するようになります。
---$check:回転に同期移動
local sync_movement_to_rotation = false

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
---$tips:配置するファイルの順番を指定します。
---$select:順番
---ランダム=0
---連番=1
local sequence_order = 0
---$tips:読み込む連番ファイルを指定します。
---$file:ファイル
local file = ""

local function load_sequence_image(index)
    local extension = file:match("(%.[^%.\\/]*)$") or ""
    local path = file:sub(1, #file - serial_digits - #extension)
    local file_index
    if sequence_order < 1 then
        file_index = obj.rand(1, file_count, 0, index)
    else
        file_index = index + 1
    end

    local name = string.format("%0" .. serial_digits .. "d", file_index) .. extension
    obj.load("image", path .. name)
    obj.effect()
end

local function get_axis_position(index)
    if sync_movement_to_rotation and rotation_delta ~= 0 then
        return position_delta * index + (position_delta / rotation_delta) * base_rotation
    end

    return position_delta * index
end

local function get_direction_rotation(index)
    if direction == 1 then
        return base_rotation + rotation_delta * index
    elseif direction == 2 then
        return base_rotation + rotation_delta * index + 180
    end

    return 0
end

local function draw_sequence_image(index, x, y, z, rotation_x, rotation_y, rotation_z)
    load_sequence_image(index)
    obj.draw(
        x,
        y,
        z,
        obj.zoom + zoom_delta / 100 * index,
        obj.alpha + alpha_delta / 100 * index,
        rotation_x,
        rotation_y,
        rotation_z
    )
end

for index = 0, count - 1 do
    local angle = base_rotation + rotation_delta * index
    local radius = initial_radius + radius_delta * index
    local direction_rotation = get_direction_rotation(index)

    if axis == 0 then
        local x = get_axis_position(index)
        local y = radius * math.sin(angle * math.pi / 180)
        local z = -radius * math.cos(angle * math.pi / 180)
        draw_sequence_image(index, x, y, z, direction_rotation, 0, 0)
    elseif axis == 1 then
        local x = -radius * math.sin(angle * math.pi / 180)
        local y = get_axis_position(index)
        local z = -radius * math.cos(angle * math.pi / 180)
        draw_sequence_image(index, x, y, z, 0, direction_rotation, 0)
    else
        local x = radius * math.cos((-90 + angle) * math.pi / 180)
        local y = radius * math.sin((-90 + angle) * math.pi / 180)
        local z = get_axis_position(index)
        draw_sequence_image(index, x, y, z, 0, 0, direction_rotation)
    end
end
