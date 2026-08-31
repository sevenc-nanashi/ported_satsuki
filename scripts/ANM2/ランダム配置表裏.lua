---$script_tips:表と裏が別の画像をランダムに配置します。
---:使い方
---:(A)→(B)の順番でアニメーション効果を適用して下さい。
---:(B)の[参照]から裏面画像を読み込みます。
---:拡張描画にして「裏面を表示しない」にチェックして下さい。
--label:${ROOT_CATEGORY}\変形
---$tips:配置する画像の数を指定します。
---$track:個数
---min=0
---max=1000
---step=1
local n = 5
---$tips:散らばる範囲を一括して調整します。
---:ゼロにすると中心に収束し、トラックバーを直線移動することにより、
---:だんだんと散らばっていくように表現することも出来ます。
---$track:範囲
---min=0
---max=1000
local range = 100
---$tips:移動速度を設定すると、各画像がランダムな方向・速度で移動します。
---$track:移動速度
---min=0
---max=1000
local move_speed = 0
---$tips:回転速度を設定すると、各画像がランダムな方向・速度で回転します。
---$track:回転速度
---min=0
---max=1000
local rotation_speed = 0
---$tips:裏面画像のみを左右反転します。
---$check:裏反転
local reverse_back = 0
---$tips:裏面画像を読み込みます。
---$file:ファイル
local file = nil

---$tips:X,Y,Z軸ごとに散らばる範囲の基準を指定します。
---:数値は％で画面サイズが基準となっています(100%=画面サイズ)。
---$track:X軸範囲[%]
---min=0
---max=100
local wx = 100

---$tips:X,Y,Z軸ごとに散らばる範囲の基準を指定します。
---:数値は％で画面サイズが基準となっています(100%=画面サイズ)。
---$track:Y軸範囲[%]
---min=0
---max=100
local wy = 100

---$tips:X,Y,Z軸ごとに散らばる範囲の基準を指定します。
---:数値は％で画面サイズが基準となっています(100%=画面サイズ)。
---$track:Z軸範囲[%]
---min=0
---max=100
local wz = 0

---$tips:X,Y,Z軸ごとに、ランダムに回転させるか指定します。
---$check:X回転
local kx = 0

---$tips:X,Y,Z軸ごとに、ランダムに回転させるか指定します。
---$check:Y回転
local ky = 0

---$tips:X,Y,Z軸ごとに、ランダムに回転させるか指定します。
---$check:Z回転
local kz = 1

---$tips:画像の拡大率をランダムにします。
---:数値は、最小の拡大率をマイナスで指定し、その範囲でランダムな拡大率になります。
---:例えば、拡大最小=80(-%)と設定すると100-80=20%→20%〜100%の間でランダムな拡大率となります。
---$track:拡大最小[-%]
---min=0
---max=100
local s_min = 0

local w = range / 100
local v = move_speed / 100
local r = rotation_speed / 100

local function random_transform(i)
    local x = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, -1 - i, 0) / 2 * w
        + obj.rand(-100, 100, -1 - i, 3) * obj.time * v
    )
        * wx
        / 100
    local y = (
        obj.rand(-obj.screen_h - obj.h, obj.screen_h + obj.h, -1 - i, 1) / 2 * w
        + obj.rand(-100, 100, -1 - i, 4) * obj.time * v
    )
        * wy
        / 100
    local z = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, -1 - i, 2) / 2 * w
        + obj.rand(-100, 100, -1 - i, 5) * obj.time * v
    )
        * wz
        / 100
    local zoom = obj.rand(100 - s_min, 100, -1 - i, 6) / 100
    local rx = (obj.rand(0, 360, -1 - i, 7) + obj.rand(-100, 100, -1 - i, 10) * obj.time * r) * kx
    local ry = (obj.rand(0, 360, -1 - i, 8) + obj.rand(-100, 100, -1 - i, 11) * obj.time * r) * ky
    local rz = (obj.rand(0, 360, -1 - i, 9) + obj.rand(-100, 100, -1 - i, 12) * obj.time * r) * kz

    return x, y, z, zoom, rx, ry, rz
end

obj.effect()
obj.setoption("culling", 1)
for i = 0, n - 1 do
    local x, y, z, zoom, rx, ry, rz = random_transform(i)
    obj.draw(x, y, z, zoom, 1, rx, ry, rz)
end

obj.load(file)
obj.effect("反転", "左右反転", reverse_back)
obj.effect()
for i = 0, n - 1 do
    local x, y, z, zoom, rx, ry, rz = random_transform(i)
    obj.draw(x, y, z, zoom, 1, rx, ry + 180, -rz - obj.getvalue("rz") * 2)
end
