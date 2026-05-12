--label:${ROOT_CATEGORY}\変形
---$track:屈曲率
---min=10
---max=500
local k = 10
---$track:中心X
---min=-100
---max=100
local center_x = 0
---$track:中心Y
---min=-100
---max=100
local center_y = 0
--trackgroup@center_x,center_y:中心
---$check:反転
local invert = false

--obj.setoption('antialias',0)
obj.effect("反転", "上下反転", "1")
obj.effect()
if invert then
    obj.effect("反転", "左右反転", "1")
    obj.ry = 180
end
local w = 28
local h = 28
local wd = w * k / 10
local hd = h * k / 10
local cx = math.floor(w / 2 * center_x / 100)
local cy = math.floor(h / 2 * center_y / 100)
local r = obj.w / w / math.sin(math.pi * 2 / wd)
local polygons = {}
for y = -h / 2 + cy, h / 2 + cy - 1 do
    local y0 = -r * math.sin(math.pi * y / hd)
    local r0 = r * math.cos(math.pi * y / hd)
    local y1 = -r * math.sin(math.pi * (y + 1) / hd)
    local r1 = r * math.cos(math.pi * (y + 1) / hd)
    local v0 = obj.h * (y + h / 2 - cy) / h
    local v1 = obj.h * (y + h / 2 - cy + 1) / h
    for x = -w / 2 + cx, w / 2 + cx - 1 do
        local x0 = r0 * math.sin(math.pi * 2 * x / wd)
        local x1 = r0 * math.sin(math.pi * 2 * (x + 1) / wd)
        local x2 = r1 * math.sin(math.pi * 2 * (x + 1) / wd)
        local x3 = r1 * math.sin(math.pi * 2 * x / wd)
        local z0 = -r0 * math.cos(math.pi * 2 * x / wd) + r
        local z1 = -r0 * math.cos(math.pi * 2 * (x + 1) / wd) + r
        local z2 = -r1 * math.cos(math.pi * 2 * (x + 1) / wd) + r
        local z3 = -r1 * math.cos(math.pi * 2 * x / wd) + r
        local u0 = obj.w * (x + w / 2 - cx) / w
        local u1 = obj.w * (x + w / 2 - cx + 1) / w

        table.insert(polygons, {x0, y0, z0, x1, y0, z1, x2, y1, z2, x3, y1, z3, u0, v0, u1, v0, u1, v1, u0, v1})
    end
end
obj.drawpoly(polygons)
