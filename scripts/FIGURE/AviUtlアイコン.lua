--label:${ROOT_CATEGORY}\カスタムオブジェクト\図形
---$track:サイズ
---min=48
---max=2000
---step=1
local size = 48
---$color:色1
local color = 0x000000

---$color:色2
local color1 = 0xffffff

local s = size / 2 / 24
obj.setoption("drawtarget", "tempbuffer", size, size)
obj.load("figure", "四角形", color1, 2)
obj.drawpoly(-s * 24, -s * 24, 0, s * 24, -s * 24, 0, s * 24, s * 24, 0, -s * 24, s * 24, 0)

obj.load("figure", "四角形", color, 2)
obj.drawpoly(-s * 23, -s * 24, 0, s * 23, -s * 24, 0, s * 23, s * 24, 0, -s * 23, s * 24, 0)

obj.load("figure", "四角形", color1, 2)
local polygons = {}
table.insert(polygons, { -s * 17, -s * 24, 0, -s * 15, -s * 24, 0, -s * 15, s * 24, 0, -s * 17, s * 24, 0 })
table.insert(polygons, { s * 17, -s * 24, 0, s * 15, -s * 24, 0, s * 15, s * 24, 0, s * 17, s * 24, 0 })
table.insert(polygons, { -s * 16, -s * 15, 0, s * 16, -s * 15, 0, s * 16, -s * 13, 0, -s * 16, -s * 13, 0 })
table.insert(polygons, { -s * 16, s * 12, 0, s * 16, s * 12, 0, s * 16, s * 14, 0, -s * 16, s * 14, 0 })
for i = -1, 7 do
    table.insert(polygons, {
        -s * 21,
        -s * 21 + s * 6 * i,
        0,
        -s * 18,
        -s * 21 + s * 6 * i,
        0,
        -s * 18,
        -s * 17 + s * 6 * i,
        0,
        -s * 21,
        -s * 17 + s * 6 * i,
        0,
    })
end
for i = -1, 7 do
    table.insert(polygons, {
        s * 21,
        -s * 21 + s * 6 * i,
        0,
        s * 18,
        -s * 21 + s * 6 * i,
        0,
        s * 18,
        -s * 17 + s * 6 * i,
        0,
        s * 21,
        -s * 17 + s * 6 * i,
        0,
    })
end

local polygons2 = {}
for _, polygon in ipairs(polygons) do
    table.insert(polygons2, {
        polygon[1],
        polygon[2],
        polygon[3],
        polygon[4],
        polygon[5],
        polygon[6],
        polygon[7],
        polygon[8],
        polygon[9],
        polygon[10],
        polygon[11],
        polygon[12],
        0,
        0,
        0,
        1,
        1,
        1,
        1,
        0,
    })
end
obj.drawpoly(polygons2)
obj.load("tempbuffer")
