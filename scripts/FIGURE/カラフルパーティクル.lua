--label:${ROOT_CATEGORY}\パーティクル出力
---$track:頻度
---min=0.1
---max=500
---step=0.1
local frequency = 10
---$track:距離
---min=1
---max=10000
---step=1
local distance = 500
---$track:速度
---min=1
---max=2000
---step=1
local speed = 400
---$track:方向
---min=-360
---max=360
---step=1
local direction = 0
---$figure:種類
local figure_name = "円"

---$track:サイズ
---min=0
---max=2000
---step=1
local figure_size = 100

---$track:ライン幅
---min=0
---max=10000
---step=1
local line_width = 4000

---$track:ランダム方向
---min=0
---max=360
---step=1
local random_direction = 30

---$track:ランダム速度[-%]
---min=0
---max=100
---step=1
local random_speed = 0

---$track:ランダム拡大[-%]
---min=0
---max=100
---step=1
local random_scale = 0

---$track:透過速度[%]
---min=0
---max=200
---step=1
local alpha_speed = 100

---$track:拡大速度[%]
---min=-100
---max=1000
---step=1
local scale_speed = 0

---$track:ランダムZ角度
---min=0
---max=360
---step=1
local random_z_rotation = 0

---$track:X軸ランダム
---min=0
---max=10000
---step=1
local random_x = 0

---$track:Y軸ランダム
---min=0
---max=10000
---step=1
local random_y = 0

---$track:ランダムZ回転
---min=0
---max=360
---step=1
local random_z_rotation_speed = 0

local spawn_interval = 1 / frequency
local travel_time = distance / speed
local base_direction = -direction + 90
local random_xy_rotation = 0
local random_z = 0
local random_xy_rotation_speed = 0
local random_z_move = 0

local count = obj.totaltime / spawn_interval
for i = 0, count - 1 do
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

    local progress = (travel_time - obj.time + i * spawn_interval) / travel_time
    progress = math.min(1, math.max(progress, 0))

    local particle_direction =
        obj.rand(base_direction - random_direction / 2, base_direction + random_direction / 2, i, 0)
    local speed_rate = obj.rand(100 - random_speed, 100, i, 12) / 100
    local progress_rate = (1 - progress) * speed_rate
    local x = distance * math.cos(particle_direction * math.pi / 180) * progress_rate
        + obj.rand(-random_x / 2, random_x / 2, i, 1)
    local y = distance * math.sin(particle_direction * math.pi / 180) * progress_rate
        + obj.rand(-random_y / 2, random_y / 2, i, 2)
    local z = obj.rand(-random_z_move / 2, random_z_move / 2, i, 11) * progress_rate
        + obj.rand(-random_z / 2, random_z / 2, i, 3)
    local zoom = 1 + scale_speed / 100 * (1 - progress) - obj.rand(0, random_scale, i, 10) / 100
    local alpha = 1 - alpha_speed / 100 * (1 - progress)
    local rx = obj.rand(-random_xy_rotation / 2, random_xy_rotation / 2, i, 4)
        + obj.rand(-random_xy_rotation_speed / 2, random_xy_rotation_speed / 2, i, 7) * obj.time
    local ry = obj.rand(-random_xy_rotation / 2, random_xy_rotation / 2, i, 5)
        + obj.rand(-random_xy_rotation_speed / 2, random_xy_rotation_speed / 2, i, 8) * obj.time
    local rz = obj.rand(-random_z_rotation / 2, random_z_rotation / 2, i, 6)
        + obj.rand(-random_z_rotation_speed / 2, random_z_rotation_speed / 2, i, 9) * obj.time

    if progress == 0 or progress == 1 then
        alpha = 0
    end

    obj.draw(x, y, z, zoom, alpha, rx, ry, rz)
end
