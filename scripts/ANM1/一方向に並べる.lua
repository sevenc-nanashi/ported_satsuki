--label:${ROOT_CATEGORY}\配置
---$track:個数
---min=1
---max=200
---step=1
local n = 5
---$track:間隔
---min=-1000
---max=1000
local l = 50
---$track:角度
---min=-720
---max=720
local angle = 0
---$select:回転軸
---X軸=0
---Y軸=1
---Z軸=2
local rotation_axis = 0
---$check:双方向
local dual_side = false

obj.effect()
local r = angle + 90
local w, h = obj.w, obj.h
local aa = 0
local bb = n - 1
if dual_side then
    aa = -n + 1
    bb = n - 1
end
local polygons = {}
for i = aa, bb do
    local sin = math.sin(r * math.pi / 180) * l * i
    local cos = -math.cos(r * math.pi / 180) * l * i
    local cx, cy, z
    if rotation_axis < 1 then
        cx = sin
        cy = cos
        z = 0
    elseif rotation_axis < 2 then
        cx = sin
        cy = 0
        z = cos
    else
        cx = 0
        cy = cos
        z = sin
    end
    local x0, x1 = cx - w / 2, cx + w / 2
    local y0, y2 = cy - h / 2, cy + h / 2
    table.insert(polygons, { x0, y0, z, x1, y0, z, x1, y2, z, x0, y2, z, 0, 0, obj.w, 0, obj.w, obj.h, 0, obj.h })
end
obj.drawpoly(polygons)
