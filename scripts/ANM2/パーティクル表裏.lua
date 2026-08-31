---$script_tips:表と裏が別の画像をパーティクル出力します。
---:使い方
---:(A)→(B)の順番でアニメーション効果を適用して下さい。
---:(B)の[参照]から裏面画像を読み込みます。
---:拡張描画にして「裏面を表示しない」にチェックして下さい。
--label:${ROOT_CATEGORY}\変形
---$tips:パーティクルの出力頻度を指定します。
---:数値は1秒間に出力されるパーティクルの数を表します。
---$track:頻度
---min=0.1
---max=500
local frequency = 10
---$tips:パーティクルが出力される距離を指定します。
---:本家パーティクルとは異なり、この距離の間だけパーティクルが表示されます。
---:長くしすぎると処理が重くなるので注意。
---$track:距離
---min=1
---max=10000
local distance = 500
---$tips:パーティクルの出力される速度を指定します。
---$track:速度
---min=1
---max=2000
local speed = 400
---$tips:パーティクルの出力される方向を指定します。下方向がゼロ度です。
---$track:方向
---min=-360
---max=360
local direction = 0
---$tips:裏面画像のみを左右反転します。
---$check:裏反転
local reverse_back = 0
---$tips:裏面画像を読み込みます。
---$file:ファイル
local file = nil

---$tips:指定した角度の範囲でランダム方向に出力されます。360度で全方向です。
---$track:ランダム方向[度]
---min=-360
---max=360
local random_direction = 30

---$tips:透明になる速度を指定します。
---:透過速度=100で、ちょうどパーティクルの終点で透明度がゼロになるようにフェードします。
---$value:透過速度[%]
---min=0
---max=400
---step=1
local alpha_speed = 100

---$tips:オブジェクトが段々と拡大・縮小する速度です。
---$track:拡大速度[%]
---min=0
---max=400
---step=1
local zoom_speed = 0

---$tips:パーティクルの出力される速度をランダムにします。
---:数値は、例えば、ランダム速度=80で設定すると、100-80=20%→20%〜100%の範囲でランダムとなります。
---$track:ランダム速度[-%]
---min=0
---max=100
---step=1
local random_speed = 0

---$tips:パーティクル一つひとつの拡大率をランダムにします。
---:数値は、例えば、ランダム拡大=80で設定すると、100-80=20%→20%〜100%の範囲でランダムとなります。
---$track:ランダム拡大[-%]
---min=0
---max=100
---step=1
local random_zoom = 0

---$tips:出力時の角度がランダムになります。360度で完全にランダムな角度となります。
---$track:ランダムZ角度[度]
---min=-360
---max=360
local random_rz = 0

---$tips:各座標から一定の範囲からランダムに出力されるようになります。
---:例えば、X軸ランダム=800と設定すると、現在のX座標の位置から-400〜400の範囲からランダムに出力されます。
---$track:X軸ランダム
---min=-4000
---max=-4000
---step=0.01
local random_x = 0

---$tips:各座標から一定の範囲からランダムに出力されるようになります。
---:例えば、X軸ランダム=800と設定すると、現在のX座標の位置から-400〜400の範囲からランダムに出力されます。
---$track:Y軸ランダム
---min=-4000
---max=-4000
---step=0.01
local random_y = 0

---$tips:各座標から一定の範囲からランダムに出力されるようになります。
---:例えば、X軸ランダム=800と設定すると、現在のX座標の位置から-400〜400の範囲からランダムに出力されます。
---$track:Z軸ランダム
---min=-4000
---max=-4000
---step=0.01
local random_z = 0

---$tips:回転する速度を指定します。
---:数値は、ひとつのパーティクルが発生してから消えるまで回転する角度を表します。
---:例えば、回転速度=360とすると、発生してから消えるまでに1回転します。
---$value:回転速度[度]
---min=-3600
---max=3600
local random_rotation_speed = 0

---$tips:チェックするとX軸方向、Y軸方向にも回転し、3D的に回転するようになります。
---$check:XY回転あり
local random_xy_rotation = 0

---$tips:Z軸方向にも、ランダムな方向・距離で移動するようになります。
---:数値は、ひとつのパーティクルが発生してから消えるまでに移動する距離の最大値です。
---$track:Z軸ランダム方向
---min=0
---max=1000
local random_z_direction = 0

local interval = 1 / frequency
local duration = distance / speed
local base_direction = -direction + 90
local count = obj.totaltime / interval
print("interval", interval, "duration", duration, "base_direction", base_direction, "count", count)

local function particle_transform(i)
    local t = (duration - obj.time + i * interval) / duration
    t = math.min(1, math.max(t, 0))

    local direct = obj.rand(base_direction - random_direction / 2, base_direction + random_direction / 2, i, 0)
    local speed_rate = obj.rand(100 - random_speed, 100, -1 - i, 12) / 100
    local x = distance * math.cos(direct * math.pi / 180) * (1 - t) * speed_rate
        + obj.rand(-random_x / 2, random_x / 2, -1 - i, 1)
    local y = distance * math.sin(direct * math.pi / 180) * (1 - t) * speed_rate
        + obj.rand(-random_y / 2, random_y / 2, -1 - i, 2)
    local z = obj.rand(-random_z_direction / 2, random_z_direction / 2, -1 - i, 11) * (1 - t) * speed_rate
        + obj.rand(-random_z / 2, random_z / 2, -1 - i, 3)
    local zoom = 1 + zoom_speed / 100 * (1 - t) - obj.rand(0, random_zoom, -1 - i, 10) / 100
    local alpha = 1 - alpha_speed / 100 * (1 - t)
    local rx = random_xy_rotation
        * (
            obj.rand(0, 360, -1 - i, 4)
            + obj.rand(-random_rotation_speed / 2, random_rotation_speed / 2, -1 - i, 7) * obj.time
        )
    local ry = random_xy_rotation
        * (
            obj.rand(0, 360, -1 - i, 5)
            + obj.rand(-random_rotation_speed / 2, random_rotation_speed / 2, -1 - i, 8) * obj.time
        )
    local rz = obj.rand(-random_rz / 2, random_rz / 2, -1 - i, 6)
        + obj.rand(-random_rotation_speed / 2, random_rotation_speed / 2, -1 - i, 9) * obj.time

    if t == 0 or t == 1 then
        alpha = 0
    end

    return x, y, z, zoom, alpha, rx, ry, rz
end

obj.effect()
obj.setoption("culling", 1)
for i = 0, count - 1 do
    obj.draw(particle_transform(i))
end

obj.load(file)
obj.effect("反転", "左右反転", reverse_back)
obj.effect()
for i = 0, count - 1 do
    local x, y, z, zoom, alpha, rx, ry, rz = particle_transform(i)
    obj.draw(x, y, z, zoom, alpha, rx, ry + 180, -rz - obj.getvalue("rz") * 2)
end
