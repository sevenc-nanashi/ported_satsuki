--label:${ROOT_CATEGORY}\配置
---$track:X軸[%]
---min=-2000
---max=2000
---step=1
local track0 = 0
---$track:Y軸[%]
---min=-2000
---max=2000
---step=1
local track1 = 0

--trackgroup@track0,track1:軸

---$track:初速X
---min=-10000
---max=10000
---step=1
local vx = 0

---$track:初速Y
---min=-10000
---max=10000
---step=1
local vy = 0

--trackgroup@vx,vy:初速

---$track:加速度X
---min=-10000
---max=10000
---step=1
local vxa = 0

---$track:加速度Y
---min=-10000
---max=10000
---step=1
local vya = 0

--trackgroup@vxa,vya:加速度

obj.effect()

--加速度関連
local time = obj.time
local v_x = time * vx + vxa / 2 * time ^ 2
local v_y = time * vy + vya / 2 * time ^ 2
if vx * vxa < 0 and time >= -vx / vxa then
    v_x = -vx / vxa * vx + vxa / 2 * (-vx / vxa) ^ 2
end
if vy * vya < 0 and time >= -vy / vya then
    v_y = -vy / vya * vy + vya / 2 * (-vy / vya) ^ 2
end

--ループ
local X = obj.w * track0 / 100 + v_x
local Y = obj.h * track1 / 100 + v_y
local x = math.abs(X) % obj.w
local y = math.abs(Y) % obj.h
local w = obj.w / 2
local h = obj.h / 2
local vertices = {}

local function add_loop(xa, xb, ua, ub, xc, xd, uc, ud, ya, yb, va, vb, yc, yd, vc, vd)
    local x0, x1, u0, u1
    if X >= 0 then
        x0 = xa
        x1 = xb
        u0 = ua
        u1 = ub
    else
        x0 = xc
        x1 = xd
        u0 = uc
        u1 = ud
    end
    local y0, y2, v0, v1
    if Y >= 0 then
        y0 = ya
        y2 = yb
        v0 = va
        v1 = vb
    else
        y0 = yc
        y2 = yd
        v0 = vc
        v1 = vd
    end
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
        u0,
        v0,
        u1,
        v0,
        u1,
        v1,
        u0,
        v1,
    }
end

add_loop(x - w, w, 0, w * 2 - x, -w, w - x, x, w * 2, y - h, h, 0, h * 2 - y, -h, h - y, y, h * 2) --中央
add_loop(x - w, w, 0, w * 2 - x, -w, w - x, x, w * 2, -h, y - h, h * 2 - y, h * 2, h - y, h, 0, y) --上下
add_loop(-w, x - w, w * 2 - x, w * 2, w - x, w, 0, x, y - h, h, 0, h * 2 - y, -h, h - y, y, h * 2) --左右
add_loop(-w, x - w, w * 2 - x, w * 2, w - x, w, 0, x, -h, y - h, h * 2 - y, h * 2, h - y, h, 0, y) --斜め

obj.drawpoly(vertices)
