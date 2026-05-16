--label:${ROOT_CATEGORY}\図形\立体図形
---$track:長さ
---min=0
---max=1000
---step=1
local length = 200
---$track:幅
---min=0
---max=500
---step=1
local width = 80
---$track:高さ
---min=0
---max=500
---step=1
local height = 50
---$track:回転
---min=-3600
---max=3600
---step=0.01
local rotation = 0
---$track:隙間
---min=0
---max=500
---step=0.1
local gap = 50

---$color:色
local color = 0xffffff

---$check:自動方向(移動時のみ)
local use_auto_direction = false

---$select:計算基準軸
---Z軸=0
---X軸=1
local base_axis = 0

local function draw_static_plane()
    obj.load("figure", "四角形", color, 2)
    obj.effect()
    obj.setoption("billboard", 0)
    obj.drawpoly(0, -length / 2, 0, -width - gap / 2, length / 2, 0, -gap / 2 + 1, length / 2, 0, 0, -length / 2, 0) --左翼
    obj.drawpoly(0, -length / 2, 0, width + gap / 2, length / 2, 0, gap / 2 - 1, length / 2, 0, 0, -length / 2, 0) --右翼
    obj.drawpoly(0, -length / 2, 0, -gap / 2, length / 2, 0, 0, length / 2, height, 0, -length / 2, 0) --左胴
    obj.drawpoly(0, -length / 2, 0, gap / 2, length / 2, 0, 0, length / 2, height, 0, -length / 2, 0) --右胴
end

if not use_auto_direction then
    draw_static_plane()
    return
end

local base_x = obj.getvalue("x")
local base_y = obj.getvalue("y")
local base_z = obj.getvalue("z")
local draw_x = base_x
local draw_y = base_y
local draw_z = base_z

obj.load("figure", "四角形", color, 3)
obj.effect()
obj.setoption("billboard", 0)
obj.ox = obj.ox - base_x
obj.oy = obj.oy - base_y
obj.oz = obj.oz - base_z

local search_start = obj.time
local search_end = obj.time
local time_step = 0.5 / obj.framerate
local vector_x = 0
local vector_y = 0
local vector_z = 0

while search_start > 0 or search_end < obj.totaltime do
    search_start = math.max(search_start - time_step, 0)
    search_end = math.min(search_end + time_step, obj.totaltime)

    local x = obj.getvalue("x", search_start) - obj.getvalue("x", search_end)
    local y = obj.getvalue("y", search_start) - obj.getvalue("y", search_end)
    local z = obj.getvalue("z", search_start) - obj.getvalue("z", search_end)
    local distance = math.sqrt(x * x + y * y + z * z)
    if distance >= 16 then
        vector_x = x / distance
        vector_y = y / distance
        vector_z = z / distance
        break
    end
end

local roll_angle = math.rad(rotation + 90)
local sin_roll = math.sin(roll_angle)
local cos_roll = math.cos(roll_angle)
local r00 = vector_x * vector_x * (1 - cos_roll) + cos_roll
local r01 = vector_x * vector_y * (1 - cos_roll) - vector_z * sin_roll
local r02 = vector_z * vector_x * (1 - cos_roll) + vector_y * sin_roll
local r10 = vector_x * vector_y * (1 - cos_roll) + vector_z * sin_roll
local r11 = vector_y * vector_y * (1 - cos_roll) + cos_roll
local r12 = vector_y * vector_z * (1 - cos_roll) - vector_x * sin_roll
local r20 = vector_z * vector_x * (1 - cos_roll) - vector_y * sin_roll
local r21 = vector_y * vector_z * (1 - cos_roll) + vector_x * sin_roll
local r22 = vector_z * vector_z * (1 - cos_roll) + cos_roll

local m00, m01, m02, m10, m11, m12, m20, m21, m22
if base_axis == 1 then
    local cos_axis = vector_x
    local sin_axis = math.sqrt(math.max(1 - cos_axis * cos_axis, 0))
    local yz_length = math.sqrt(vector_y * vector_y + vector_z * vector_z)
    local normalized_y = yz_length == 0 and 0 or vector_y / yz_length
    local normalized_z = yz_length == 0 and 0 or vector_z / yz_length

    m00 = -cos_axis
    m01 = -normalized_y * sin_axis
    m02 = -normalized_z * sin_axis
    m10 = -normalized_y * sin_axis
    m11 = normalized_z * normalized_z * (1 - cos_axis) + cos_axis
    m12 = -normalized_y * normalized_z * (1 - cos_axis)
    m20 = -normalized_z * sin_axis
    m21 = -normalized_y * normalized_z * (1 - cos_axis)
    m22 = normalized_y * normalized_y * (1 - cos_axis) + cos_axis
else
    local cos_axis = -vector_z
    local sin_axis = math.sqrt(math.max(1 - cos_axis * cos_axis, 0))
    local xy_length = math.sqrt(vector_x * vector_x + vector_y * vector_y)
    local normalized_x = xy_length == 0 and 0 or vector_x / xy_length
    local normalized_y = xy_length == 0 and 0 or vector_y / xy_length

    m00 = normalized_y * normalized_y * (1 - cos_axis) + cos_axis
    m01 = -normalized_x * normalized_y * (1 - cos_axis)
    m02 = -normalized_x * sin_axis
    m10 = -normalized_x * normalized_y * (1 - cos_axis)
    m11 = normalized_x * normalized_x * (1 - cos_axis) + cos_axis
    m12 = -normalized_y * sin_axis
    m20 = normalized_x * sin_axis
    m21 = normalized_y * sin_axis
    m22 = cos_axis
end

local function draw_auto_plane(x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4)
    local px1 = x1 * m00 + y1 * m01 + z1 * m02
    local py1 = x1 * m10 + y1 * m11 + z1 * m12
    local pz1 = x1 * m20 + y1 * m21 + z1 * m22
    local px2 = x2 * m00 + y2 * m01 + z2 * m02
    local py2 = x2 * m10 + y2 * m11 + z2 * m12
    local pz2 = x2 * m20 + y2 * m21 + z2 * m22
    local px3 = x3 * m00 + y3 * m01 + z3 * m02
    local py3 = x3 * m10 + y3 * m11 + z3 * m12
    local pz3 = x3 * m20 + y3 * m21 + z3 * m22
    local px4 = x4 * m00 + y4 * m01 + z4 * m02
    local py4 = x4 * m10 + y4 * m11 + z4 * m12
    local pz4 = x4 * m20 + y4 * m21 + z4 * m22
    obj.drawpoly(
        draw_x + px1 * r00 + py1 * r01 + pz1 * r02,
        draw_y + px1 * r10 + py1 * r11 + pz1 * r12,
        draw_z + px1 * r20 + py1 * r21 + pz1 * r22,
        draw_x + px2 * r00 + py2 * r01 + pz2 * r02,
        draw_y + px2 * r10 + py2 * r11 + pz2 * r12,
        draw_z + px2 * r20 + py2 * r21 + pz2 * r22,
        draw_x + px3 * r00 + py3 * r01 + pz3 * r02,
        draw_y + px3 * r10 + py3 * r11 + pz3 * r12,
        draw_z + px3 * r20 + py3 * r21 + pz3 * r22,
        draw_x + px4 * r00 + py4 * r01 + pz4 * r02,
        draw_y + px4 * r10 + py4 * r11 + pz4 * r12,
        draw_z + px4 * r20 + py4 * r21 + pz4 * r22,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1
    )
end

if base_axis == 1 then
    draw_auto_plane(length, 0, 0, 0, 0, -width - gap, 0, 0, -gap + 0.5, length, 0, 0) --左翼
    draw_auto_plane(length, 0, 0, 0, 0, width + gap, 0, 0, gap - 0.5, length, 0, 0) --右翼
    draw_auto_plane(length, 0, 0, 0, 0, -gap, 0, height, 0, length, 0, 0) --左胴
    draw_auto_plane(length, 0, 0, 0, 0, gap, 0, height, 0, length, 0, 0) --右胴
else
    draw_auto_plane(0, 0, length, 0, -width - gap, 0, 0, -gap + 0.5, 0, 0, 0, length) --左翼
    draw_auto_plane(0, 0, length, 0, width + gap, 0, 0, gap - 0.5, 0, 0, 0, length) --右翼
    draw_auto_plane(0, 0, length, 0, -gap, 0, -height, 0, 0, 0, 0, length) --左胴
    draw_auto_plane(0, 0, length, 0, gap, 0, -height, 0, 0, 0, 0, length) --右胴
end

obj.ox = obj.ox + base_x
obj.oy = obj.oy + base_y
obj.oz = obj.oz + base_z
