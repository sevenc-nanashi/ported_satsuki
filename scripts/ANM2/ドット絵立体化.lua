--label:${ROOT_CATEGORY}\変形
---$track:拡大率
---min=0
---max=8000
local scale = 100
---$track:Z幅
---min=0
---max=1000
local z_length = 100
obj.effect()
local s = scale / 100
local polygons = {}
local userdata, w, h = obj.getpixeldata("object")
local ffi = require("ffi")
local userdata_ptr = ffi.cast("uint8_t*", userdata)
            local lz = s / 2 * z_length / 100
for y = 0, h - 1 do
    for x = 0, w - 1 do
        local a = userdata_ptr[(y * w + x) * 4 + 3] / 255
        local a_down = (y < h - 1 and userdata_ptr[((y + 1) * w + x) * 4 + 3] or 0) / 255
        local a_up = (y > 0 and userdata_ptr[((y - 1) * w + x) * 4 + 3] or 0) / 255
        local a_right = (x < w - 1 and userdata_ptr[(y * w + x + 1) * 4 + 3] or 0) / 255
        local a_left = (x > 0 and userdata_ptr[(y * w + x - 1) * 4 + 3] or 0) / 255

        if a == 1 then
            local X = (x - w / 2 + 0.5) * s
            local Y = (y - h / 2 + 0.5) * s
            local l = s / 2
            local ux = x + 0.5
            local uy = y + 0.5

            -- NOTE: ピクセルごとにポリゴンを作ると死ぬほど重いので、面だけ作るようにする
            -- table.insert(polygons, {
            --     X - l,
            --     Y - l,
            --     Z - lz,
            --     X + l,
            --     Y - l,
            --     Z - lz,
            --     X + l,
            --     Y + l,
            --     Z - lz,
            --     X - l,
            --     Y + l,
            --     Z - lz,
            --     ux,
            --     uy,
            --     ux,
            --     uy,
            --     ux,
            --     uy,
            --     ux,
            --     uy
            -- })
            -- table.insert(polygons, {
            --     X + l,
            --     Y - l,
            --     Z + lz,
            --     X - l,
            --     Y - l,
            --     Z + lz,
            --     X - l,
            --     Y + l,
            --     Z + lz,
            --     X + l,
            --     Y + l,
            --     Z + lz,
            --     ux,
            --     uy,
            --     ux,
            --     uy,
            --     ux,
            --     uy,
            --     ux,
            --     uy
            -- })

            if y == h - 1 or a_down ~= 1 then
                table.insert(polygons, {
                    X - l,
                    Y + l,
                    0 - lz,
                    X + l,
                    Y + l,
                    0 - lz,
                    X + l,
                    Y + l,
                    0 + lz,
                    X - l,
                    Y + l,
                    0 + lz,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy
                })
            end

            if y == 0 or a_up ~= 1 then
                table.insert(polygons, {
                    X + l,
                    Y - l,
                    0 - lz,
                    X - l,
                    Y - l,
                    0 - lz,
                    X - l,
                    Y - l,
                    0 + lz,
                    X + l,
                    Y - l,
                    0 + lz,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy
                })
            end

            if x == w - 1 or a_right ~= 1 then
                table.insert(polygons, {
                    X + l,
                    Y - l,
                    0 - lz,
                    X + l,
                    Y - l,
                    0 + lz,
                    X + l,
                    Y + l,
                    0 + lz,
                    X + l,
                    Y + l,
                    0 - lz,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy
                })
            end

            if x == 0 or a_left ~= 1 then
                table.insert(polygons, {
                    X - l,
                    Y - l,
                    0 + lz,
                    X - l,
                    Y - l,
                    0 - lz,
                    X - l,
                    Y + l,
                    0 - lz,
                    X - l,
                    Y + l,
                    0 + lz,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy
                })
            end
        end
    end
end

table.insert(polygons, {
    -w / 2 * s,
    -h / 2 * s,
    -lz,
    w / 2 * s,
    -h / 2 * s,
    -lz,
    w / 2 * s,
    h / 2 * s,
    -lz,
    -w / 2 * s,
    h / 2 * s,
    -lz,
    0,
    0,
    w,
    0,
    w,
    h,
    0,
    h
})
table.insert(polygons, {
    w / 2 * s,
    -h / 2 * s,
    lz,
    -w / 2 * s,
    -h / 2 * s,
    lz,
    -w / 2 * s,
    h / 2 * s,
    lz,
    w / 2 * s,
    h / 2 * s,
    lz,
    w,
    0,
    0,
    0,
    0,
    h,
    w,
    h
})


if #polygons > 0 then
    obj.drawpoly(polygons)
end
