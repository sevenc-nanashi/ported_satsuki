--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:位置基準
---min=0
---max=100
---step=0.01
local track0 = 50
---$track:字間
---min=0
---max=512
local track1 = 34
---$track:始終透明
---min=0
---max=1
---step=1
local track2 = 0
---$check:時間基準
local __rename_me_check0 = false

obj.effect()

if __rename_me_check0 then
    otm_j = obj.time / obj.totaltime
else
    otm_j = track0 / 100
end

t = otm_j * (obj.totaltime + (obj.num - 1) * track1 / 100) - obj.index * track1 / 100

if t < 0 then
    t = 0
    obj.alpha = 1 - track2
elseif t > obj.totaltime then
    t = obj.totaltime
    obj.alpha = 1 - track2
end

obj.ox = 0
obj.oy = 0

base_x = obj.getvalue("x")
base_y = obj.getvalue("y")

obj.ox = obj.ox - base_x
obj.oy = obj.oy - base_y

x0 = obj.getvalue("x", t)
y0 = obj.getvalue("y", t)
x = x0 - obj.getvalue("x", t + 1 / obj.framerate)
y = y0 - obj.getvalue("y", t + 1 / obj.framerate)
r = math.atan2(x, y) - math.pi / 2
sx = math.sin(r) * obj.w / 2
cx = math.cos(r) * obj.w / 2
sy = math.sin(r) * obj.h / 2
cy = math.cos(r) * obj.h / 2
obj.drawpoly(
    x0 - cx - sy,
    y0 + sx - cy,
    0,
    x0 + cx - sy,
    y0 - sx - cy,
    0,
    x0 + cx + sy,
    y0 - sx + cy,
    0,
    x0 - cx + sy,
    y0 + sx + cy,
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
