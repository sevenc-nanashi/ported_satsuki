--label:${ROOT_CATEGORY}\アニメーション効果
---$track:経過時間
---min=0
---max=50
---step=0.01
local elapsed_time = 0

---$track:中心X
---min=-1000
---max=1000
---step=0.1
local center_x = 0

---$track:中心Y
---min=-1000
---max=1000
---step=0.1
local center_y = 0

---$track:中心Z
---min=-1000
---max=1000
---step=0.1
local center_z = 0

--trackgroup@center_x,center_y,center_z:中心

---$track:破片サイズ
---min=10
---max=500
---step=0.1
local fragment_size = 50

---$track:速度
---min=0
---max=1000
---step=0.1
local speed = 100

---$track:重力
---min=-1000
---max=1000
---step=0.1
local gravity = 100

---$track:時間差
---min=0
---max=1000
---step=0.1
local delay = 100

---$track:距離影響
---min=0
---max=1000
---step=0.1
local distance_impact = 100

---$track:ランダム回転
---min=0
---max=1000
---step=0.1
local random_spin = 100

---$track:ランダム方向
---min=0
---max=1000
---step=0.1
local random_direction = 100

---$track:再生速度
---min=0
---max=10
---step=0.01
local playback_speed = 1.0

local px = {}
local py = {}
local pz = {}
local pu = {}
local pv = {}
local vertices = {}

local time = elapsed_time / 10 * playback_speed
obj.effect()

local gravity_acceleration = gravity * 6
local delay_scale = delay * 0.002
local impact_scale = distance_impact * 0.1
local spin_scale = math.floor(random_spin * 10)
local direction_scale = random_direction / 80
local width = obj.w
local height = obj.h
local speed_scale = speed * 0.01 * math.sqrt(impact_scale)
local fragment_columns = math.floor(width / fragment_size)
local fragment_rows = math.floor(height / fragment_size)
local diagonal_length = math.sqrt(width * width + height * height)

if fragment_columns < 2 then
    fragment_columns = 2
elseif fragment_columns > width then
    fragment_columns = width
end
if fragment_rows < 2 then
    fragment_rows = 2
elseif fragment_rows > height then
    fragment_rows = height
end

local random_width = width / fragment_columns / 2.3
local random_height = height / fragment_rows / 2.3
for y = 0, fragment_rows - 1 do
    for x = 0, fragment_columns - 1 do
        -- 各頂点を計算
        pu[0] = width * x / fragment_columns
        pu[1] = width * (x + 1) / fragment_columns
        pu[2] = pu[1]
        pu[3] = pu[0]
        pv[0] = height * y / fragment_rows
        pv[1] = pv[0]
        pv[2] = height * (y + 1) / fragment_rows
        pv[3] = pv[2]
        pu[0] = pu[0] + obj.rand(-random_width, random_width, x, y)
        pu[1] = pu[1] + obj.rand(-random_width, random_width, x + 1, y)
        pu[2] = pu[2] + obj.rand(-random_width, random_width, x + 1, y + 1)
        pu[3] = pu[3] + obj.rand(-random_width, random_width, x, y + 1)
        pv[0] = pv[0] + obj.rand(-random_height, random_height, x, y + 1000)
        pv[1] = pv[1] + obj.rand(-random_height, random_height, x + 1, y + 1000)
        pv[2] = pv[2] + obj.rand(-random_height, random_height, x + 1, y + 1 + 1000)
        pv[3] = pv[3] + obj.rand(-random_height, random_height, x, y + 1 + 1000)
        if x == 0 then
            pu[0] = 0
            pu[3] = 0
        elseif x == fragment_columns - 1 then
            pu[1] = width
            pu[2] = width
        end
        if y == 0 then
            pv[0] = 0
            pv[1] = 0
        elseif y == fragment_rows - 1 then
            pv[2] = height
            pv[3] = height
        end

        -- 基準の計算
        local base_x = (pu[0] + pu[1] + pu[2] + pu[3]) / 4
        local base_y = (pv[0] + pv[1] + pv[2] + pv[3]) / 4
        local draw_x = base_x - width / 2
        local draw_y = base_y - height / 2
        local draw_z = 0
        local velocity_x = draw_x - center_x
        local velocity_y = draw_y - center_y
        local velocity_z = -center_z
        local distance = math.sqrt(velocity_x * velocity_x + velocity_y * velocity_y + velocity_z * velocity_z)

        -- 時間の計算
        local fragment_time = time - distance / diagonal_length * delay_scale
        if fragment_time < 0 then
            fragment_time = 0
        end

        -- 回転を計算
        local rotation_x = fragment_time * obj.rand(-spin_scale, spin_scale, x, y + 2000) / 100
        local rotation_y = fragment_time * obj.rand(-spin_scale, spin_scale, x, y + 3000) / 100
        local rotation_z = fragment_time * obj.rand(-spin_scale, spin_scale, x, y + 4000) / 100
        local sin_x = math.sin(rotation_x)
        local cos_x = math.cos(rotation_x)
        local sin_y = math.sin(rotation_y)
        local cos_y = math.cos(rotation_y)
        local sin_z = math.sin(rotation_z)
        local cos_z = math.cos(rotation_z)
        local matrix_00 = cos_y * cos_z
        local matrix_01 = -cos_y * sin_z
        local matrix_10 = cos_x * sin_z + sin_x * cos_z * sin_y
        local matrix_11 = cos_x * cos_z - sin_x * sin_z * sin_y
        local matrix_20 = sin_x * sin_z - cos_x * cos_z * sin_y
        local matrix_21 = sin_x * cos_z + cos_x * sin_z * sin_y
        for i = 0, 3 do
            local vertex_x = pu[i] - base_x
            local vertex_y = pv[i] - base_y
            px[i] = matrix_00 * vertex_x + matrix_01 * vertex_y
            py[i] = matrix_10 * vertex_x + matrix_11 * vertex_y
            pz[i] = matrix_20 * vertex_x + matrix_21 * vertex_y
        end

        -- 表示座標を計算
        local distance_rate = 1 / (1 + distance * distance / (diagonal_length * diagonal_length) * impact_scale)
        velocity_x = velocity_x * distance_rate + obj.rand(-fragment_size, fragment_size, x, y + 4000) * direction_scale
        velocity_y = velocity_y * distance_rate + obj.rand(-fragment_size, fragment_size, x, y + 5000) * direction_scale
        velocity_z = velocity_z * distance_rate + obj.rand(-fragment_size, fragment_size, x, y + 6000) * direction_scale
        draw_x = draw_x + fragment_time * velocity_x * speed_scale
        draw_y = draw_y
            + fragment_time * velocity_y * speed_scale
            + fragment_time * fragment_time * gravity_acceleration
        draw_z = draw_z + fragment_time * velocity_z * speed_scale
        vertices[#vertices + 1] = {
            px[0] + draw_x,
            py[0] + draw_y,
            pz[0] + draw_z,
            px[1] + draw_x,
            py[1] + draw_y,
            pz[1] + draw_z,
            px[2] + draw_x,
            py[2] + draw_y,
            pz[2] + draw_z,
            px[3] + draw_x,
            py[3] + draw_y,
            pz[3] + draw_z,
            pu[0],
            pv[0],
            pu[1],
            pv[1],
            pu[2],
            pv[2],
            pu[3],
            pv[3],
        }
    end
end

obj.drawpoly(vertices)
