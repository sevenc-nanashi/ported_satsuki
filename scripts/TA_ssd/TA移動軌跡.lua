--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:位置基準
---min=0
---max=100
---step=0.01
local position_rate = 50

---$track:字間
---min=0
---max=512
---step=0.1
local spacing = 34

---$check:始終透明
local hides_ends = false

---$check:時間基準
local uses_time_basis = false

obj.effect()

local track_position_rate
if uses_time_basis then
    track_position_rate = obj.time / obj.totaltime
else
    track_position_rate = position_rate / 100
end

local time = track_position_rate * (obj.totaltime + (obj.num - 1) * spacing / 100) - obj.index * spacing / 100

if time < 0 then
    time = 0
    obj.alpha = hides_ends and 0 or 1
elseif time > obj.totaltime then
    time = obj.totaltime
    obj.alpha = hides_ends and 0 or 1
end

obj.ox = 0
obj.oy = 0

local base_x = obj.getvalue("x")
local base_y = obj.getvalue("y")

obj.ox = obj.ox - base_x
obj.oy = obj.oy - base_y

local x0 = obj.getvalue("x", time)
local y0 = obj.getvalue("y", time)
local next_x = obj.getvalue("x", time + 1 / obj.framerate)
local next_y = obj.getvalue("y", time + 1 / obj.framerate)
local direction_x = x0 - next_x
local direction_y = y0 - next_y
local rotation = math.atan2(direction_x, direction_y) - math.pi / 2
local sin_rotation = math.sin(rotation)
local cos_rotation = math.cos(rotation)
local half_width_sin = sin_rotation * obj.w / 2
local half_width_cos = cos_rotation * obj.w / 2
local half_height_sin = sin_rotation * obj.h / 2
local half_height_cos = cos_rotation * obj.h / 2
obj.drawpoly(
    x0 - half_width_cos - half_height_sin,
    y0 + half_width_sin - half_height_cos,
    0,
    x0 + half_width_cos - half_height_sin,
    y0 - half_width_sin - half_height_cos,
    0,
    x0 + half_width_cos + half_height_sin,
    y0 - half_width_sin + half_height_cos,
    0,
    x0 - half_width_cos + half_height_sin,
    y0 + half_width_sin + half_height_cos,
    0,
    0,
    0,
    obj.w,
    0,
    obj.w,
    obj.h,
    0,
    obj.h
)
obj.setoption("focus_mode", "fixed_size")
