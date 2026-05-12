--label:${ROOT_CATEGORY}\変形
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
---$check:裏反転
local reverse_back = 0
---$file:ファイル
local file = nil

---$track:ランダム方向[度]
---min=-360
---max=360
local random_direction = 30

---$value:透過速度[%]
---min=0
---max=400
---step=1
local alpha_speed = 100

---$track:拡大速度[%]
---min=0
---max=400
---step=1
local zoom_speed = 0

---$track:ランダム速度[-%]
---min=0
---max=100
---step=1
local random_speed = 0

---$track:ランダム拡大[-%]
---min=0
---max=100
---step=1
local random_zoom = 0

---$track:ランダムZ角度[度]
---min=-360
---max=360
local random_rz = 0

---$track:X軸ランダム
---min=-4000
---max=-4000
---step=0.01
local random_x = 0

---$track:Y軸ランダム
---min=-4000
---max=-4000
---step=0.01
local random_y = 0

---$track:Z軸ランダム
---min=-4000
---max=-4000
---step=0.01
local random_z = 0

---$value:回転速度[度]
---min=-3600
---max=3600
local random_rotation_speed = 0

---$check:XY回転あり
local random_xy_rotation = 0

---$track:Z軸ランダム方向
---min=-3600
---max=3600
local random_z_direction = 0

local interval = 1 / frequency
local duration = distance / speed
local base_direction = -direction + 90
local count = obj.totaltime / interval
print("interval", interval, "duration", duration, "base_direction", base_direction, "count", count)

local function particle_transform(i)
    local t = (duration - obj.time + i * interval) / duration
    t = math.min(1, math.max(t, 0))

    local direct = obj.rand(base_direction - random_direction / 2, base_direction + random_direction / 2, i, 0)
    local speed_rate = obj.rand(100 - random_speed, 100, -1 - i, 12) / 100
    local x = distance * math.cos(direct * math.pi / 180) * (1 - t) * speed_rate
        + obj.rand(-random_x / 2, random_x / 2, -1 - i, 1)
    local y = distance * math.sin(direct * math.pi / 180) * (1 - t) * speed_rate
        + obj.rand(-random_y / 2, random_y / 2, -1 - i, 2)
    local z = obj.rand(-random_z_direction / 2, random_z_direction / 2, -1 - i, 11) * (1 - t) * speed_rate
        + obj.rand(-random_z / 2, random_z / 2, -1 - i, 3)
    local zoom = 1 + zoom_speed / 100 * (1 - t) - obj.rand(0, random_zoom, -1 - i, 10) / 100
    local alpha = 1 - alpha_speed / 100 * (1 - t)
    local rx = random_xy_rotation
        * (
            obj.rand(0, 360, -1 - i, 4)
            + obj.rand(-random_rotation_speed / 2, random_rotation_speed / 2, -1 - i, 7) * obj.time
        )
    local ry = random_xy_rotation
        * (
            obj.rand(0, 360, -1 - i, 5)
            + obj.rand(-random_rotation_speed / 2, random_rotation_speed / 2, -1 - i, 8) * obj.time
        )
    local rz = obj.rand(-random_rz / 2, random_rz / 2, -1 - i, 6)
        + obj.rand(-random_rotation_speed / 2, random_rotation_speed / 2, -1 - i, 9) * obj.time

    if t == 0 or t == 1 then
        alpha = 0
    end

    return x, y, z, zoom, alpha, rx, ry, rz
end

obj.effect()
obj.setoption("culling", 1)
for i = 0, count - 1 do
    obj.draw(particle_transform(i))
end

obj.load(file)
obj.effect("反転", "左右反転", reverse_back)
obj.effect()
for i = 0, count - 1 do
    local x, y, z, zoom, alpha, rx, ry, rz = particle_transform(i)
    obj.draw(x, y, z, zoom, alpha, rx, ry + 180, -rz - obj.getvalue("rz") * 2)
end
