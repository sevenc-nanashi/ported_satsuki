--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:X間隔
---min=-1000
---max=1000
local track0 = 100
---$track:Y間隔
---min=-1000
---max=1000
local track1 = 100
---$track:X個数
---min=1
---max=100
---step=1
local nx = 5
---$track:Y個数
---min=1
---max=100
---step=1
local ny = 3
obj.effect()
local gx = track0 / 100 - (1 - math.cos(math.pi * 30 / 180))
local gy = track1 / 100 - (1 - math.sin(math.pi * 30 / 180) * 1.5)
local w = obj.w
local h = obj.h
local base_x = -(nx + (nx - 1) * (gx - 1)) * w / 2
local base_y = -(ny + (ny - 1) * (gy - 1)) * h / 2
local vertices = {}

for j = 0, ny - 1 do
    local y0 = base_y + h * j * gy
    local y2 = y0 + h
    local row_shift = 0
    if j % 2 == 0 then
        row_shift = w / 2 * gx
    end

    for i = 0, nx - 1 do
        local x0 = base_x + w * i * gx + row_shift
        local x1 = x0 + w
        vertices[#vertices + 1] = {
            x0,
            y0,
            0,
            x1,
            y0,
            0,
            x1,
            y2,
            0,
            x0,
            y2,
            0,
            0,
            0,
            w,
            0,
            w,
            h,
            0,
            h,
        }
    end
end

obj.drawpoly(vertices)
