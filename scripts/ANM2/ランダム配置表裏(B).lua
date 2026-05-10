--label:${ROOT_CATEGORY}\変形
---$track:裏反転
---min=0
---max=1
---step=1
local track0 = 0
--file:
obj.effect()
for i = 0, n - 1 do
    x = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, -1 - i, 0) / 2 * w
        + obj.rand(-100, 100, -1 - i, 3) * obj.time * v
    )
        * wx
        / 100
    y = (
        obj.rand(-obj.screen_h - obj.h, obj.screen_h + obj.h, -1 - i, 1) / 2 * w
        + obj.rand(-100, 100, -1 - i, 4) * obj.time * v
    )
        * wy
        / 100
    z = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, -1 - i, 2) / 2 * w
        + obj.rand(-100, 100, -1 - i, 5) * obj.time * v
    )
        * wz
        / 100
    s = obj.rand(100 - s_min, 100, -1 - i, 6) / 100
    rx = (obj.rand(0, 360, -1 - i, 7) + obj.rand(-100, 100, -1 - i, 10) * obj.time * r) * kx
    ry = (obj.rand(0, 360, -1 - i, 8) + obj.rand(-100, 100, -1 - i, 11) * obj.time * r) * ky
    rz = (obj.rand(0, 360, -1 - i, 9) + obj.rand(-100, 100, -1 - i, 12) * obj.time * r) * kz
    obj.draw(x, y, z, s, 1, rx, ry, rz)
end

obj.setoption("culling", 1)
obj.load(file)
obj.effect("反転", "左右反転", track0)
obj.effect()
for i = 0, n - 1 do
    x = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, -1 - i, 0) / 2 * w
        + obj.rand(-100, 100, -1 - i, 3) * obj.time * v
    )
        * wx
        / 100
    y = (
        obj.rand(-obj.screen_h - obj.h, obj.screen_h + obj.h, -1 - i, 1) / 2 * w
        + obj.rand(-100, 100, -1 - i, 4) * obj.time * v
    )
        * wy
        / 100
    z = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, -1 - i, 2) / 2 * w
        + obj.rand(-100, 100, -1 - i, 5) * obj.time * v
    )
        * wz
        / 100
    s = obj.rand(100 - s_min, 100, -1 - i, 6) / 100
    rx = (obj.rand(0, 360, -1 - i, 7) + obj.rand(-100, 100, -1 - i, 10) * obj.time * r) * kx
    ry = (obj.rand(0, 360, -1 - i, 8) + obj.rand(-100, 100, -1 - i, 11) * obj.time * r) * ky
    rz = (obj.rand(0, 360, -1 - i, 9) + obj.rand(-100, 100, -1 - i, 12) * obj.time * r) * kz
    obj.draw(x, y, z, s, 1, rx, ry + 180, -rz - obj.getvalue("rz") * 2)
end
