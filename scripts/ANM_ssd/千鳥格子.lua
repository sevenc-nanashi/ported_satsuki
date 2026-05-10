--label:${ROOT_CATEGORY}\加工
---$track:サイズ
---min=10
---max=200
---step=1
local track0 = 50
---$track:横サイズ
---min=0
---max=4000
---step=1
local w = 800
---$track:縦サイズ
---min=0
---max=4000
---step=1
local h = 450
---$color:色1
local col1 = 0x000000

---$color:色2
local col2 = nil

local s = math.floor(track0 / 2) * 2 / 4

obj.setoption("drawtarget", "tempbuffer", w, h)

if col2 >= 0 then
    obj.load("figure", "四角形", col2, 2)
    obj.drawpoly(-w / 2, -h / 2, 0, w / 2, -h / 2, 0, w / 2, h / 2, 0, -w / 2, h / 2, 0)
end

--obj.setoption("blend","alpha_add")
obj.load("figure", "四角形", col1, 2)

local nx = math.floor(w / s / 4) + 1
local ny = math.floor(h / s / 4) + 1

for j = 0, ny - 1 do
    local y = -h / 2 + 4 * s / 2 + j * 4 * s
    for i = 0, nx - 1 do
        local x = -w / 2 + 4 * s / 2 + i * 4 * s
        obj.drawpoly(x - 2 * s, y - 2 * s, 0, x - s, y - 2 * s, 0, x - 2 * s, y - s, 0, x - 2 * s, y - 2 * s, 0)
        obj.drawpoly(x + 2 * s, y + 2 * s, 0, x + s, y + 2 * s, 0, x + 2 * s, y + s, 0, x + 2 * s, y + 2 * s, 0)
        obj.drawpoly(x, y - 2 * s, 0, x - 2 * s, y, 0, x - s, y, 0, x, y - s, 0)
        obj.drawpoly(x, y + 2 * s, 0, x + 2 * s, y, 0, x + s, y, 0, x, y + s, 0)
        obj.drawpoly(x, y - 2 * s, 0, x + 2 * s, y - 2 * s, 0, x + 2 * s, y, 0, x, y, 0)
    end
end

obj.load("tempbuffer")
