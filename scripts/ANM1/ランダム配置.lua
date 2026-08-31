---$script_tips:同じ画像をランダムな座標・角度で配置します。
--label:${ROOT_CATEGORY}\配置
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
local movement_speed = 0
---$tips:回転速度を設定すると、各画像がランダムな方向・速度で回転します。
---$track:回転速度
---min=0
---max=1000
local rotation_speed = 0
---$tips:X,Y,Z軸ごとに散らばる範囲の基準を指定します。
---:数値は％で画面サイズが基準となっています(100%=画面サイズ)。
---$track:X軸範囲[%]
---min=0
---max=1000
local wx = 100

---$tips:X,Y,Z軸ごとに散らばる範囲の基準を指定します。
---:数値は％で画面サイズが基準となっています(100%=画面サイズ)。
---$track:Y軸範囲[%]
---min=0
---max=1000
local wy = 100

---$tips:X,Y,Z軸ごとに散らばる範囲の基準を指定します。
---:数値は％で画面サイズが基準となっています(100%=画面サイズ)。
---$track:Z軸範囲[%]
---min=0
---max=1000
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

---$tips:各種のランダムに設定された結果を、別のランダム結果に変更します。
---:数値は適当な整数を入力すればよいので、好みのランダム結果が表示されるようにいろいろ試すとよいかもしれません。
---$track:乱数
---min=0
---max=1000
---step=1
local ran = 0

---$tips:チェックすると、オブジェクトのレイヤーを移動しても、ランダム結果が固定となります。
---$check:ランダム固定
local fugo = 0

obj.effect()
local w = range / 100 --範囲
local v = movement_speed / 100 --移動速度
local r = rotation_speed / 100 --回転速度
for i = 0, n - 1 do
    local seed = (i + 1 + ran) * (1 - 2 * fugo)
    local x = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, seed, 0) / 2 * w
        + obj.rand(-100, 100, seed, 3) * obj.time * v
    )
        * wx
        / 100
    local y = (
        obj.rand(-obj.screen_h - obj.h, obj.screen_h + obj.h, seed, 1) / 2 * w
        + obj.rand(-100, 100, seed, 4) * obj.time * v
    )
        * wy
        / 100
    local z = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, seed, 2) / 2 * w
        + obj.rand(-100, 100, seed, 5) * obj.time * v
    )
        * wz
        / 100
    local s = obj.rand(100 - s_min, 100, seed, 6) / 100
    local rx = (obj.rand(0, 360, seed, 7) + obj.rand(-100, 100, seed, 10) * obj.time * r) * kx
    local ry = (obj.rand(0, 360, seed, 8) + obj.rand(-100, 100, seed, 11) * obj.time * r) * ky
    local rz = (obj.rand(0, 360, seed, 9) + obj.rand(-100, 100, seed, 12) * obj.time * r) * kz
    obj.draw(x, y, z, s, 1, rx, ry, rz)
end
