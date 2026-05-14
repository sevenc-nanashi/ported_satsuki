--label:${ROOT_CATEGORY}\画像ファイル
---$track:半径
---min=1
---max=1000
---step=1
local radius = 100
---$track:自転
---min=-3600
---max=3600
local spin_rotation = 0
---$select:方向
---指定なし=-1
---正面=0
---球の軸の外側=1
---球の軸の内側=2
---球の外側=3
---球の中心=4
local direction = 3
---$track:極スケール%
---min=0
---max=1000
---step=1
local pole_scale = 100

---$track:Xスケール%
---min=0
---max=1000
---step=1
local x_scale = 100

---$track:Yスケール%
---min=0
---max=1000
---step=1
local y_scale = 100

---$track:Zスケール%
---min=0
---max=1000
---step=1
local z_scale = 100

---$track:経線頂点
---min=1
---max=100
---step=1
local meridian_vertices = 10

---$track:緯線頂点
---min=1
---max=100
---step=1
local parallel_vertices = 10

---$check:両極を描画
local draw_poles = false

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

-- ※GH球状配置2(sm13806316参照)を改変したものです。

local function load_sequence_image(meridian_index, parallel_index)
    local extension = file:match("(%.[^%.\\/]*)$") or ""
    local path = file:sub(1, #file - serial_digits - #extension)
    local file_index = obj.rand(1, file_count, parallel_index + 500, meridian_index + 1000)
    local name = string.format("%0" .. serial_digits .. "d", file_index) .. extension
    obj.load("image", path .. name)
end

local function orient_image(x, y, z, rotation_x, rotation_y, rotation_z)
    if direction == -1 then
        return x, y, z, 0, 0, 0
    elseif direction == 0 then
        return x, y, z, 0, 0, rotation_z
    elseif direction == 1 then
        return x, y, z, rotation_x, 0, rotation_z
    elseif direction == 2 then
        return x, y, z, rotation_x + 180, 0, rotation_z
    elseif direction == 4 then
        return -x, -y, -z, rotation_x, rotation_y, rotation_z
    end
    return x, y, z, rotation_x, rotation_y, rotation_z
end

for meridian_index = 0, meridian_vertices - 1 do
    local rotation_y
    if draw_poles then
        rotation_y = 90 - 180 / (meridian_vertices + 1) * (meridian_index + 1) -- 極を考えて均等配置
    else
        rotation_y = 90 - 90 / meridian_vertices - 180 / meridian_vertices * meridian_index -- 極を考えずに均等配置
    end
    local rad_y = math.rad(rotation_y)
    -- リサイズ計算はKENくん方式を踏まえてmath.cos()を使うように改修
    local zoom = ((100 - pole_scale) * math.cos(rad_y) + pole_scale) / 100

    for parallel_index = 0, parallel_vertices - 1 do
        load_sequence_image(meridian_index, parallel_index)
        obj.effect()

        local rotation_x = 360 / parallel_vertices * parallel_index + spin_rotation
        local rotation_z = -90
        local rad_x = math.rad(rotation_x)
        local x = -radius * math.sin(rad_y) * x_scale / 100
        local y = radius * math.sin(rad_x) * math.cos(rad_y) * y_scale / 100
        local z = -radius * math.cos(rad_x) * math.cos(rad_y) * z_scale / 100
        x, y, z, rotation_x, rotation_y, rotation_z = orient_image(x, y, z, rotation_x, rotation_y, rotation_z)

        obj.draw(x, y, z, zoom, 1, rotation_x, rotation_y, rotation_z)
    end
end

if draw_poles then
    -- 北極が0度経線、南極が180度経線に従うようにする。
    local x = radius * x_scale / 100
    local zoom = pole_scale / 100
    if direction == -1 then
        obj.draw(-x, 0, 0, zoom, 1, 0, 0, 0)
        obj.draw(x, 0, 0, zoom, 1, 0, 0, 0)
    elseif direction == 0 then
        obj.draw(-x, 0, 0, zoom, 1, 0, 0, -90)
        obj.draw(x, 0, 0, zoom, 1, 0, 0, -90)
    elseif direction == 1 then
        obj.draw(-x, 0, 0, zoom, 1, spin_rotation, 0, -90)
        obj.draw(x, 0, 0, zoom, 1, spin_rotation + 180, 0, -90)
    elseif direction == 2 then
        obj.draw(-x, 0, 0, zoom, 1, spin_rotation + 180, 0, -90)
        obj.draw(x, 0, 0, zoom, 1, spin_rotation, 0, -90)
    elseif direction == 3 then
        obj.draw(-x, 0, 0, zoom, 1, spin_rotation, 90, -90)
        obj.draw(x, 0, 0, zoom, 1, spin_rotation + 180, -90, -90)
    elseif direction == 4 then
        obj.draw(-x, 0, 0, zoom, 1, spin_rotation + 180, -90, -90)
        obj.draw(x, 0, 0, zoom, 1, spin_rotation, 90, -90)
    end
end
