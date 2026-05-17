--label:${ROOT_CATEGORY}\アニメーション効果
---$track:XY振幅
---min=0
---max=500
---step=0.1
local amplitude_xy = 200

---$track:間隔
---min=1
---max=500
---step=0.1
local interval = 100

---$track:個数
---min=1
---max=100
---step=1
local count = 3

---$track:範囲
---min=0
---max=100
---step=0.1
local range_rate = 100

---$track:Z軸振幅
---min=0
---max=500
---step=0.1
local amplitude_z = 0

---$track:Z軸回転範囲
---min=0
---max=360
---step=0.1
local rotation_z_range = 10

---$track:ランダム角度
---min=0
---max=360
---step=0.1
local random_rotation_range = 0

---$track:ランダムサイズ[-%]
---min=0
---max=100
---step=0.1
local random_zoom_reduction = 0

---$track:ランダム透明度[-%]
---min=0
---max=100
---step=0.1
local random_alpha_reduction = 0

---$track:差分
---min=-100
---max=100
---step=0.1
local time_offset = 7.7

local range_scale = range_rate / 100
for i = 0, count - 1 do
    local time = (obj.time + i * time_offset) * 100 / interval
    local point_index = math.floor(time)
    local progress = time - point_index
    local x0 = obj.rand(-1000, 1000, i, point_index) / 1000 * amplitude_xy * range_scale
    local x1 = obj.rand(-1000, 1000, i, point_index + 1) / 1000 * amplitude_xy * range_scale
    local x2 = obj.rand(-1000, 1000, i, point_index + 2) / 1000 * amplitude_xy * range_scale
    local x3 = obj.rand(-1000, 1000, i, point_index + 3) / 1000 * amplitude_xy * range_scale
    local y0 = obj.rand(-1000, 1000, 1 + i, point_index) / 1000 * amplitude_xy * range_scale
    local y1 = obj.rand(-1000, 1000, 1 + i, point_index + 1) / 1000 * amplitude_xy * range_scale
    local y2 = obj.rand(-1000, 1000, 1 + i, point_index + 2) / 1000 * amplitude_xy * range_scale
    local y3 = obj.rand(-1000, 1000, 1 + i, point_index + 3) / 1000 * amplitude_xy * range_scale
    local z0 = obj.rand(-1000, 1000, 2 + i, point_index) / 1000 * amplitude_z * range_scale
    local z1 = obj.rand(-1000, 1000, 2 + i, point_index + 1) / 1000 * amplitude_z * range_scale
    local z2 = obj.rand(-1000, 1000, 2 + i, point_index + 2) / 1000 * amplitude_z * range_scale
    local z3 = obj.rand(-1000, 1000, 2 + i, point_index + 3) / 1000 * amplitude_z * range_scale
    local r0 = obj.rand(-1000, 1000, 3 + i, point_index) / 1000 * rotation_z_range * range_scale
    local r1 = obj.rand(-1000, 1000, 3 + i, point_index + 1) / 1000 * rotation_z_range * range_scale
    local r2 = obj.rand(-1000, 1000, 3 + i, point_index + 2) / 1000 * rotation_z_range * range_scale
    local r3 = obj.rand(-1000, 1000, 3 + i, point_index + 3) / 1000 * rotation_z_range * range_scale
    local x, y, z = obj.interpolation(progress, x0, y0, z0, x1, y1, z1, x2, y2, z2, x3, y3, z3)
    local rotation_z = obj.interpolation(progress, r0, r1, r2, r3)
    local zoom = 1 - obj.rand(0, 1000, 10 + i, 10) / 1000 * random_zoom_reduction / 100
    local alpha = 1 - obj.rand(0, 1000, 11 + i, 11) / 1000 * random_alpha_reduction / 100
    local random_rotation_z = obj.rand(-random_rotation_range / 2, random_rotation_range / 2, 12 + i, 12)
    obj.draw(x, y, z, zoom, alpha, 0, 0, rotation_z + random_rotation_z)
end
