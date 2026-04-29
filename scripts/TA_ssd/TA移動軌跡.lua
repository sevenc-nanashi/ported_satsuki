--track0:位置基準,0,100,50,0.01
--track1:字間,0,512,34
--track2:始終透明,0,1,0,1
--check0:時間基準,0

obj.effect()

if obj.check0 then
	otm_j = obj.time / obj.totaltime
else
	otm_j = obj.track0 / 100
end

t = otm_j * (obj.totaltime + (obj.num - 1) * obj.track1 / 100) - obj.index * obj.track1 / 100

if t < 0 then
	t = 0
	obj.alpha = 1 - obj.track2
elseif t > obj.totaltime then
	t = obj.totaltime
	obj.alpha = 1 - obj.track2
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
