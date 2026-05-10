--label:${ROOT_CATEGORY}\変形
---$track:裏反転
---min=0
---max=1
---step=1
local track0 = 0
--file:
obj.effect()
n = obj.totaltime / b
for i = 0, n - 1 do
    t = (v - obj.time + i * b) / v
    t = math.min(1, math.max(t, 0))
    direct = obj.rand(dir - dir_ran / 2, dir + dir_ran / 2, i, 0)
    x = l * math.cos(direct * math.pi / 180) * (1 - t) * obj.rand(100 - v_ran, 100, -1 - i, 12) / 100
        + obj.rand(-x_ran / 2, x_ran / 2, -1 - i, 1)
    y = l * math.sin(direct * math.pi / 180) * (1 - t) * obj.rand(100 - v_ran, 100, -1 - i, 12) / 100
        + obj.rand(-y_ran / 2, y_ran / 2, -1 - i, 2)
    z = obj.rand(-zi_ran / 2, zi_ran / 2, -1 - i, 11) * (1 - t) * obj.rand(100 - v_ran, 100, -1 - i, 12) / 100
        + obj.rand(-z_ran / 2, z_ran / 2, -1 - i, 3)
    zoom = 1 + sv / 100 * (1 - t) - obj.rand(0, s_ran, -1 - i, 10) / 100
    alpha = 1 - av / 100 * (1 - t)
    rx = rxy_ran * (obj.rand(0, 360, -1 - i, 4) + obj.rand(-rv_ran / 2, rv_ran / 2, -1 - i, 7) * obj.time)
    ry = rxy_ran * (obj.rand(0, 360, -1 - i, 5) + obj.rand(-rv_ran / 2, rv_ran / 2, -1 - i, 8) * obj.time)
    rz = obj.rand(-rz_ran / 2, rz_ran / 2, -1 - i, 6) + obj.rand(-rv_ran / 2, rv_ran / 2, -1 - i, 9) * obj.time
    if t == 0 or t == 1 then
        alpha = 0
    end
    obj.draw(x, y, z, zoom, alpha, rx, ry, rz)
end

obj.setoption("culling", 1)
obj.load(file)
obj.effect("反転", "左右反転", track0)
obj.effect()
for i = 0, n - 1 do
    t = (v - obj.time + i * b) / v
    t = math.min(1, math.max(t, 0))
    direct = obj.rand(dir - dir_ran / 2, dir + dir_ran / 2, i, 0)
    x = l * math.cos(direct * math.pi / 180) * (1 - t) * obj.rand(100 - v_ran, 100, -1 - i, 12) / 100
        + obj.rand(-x_ran / 2, x_ran / 2, -1 - i, 1)
    y = l * math.sin(direct * math.pi / 180) * (1 - t) * obj.rand(100 - v_ran, 100, -1 - i, 12) / 100
        + obj.rand(-y_ran / 2, y_ran / 2, -1 - i, 2)
    z = obj.rand(-zi_ran / 2, zi_ran / 2, -1 - i, 11) * (1 - t) * obj.rand(100 - v_ran, 100, -1 - i, 12) / 100
        + obj.rand(-z_ran / 2, z_ran / 2, -1 - i, 3)
    zoom = 1 + sv / 100 * (1 - t) - obj.rand(0, s_ran, -1 - i, 10) / 100
    alpha = 1 - av / 100 * (1 - t)
    rx = rxy_ran * (obj.rand(0, 360, -1 - i, 4) + obj.rand(-rv_ran / 2, rv_ran / 2, -1 - i, 7) * obj.time)
    ry = rxy_ran * (obj.rand(0, 360, -1 - i, 5) + obj.rand(-rv_ran / 2, rv_ran / 2, -1 - i, 8) * obj.time)
    rz = obj.rand(-rz_ran / 2, rz_ran / 2, -1 - i, 6) + obj.rand(-rv_ran / 2, rv_ran / 2, -1 - i, 9) * obj.time
    if t == 0 or t == 1 then
        alpha = 0
    end
    obj.draw(x, y, z, zoom, alpha, rx, ry + 180, -rz - obj.getvalue("rz") * 2)
end
