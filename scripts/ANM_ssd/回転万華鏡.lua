--label:${ROOT_CATEGORY}\変形
---$track:回転
---min=-720
---max=720
local track0 = 0
---$track:分割数
---min=0
---max=24
---step=1
local n = 2
---$track:オフセット
---min=-720
---max=720
local track2 = 0
---$check:回転に連動
local rendo = 1

---$value:連動角度
local rendk = 45

local w = obj.w * 100 / obj.getvalue("zoom")
local h = obj.h * 100 / obj.getvalue("zoom")
local l = math.sqrt(w ^ 2 + h ^ 2)
local offsetr = math.rad(track2)
local r0 = math.rad(track0)

if rendk < 1 then
    rendk = 1
end

if rendo == 1 then
    n = math.abs(math.floor(track0 / rendk))
else
end

if n > 0 then
    r = math.rad(360 / n / 2)

    --領域拡大
    obj.setoption("drawtarget", "tempbuffer", l * 2, l * 2)
    obj.draw()

    obj.setoption("drawtarget", "framebuffer")
    obj.load("tempbuffer")

    obj.setoption("drawtarget", "tempbuffer", l * 2, l * 2)
    obj.setoption("blend", "alpha_add")

    --右回転部分
    for i = 0, n - 1 do
        x0 = math.cos(r + i * math.pi * 2 / n + offsetr) * l
        y0 = -math.sin(r + i * math.pi * 2 / n + offsetr) * l
        x1 = math.cos(r / 2 + i * math.pi * 2 / n + offsetr) * l
        y1 = -math.sin(r / 2 + i * math.pi * 2 / n + offsetr) * l
        x2 = math.cos(0 + i * math.pi * 2 / n + offsetr) * l
        y2 = -math.sin(0 + i * math.pi * 2 / n + offsetr) * l
        x3 = 0
        y3 = 0

        u0 = l + math.cos(r + r0 + offsetr) * l
        v0 = l - math.sin(r + r0 + offsetr) * l
        u1 = l + math.cos(r / 2 + r0 + offsetr) * l
        v1 = l - math.sin(r / 2 + r0 + offsetr) * l
        u2 = l + math.cos(0 + r0 + offsetr) * l
        v2 = l - math.sin(0 + r0 + offsetr) * l
        u3 = l
        v3 = l

        obj.drawpoly(x0, y0, 0, x1, y1, 0, x2, y2, 0, x3, y3, 0, u0, v0, u1, v1, u2, v2, u3, v3)
    end

    --反転部分
    for i = 0, n - 1 do
        x0 = math.cos(r + i * math.pi * 2 / n - offsetr) * l
        y0 = math.sin(r + i * math.pi * 2 / n - offsetr) * l
        x1 = math.cos(r / 2 + i * math.pi * 2 / n - offsetr) * l
        y1 = math.sin(r / 2 + i * math.pi * 2 / n - offsetr) * l
        x2 = math.cos(0 + i * math.pi * 2 / n - offsetr) * l
        y2 = math.sin(0 + i * math.pi * 2 / n - offsetr) * l
        x3 = 0
        y3 = 0

        u0 = l + math.cos(r + r0 - offsetr) * l
        v0 = l - math.sin(r + r0 - offsetr) * l
        u1 = l + math.cos(r / 2 + r0 - offsetr) * l
        v1 = l - math.sin(r / 2 + r0 - offsetr) * l
        u2 = l + math.cos(0 + r0 - offsetr) * l
        v2 = l - math.sin(0 + r0 - offsetr) * l
        u3 = l
        v3 = l

        obj.drawpoly(x0, y0, 0, x1, y1, 0, x2, y2, 0, x3, y3, 0, u0, v0, u1, v1, u2, v2, u3, v3)
    end

    obj.load("tempbuffer")
else
    obj.setoption("drawtarget", "tempbuffer", w, h)
    obj.draw()
    obj.load("tempbuffer")
end
