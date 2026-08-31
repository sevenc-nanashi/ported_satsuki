--label:${ROOT_CATEGORY}\パーティクル出力
---$script_tips:ランダムな色の図形をランダムに配置します。
---$tips:配置する図形の数を指定します。
---$track:個数
---min=0
---max=1000
---step=1
local count = 5
---$tips:図形を配置する範囲をしていします。
---:100%が画面サイズとなります。
---$track:X幅[%]
---min=0
---max=5000
---step=1
local width_x = 100
---$tips:図形を配置する範囲をしていします。
---:100%が画面サイズとなります。
---$track:Y幅[%]
---min=0
---max=5000
---step=1
local width_y = 100
---$tips:図形を配置する範囲をしていします。
---:100%が画面サイズとなります。
---$track:Z幅[%]
---min=0
---max=5000
---step=1
local width_z = 0
---$tips:図形の種類を指定します。
---$figure:種類
local figure_name = "円"

---$tips:図形のサイズを指定します。
---$track:サイズ
---min=0
---max=2000
---step=1
local figure_size = 100

---$tips:図形のライン幅を指定します。
---$track:ライン幅
---min=0
---max=10000
---step=1
local line_width = 4000

---$tips:ランダムに回転する速さを指定します。
---$track:ランダムZ回転
---min=0
---max=360
---step=1
local random_z_rotation_speed = 0

---$tips:図形一つひとつの拡大率をランダムにします。
---:数値は、例えば、ランダム拡大=80で設定すると、100-80=20%→20%〜100%の範囲でランダムとなります。
---$track:ランダム拡大[-%]
---min=0
---max=100
---step=1
local random_scale = 0

for i = 0, count do
    local color_phase = (obj.rand(0, 100, i, 100) - 50) / 100
    local color
    if color_phase < 0 then
        color = math.floor(math.cos(math.pi * color_phase) * 255) * 256
            + math.floor(math.sin(math.pi * -color_phase) * 255)
    else
        color = math.floor(math.cos(math.pi * color_phase) * 255) * 256
            + math.floor(math.sin(math.pi * color_phase) * 255) * 65536
    end

    obj.load("figure", figure_name, color, figure_size, line_width)
    obj.effect()

    local x = obj.rand(-obj.screen_w, obj.screen_w, i, 0) / 2 * width_x / 100
    local y = obj.rand(-obj.screen_h, obj.screen_h, i, 1) / 2 * width_y / 100
    local z = obj.rand(-1000, 1000, i, 2) / 2 * width_z / 100
    local rz = obj.rand(-100, 100, i, 3) / 100 * obj.time * random_z_rotation_speed
    local zoom = 1 - obj.rand(0, random_scale, i, 4) / 100

    obj.draw(x, y, z, zoom, 1, 0, 0, rz)
end
