--label:${ROOT_CATEGORY}\変形
---$track:拡大率
---min=0
---max=8000
local track0 = 100
---$track:Z幅
---min=0
---max=1000
local track1 = 100
obj.effect()
s = track0 / 100
w, h = obj.getpixel()
for y = 0, h - 1 do
    for x = 0, w - 1 do
        col, a = obj.getpixel(x, y, "col")
        col, a_down = obj.getpixel(x, y + 1, "col")
        col, a_up = obj.getpixel(x, y - 1, "col")
        col, a_right = obj.getpixel(x + 1, y, "col")
        col, a_left = obj.getpixel(x - 1, y, "col")

        if a == 1 then
            X = (x - w / 2 + 0.5) * s
            Y = (y - h / 2 + 0.5) * s
            Z = 0 * s
            l = s / 2
            lz = s / 2 * track1 / 100
            ux = x + 0.5
            uy = y + 0.5

            obj.drawpoly(
                X - l,
                Y - l,
                Z - lz,
                X + l,
                Y - l,
                Z - lz,
                X + l,
                Y + l,
                Z - lz,
                X - l,
                Y + l,
                Z - lz,
                ux,
                uy,
                ux,
                uy,
                ux,
                uy,
                ux,
                uy
            )
            obj.drawpoly(
                X + l,
                Y - l,
                Z + lz,
                X - l,
                Y - l,
                Z + lz,
                X - l,
                Y + l,
                Z + lz,
                X + l,
                Y + l,
                Z + lz,
                ux,
                uy,
                ux,
                uy,
                ux,
                uy,
                ux,
                uy
            )

            if y == h - 1 or a_down ~= 1 then
                obj.drawpoly(
                    X - l,
                    Y + l,
                    Z - lz,
                    X + l,
                    Y + l,
                    Z - lz,
                    X + l,
                    Y + l,
                    Z + lz,
                    X - l,
                    Y + l,
                    Z + lz,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy
                )
            end

            if y == 0 or a_up ~= 1 then
                obj.drawpoly(
                    X + l,
                    Y - l,
                    Z - lz,
                    X - l,
                    Y - l,
                    Z - lz,
                    X - l,
                    Y - l,
                    Z + lz,
                    X + l,
                    Y - l,
                    Z + lz,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy
                )
            end

            if x == w - 1 or a_right ~= 1 then
                obj.drawpoly(
                    X + l,
                    Y - l,
                    Z - lz,
                    X + l,
                    Y - l,
                    Z + lz,
                    X + l,
                    Y + l,
                    Z + lz,
                    X + l,
                    Y + l,
                    Z - lz,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy
                )
            end

            if x == 0 or a_left ~= 1 then
                obj.drawpoly(
                    X - l,
                    Y - l,
                    Z + lz,
                    X - l,
                    Y - l,
                    Z - lz,
                    X - l,
                    Y + l,
                    Z - lz,
                    X - l,
                    Y + l,
                    Z + lz,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy,
                    ux,
                    uy
                )
            end
        end
    end
end
