--label:${ROOT_CATEGORY}\クリッピング\削除済み
---$track:サイズ
---min=5
---max=500
local track0 = 50
---$track:隙間
---min=0
---max=100
local track1 = 0
---$track:回転
---min=-360
---max=360
local track2 = 0
obj.effect()

s = obj.track0
d = s * obj.track1 / 100 / 2
r = obj.track2 / 180 * math.pi
ny = math.floor(obj.h / s / 2)
nx = math.floor(obj.w / s / 2)
w = obj.w / 2
h = obj.h / 2

for i = -ny, ny - 1 do
    y0 = s * i + d
    y1 = s * (i + 1) - d

    for j = -nx, nx - 1 do
        x0 = s * j + d
        x1 = s * (j + 1) - d

        lx0 = math.cos(math.atan2(y0, x0) + r) * math.sqrt(x0 ^ 2 + y0 ^ 2)
        lx1 = math.cos(math.atan2(y0, x1) + r) * math.sqrt(x1 ^ 2 + y0 ^ 2)
        lx2 = math.cos(math.atan2(y1, x1) + r) * math.sqrt(x1 ^ 2 + y1 ^ 2)
        lx3 = math.cos(math.atan2(y1, x0) + r) * math.sqrt(x0 ^ 2 + y1 ^ 2)

        ly0 = math.sin(math.atan2(y0, x0) + r) * math.sqrt(x0 ^ 2 + y0 ^ 2)
        ly1 = math.sin(math.atan2(y0, x1) + r) * math.sqrt(x1 ^ 2 + y0 ^ 2)
        ly2 = math.sin(math.atan2(y1, x1) + r) * math.sqrt(x1 ^ 2 + y1 ^ 2)
        ly3 = math.sin(math.atan2(y1, x0) + r) * math.sqrt(x0 ^ 2 + y1 ^ 2)

        obj.drawpoly(
            lx0,
            ly0,
            0,
            lx1,
            ly1,
            0,
            lx2,
            ly2,
            0,
            lx3,
            ly3,
            0,
            lx0 + w,
            ly0 + h,
            lx1 + w,
            ly1 + h,
            lx2 + w,
            ly2 + h,
            lx3 + w,
            ly3 + h
        )
    end
end
