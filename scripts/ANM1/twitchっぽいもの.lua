---$script_tips:振動、放射ブラー、発光、色ずれの4つのフィルタをセットにして適用します。
---:ノイズ表現のひとつに。
--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$tips:フィルタがかかる頻度を指定します。
---$track:閾値
---min=0
---max=100
local siki = 50
---$tips:放射ブラー、発光、色ずれの強さを指定します。
---$track:強さ
---min=0
---max=100
local t = 25
---$tips:発光フィルタのしきい値を指定します。
---:100に近づけるほど、発光しにくくなります。
---$track:発光閾値
---min=0
---max=100
local h = 50

--group:振動

---$tips:振動フィルタの周期を指定します。
---$track:振動周期
---min=0
---max=100
local syu = 10
---$tips:X,Y,Z軸方向のそれぞれの振動の強さを指定します。
---:ゼロにすると、その軸方向には振動しなくなります。
---$track:X振動
---min=-1000
---max=1000
---step=1
local x = 50

---$tips:X,Y,Z軸方向のそれぞれの振動の強さを指定します。
---:ゼロにすると、その軸方向には振動しなくなります。
---$track:Y振動
---min=-1000
---max=1000
---step=1
local y = 50

---$tips:X,Y,Z軸方向のそれぞれの振動の強さを指定します。
---:ゼロにすると、その軸方向には振動しなくなります。
---$track:Z振動
---min=-1000
---max=1000
---step=1
local z = 50

---$tips:振動フィルタは大きい振動と、小さな振動の二つが重ねがけされています。
---:「振動(大)＝振動(小)×揺れ幅倍率」という関係になっており、
---:例えば、揺れ幅倍率をゼロにすると、大きな振動は無くなり、小さく振動するのみとなります。
---$track:揺れ幅倍率
---min=0
---max=10
---step=0.1
local haba = 3

--group:色ずれ

---$tips:色ずれ幅の大きさを％で指定します。
---$track:色ずれ幅
---min=0
---max=1000
---step=1
local irozure = 100

---$tips:色ずれの種類を指定します。
---$select:色ずれ種類
---赤緑A=0
---赤青A=1
---緑青A=2
---赤緑B=3
---赤青B=4
---緑青B=5
local ty = 0

obj.effect(
    "振動",
    "X",
    x,
    "Y",
    y,
    "Z",
    z,
    "周期",
    syu,
    "ランダムに強さを変える",
    1,
    "複雑に振動",
    1
)
obj.effect(
    "振動",
    "X",
    -haba * x,
    "Y",
    -haba * y,
    "Z",
    -haba * z,
    "周期",
    haba * syu,
    "ランダムに強さを変える",
    1,
    "複雑に振動",
    1
)
local s = rand(0, 100)
if s > siki then
    local dx = obj.rand(-obj.screen_w / 2, obj.screen_w / 2)
    local dy = obj.rand(-obj.screen_h / 2, obj.screen_h / 2)
    local a = obj.rand(0, t)
    obj.effect("放射ブラー", "範囲", a, "X", dx, "Y", dy, "サイズ固定", 1)
    obj.effect("発光", "強さ", 100 + a * 4, "拡散", 800, "しきい値", h, "サイズ固定", 1)
    obj.effect("色ずれ", "ずれ幅", a / 2 * irozure / 100, "角度", obj.rand(0, 360), "色ずれの種類", ty)
    obj.zoom = obj.zoom + a / 50
end
