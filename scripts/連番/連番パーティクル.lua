--label:${ROOT_CATEGORY}\パーティクル出力
---$track:頻度
---min=0.1
---max=500
local frequency = 10
---$track:距離
---min=1
---max=10000
local distance = 500
---$track:速度
---min=1
---max=2000
local speed = 400
---$track:方向
---min=-360
---max=360
local direction = 0
---$track:ランダム方向[度]
---min=0
---max=360
local random_direction = 30

---$track:透過速度[%]
---min=0
---max=400
local alpha_speed = 100

---$track:拡大速度[%]
---min=-400
---max=400
local zoom_speed = 0

---$track:ランダム速度[-%]
---min=0
---max=100
local random_speed = 0

---$track:ランダム拡大[-%]
---min=0
---max=100
local random_zoom = 0

---$track:ランダムZ角度[度]
---min=0
---max=360
local random_rotation_z = 0

--trackgroup@random_x,random_y,random_z:軸ランダム
---$track:X軸ランダム
---min=0
---max=1000
local random_x = 0

---$track:Y軸ランダム
---min=0
---max=1000
local random_y = 0

---$track:Z軸ランダム
---min=0
---max=1000
local random_z = 0

---$track:回転速度[度]
---min=-3600
---max=3600
local random_rotation_speed = 0

---$check:XY回転あり
local enable_xy_rotation = false

---$track:Z軸ランダム方向
---min=0
---max=1000
local random_z_direction = 0

--separator:連番
---$track:File数
---min=0
---max=500
---step=1
local file_count = 10
---$track:連番桁
---min=1
---max=8
---step=1
local serial_digits = 4
---$file:ファイル
local file = ""

local function load_sequence_image(index)
    local extension = file:match("(%.[^%.\\/]*)$") or ""
    local path = file:sub(1, #file - serial_digits - #extension)
    local file_index = obj.rand(1, file_count, 0, index)
    local name = string.format("%0" .. serial_digits .. "d", file_index) .. extension
    obj.load("image", path .. name)
end

local interval = 1 / frequency -- 出力間隔(秒)
local travel_time = distance / speed -- 距離を進むのにかかる時間
local base_direction = -direction + 90 -- 出力方向
local particle_count = obj.totaltime / interval
local xy_rotation_multiplier = enable_xy_rotation and 1 or 0

for index = 0, particle_count - 1 do
    load_sequence_image(index)
    obj.effect()

    local progress = (travel_time - obj.time + index * interval) / travel_time
    progress = math.min(1, math.max(progress, 0))

    local direct = obj.rand(base_direction - random_direction / 2, base_direction + random_direction / 2, index, 0)
    local speed_ratio = obj.rand(100 - random_speed, 100, index, 12) / 100
    local move_ratio = (1 - progress) * speed_ratio
    local x = distance * math.cos(direct * math.pi / 180) * move_ratio + obj.rand(-random_x / 2, random_x / 2, index, 1)
    local y = distance * math.sin(direct * math.pi / 180) * move_ratio + obj.rand(-random_y / 2, random_y / 2, index, 2)
    local z = obj.rand(-random_z_direction / 2, random_z_direction / 2, index, 11) * move_ratio
        + obj.rand(-random_z / 2, random_z / 2, index, 3)
    local zoom = 1 + zoom_speed / 100 * (1 - progress) - obj.rand(0, random_zoom, index, 10) / 100
    local alpha = 1 - alpha_speed / 100 * (1 - progress)
    local rotation_x = (
        obj.rand(0, 360, index, 4)
        + obj.rand(-random_rotation_speed / 2, random_rotation_speed / 2, index, 7) * obj.time
    ) * xy_rotation_multiplier
    local rotation_y = (
        obj.rand(0, 360, index, 5)
        + obj.rand(-random_rotation_speed / 2, random_rotation_speed / 2, index, 8) * obj.time
    ) * xy_rotation_multiplier
    local rotation_z = obj.rand(-random_rotation_z / 2, random_rotation_z / 2, index, 6)
        + obj.rand(-random_rotation_speed / 2, random_rotation_speed / 2, index, 9) * obj.time

    if progress == 0 or progress == 1 then
        alpha = 0
    end

    obj.draw(x, y, z, zoom, alpha, rotation_x, rotation_y, rotation_z)
end
