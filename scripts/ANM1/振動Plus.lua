--label:${ROOT_CATEGORY}\アニメーション効果
---$track:振幅
---min=0
---max=1000
---step=0.1
local amplitude = 50

---$track:周期[s]
---min=0.01
---max=2
---step=0.01
local period = 0.2

---$track:個数
---min=0
---max=100
---step=1
local count = 10

---$track:閾値
---min=0
---max=100
---step=0.1
local threshold = 0

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
