--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:制御X
---min=-1000
---max=1000
local control_x = 0
---$track:制御Y
---min=-1000
---max=1000
local control_y = -100
---$track:制御Z
---min=-1000
---max=1000
local control_z = 0
--trackgroup@control_x,control_y,control_z:制御点
---$check:補助線表示
local hojo = 1

---$color:補助線色
local color = 0xff0000

obj.effect()
--始点
local x0 = obj.getvalue("x", 0)
local y0 = obj.getvalue("y", 0)
local z0 = obj.getvalue("z", 0)
local xa = x0 - obj.getvalue("x", obj.time)
local ya = y0 - obj.getvalue("y", obj.time)
local za = z0 - obj.getvalue("z", obj.time)

--終点
local x1 = obj.getvalue("x", obj.totaltime)
local y1 = obj.getvalue("y", obj.totaltime)
local z1 = obj.getvalue("z", obj.totaltime)
local xb = x1 - obj.getvalue("x", obj.time)
local yb = y1 - obj.getvalue("y", obj.time)
local zb = z1 - obj.getvalue("z", obj.time)

--制御点
local sx = control_x + (xa + xb) / 2
local sy = control_y + (ya + yb) / 2
local sz = control_z + (za + zb) / 2

--座標の計算
local t = obj.time / obj.totaltime
obj.ox = ((1 - t) ^ 2) * xa + 2 * t * (1 - t) * sx + (t ^ 2) * xb
obj.oy = ((1 - t) ^ 2) * ya + 2 * t * (1 - t) * sy + (t ^ 2) * yb
obj.oz = ((1 - t) ^ 2) * za + 2 * t * (1 - t) * sz + (t ^ 2) * zb
obj.draw()

--補助線
if hojo == 1 then
    local a = 0.5
    obj.setoption("billboard", 3)
    obj.load("figure", "円", color, 50)
    obj.draw(xa, ya, za, 1, a)
    obj.draw(xb, yb, zb, 1, a)
    obj.setoption("billboard", 3)
    obj.load("figure", "四角形", color, 50)
    obj.draw(sx, sy, sz, 1, a)
    obj.setoption("billboard", 3)
    obj.load("figure", "円", color, 10)
    local n = 20
    for i = 0, n - 1 do
        t = i / n
        local x = ((1 - t) ^ 2) * xa + 2 * t * (1 - t) * sx + (t ^ 2) * xb
        local y = ((1 - t) ^ 2) * ya + 2 * t * (1 - t) * sy + (t ^ 2) * yb
        local z = ((1 - t) ^ 2) * za + 2 * t * (1 - t) * sz + (t ^ 2) * zb
        obj.draw(x, y, z, 1, a)
    end
end
