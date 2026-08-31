---$script_tips:複数の振動フィルタを重ねることで複雑な振動をさせます。
--label:${ROOT_CATEGORY}\アニメーション効果
---$tips:基準となる振幅の大きさを指定します。
---:大きくするとオブジェクトがどこかへ消えやすくなってしまいます。
---$track:振幅
---min=0
---max=1000
---step=0.1
local amplitude = 50

---$tips:基準となる振動の周期を指定します。
---$track:周期[s]
---min=0.01
---max=2
---step=0.01
local period = 0.2

---$tips:重ねがけする振動の数を指定します。
---:数を多くすると振動が相殺されて緩やかになります。
---$track:個数
---min=0
---max=100
---step=1
local count = 10

---$tips:ゼロのときは常に振動します。通常はゼロのままが推奨。
---:ゼロ以外の値に設定した場合は、ランダムに静止状態になります。
---$track:閾値
---min=0
---max=100
---step=0.1
local threshold = 0

---$tips:Z軸方向にも振動するかどうかを選択します。
---$check:z軸振動の有無
local enable_z_axis = true

local function apply_shake(x, y, z, shake_period, probability)
    local random_value = obj.rand(0, 100, 0, math.floor(obj.time / shake_period))
    if random_value < probability then
        obj.effect("振動", "X", x, "Y", y, "Z", z, "周期", shake_period * obj.framerate)
    end
end

local z_axis_scale = enable_z_axis and 1 or 0
for i = 1, count do
    local progress = i / count
    local x_direction = obj.rand(0, 1, i, 0) == 1 and 1 or -1
    local y_direction = obj.rand(0, 1, i, 1) == 1 and 1 or -1
    local z_direction = obj.rand(0, 1, i, 2) == 1 and 1 or -1
    local x = progress * x_direction * amplitude
    local y = progress * y_direction * amplitude
    local z = progress * z_direction * amplitude * z_axis_scale
    local shake_period = i * obj.rand(50, 100, i, 3) / 100 * period
    local probability = 100 - progress * threshold
    apply_shake(x, y, z, shake_period, probability)
end
