--label:${ROOT_CATEGORY}\アニメーション効果
---$track:振幅
---min=0
---max=500
---step=0.1
local amplitude = 5

---$track:角度
---min=0
---max=180
---step=0.1
local angle_range = 10

---$track:間隔
---min=0
---max=100
---step=0.1
local interval = 0

---$track:seed
---min=1
---max=100
---step=1
local random_seed = 1

local seed = -random_seed - 2
if interval == 0 then
    obj.ox = obj.ox + obj.rand(-amplitude, amplitude, seed)
    obj.oy = obj.oy + obj.rand(-amplitude, amplitude, seed + 1)
    obj.rz = obj.rz + obj.rand(-angle_range, angle_range, seed + 2)
else
    local time = obj.time * 100 / interval
    local point_index = math.floor(time)
    local progress = time - point_index
    local x0 = obj.rand(-1000, 1000, seed, point_index) / 1000 * amplitude
    local x1 = obj.rand(-1000, 1000, seed, point_index + 1) / 1000 * amplitude
    local x2 = obj.rand(-1000, 1000, seed, point_index + 2) / 1000 * amplitude
    local x3 = obj.rand(-1000, 1000, seed, point_index + 3) / 1000 * amplitude
    local y0 = obj.rand(-1000, 1000, seed + 1, point_index) / 1000 * amplitude
    local y1 = obj.rand(-1000, 1000, seed + 1, point_index + 1) / 1000 * amplitude
    local y2 = obj.rand(-1000, 1000, seed + 1, point_index + 2) / 1000 * amplitude
    local y3 = obj.rand(-1000, 1000, seed + 1, point_index + 3) / 1000 * amplitude
    local r0 = obj.rand(-1000, 1000, seed + 2, point_index) / 1000 * angle_range
    local r1 = obj.rand(-1000, 1000, seed + 2, point_index + 1) / 1000 * angle_range
    local r2 = obj.rand(-1000, 1000, seed + 2, point_index + 2) / 1000 * angle_range
    local r3 = obj.rand(-1000, 1000, seed + 2, point_index + 3) / 1000 * angle_range
    local x, y = obj.interpolation(progress, x0, y0, x1, y1, x2, y2, x3, y3)
    obj.ox = obj.ox + x
    obj.oy = obj.oy + y
    local rotation = obj.interpolation(progress, r0, r1, r2, r3)
    obj.rz = obj.rz + rotation
end
