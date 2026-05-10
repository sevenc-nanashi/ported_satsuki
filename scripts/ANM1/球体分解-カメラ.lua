--label:${ROOT_CATEGORY}\変形
---$track:屈曲率
---min=10
---max=500
local k = 10
---$track:中心X
---min=-100
---max=100
local track1 = 0
---$track:中心Y
---min=-100
---max=100
local track2 = 0
---$check:反転
local __rename_me_check0 = false

--obj.setoption('antialias',0)
obj.effect("反転", "上下反転", "1")
obj.effect()
if __rename_me_check0 then
    obj.effect("反転", "左右反転", "1")
    obj.ry = 180
end
w = 28
h = 28
wd = w * k / 10
hd = h * k / 10
cx = math.floor(w / 2 * track1 / 100)
cy = math.floor(h / 2 * track2 / 100)
r = obj.w / w / math.sin(math.pi * 2 / wd)
for y = -h / 2 + cy, h / 2 + cy - 1 do
    y0 = -r * math.sin(math.pi * y / hd)
    r0 = r * math.cos(math.pi * y / hd)
    y1 = -r * math.sin(math.pi * (y + 1) / hd)
    r1 = r * math.cos(math.pi * (y + 1) / hd)
    v0 = obj.h * (y + h / 2 - cy) / h
    v1 = obj.h * (y + h / 2 - cy + 1) / h
    for x = -w / 2 + cx, w / 2 + cx - 1 do
        x0 = r0 * math.sin(math.pi * 2 * x / wd)
        x1 = r0 * math.sin(math.pi * 2 * (x + 1) / wd)
        x2 = r1 * math.sin(math.pi * 2 * (x + 1) / wd)
        x3 = r1 * math.sin(math.pi * 2 * x / wd)
        z0 = -r0 * math.cos(math.pi * 2 * x / wd) + r
        z1 = -r0 * math.cos(math.pi * 2 * (x + 1) / wd) + r
        z2 = -r1 * math.cos(math.pi * 2 * (x + 1) / wd) + r
        z3 = -r1 * math.cos(math.pi * 2 * x / wd) + r
        u0 = obj.w * (x + w / 2 - cx) / w
        u1 = obj.w * (x + w / 2 - cx + 1) / w
        obj.drawpoly(x0, y0, z0, x1, y0, z1, x2, y1, z2, x3, y1, z3, u0, v0, u1, v0, u1, v1, u0, v1)
    end
end
