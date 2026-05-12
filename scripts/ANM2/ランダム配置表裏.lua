--label:${ROOT_CATEGORY}\変形
---$track:個数
---min=0
---max=1000
---step=1
local n = 5
---$track:範囲
---min=0
---max=1000
local range = 100
---$track:移動速度
---min=0
---max=1000
local move_speed = 0
---$track:回転速度
---min=0
---max=1000
local rotation_speed = 0
---$check:裏反転
local reverse_back = 0
---$file:ファイル
local file = nil

---$track:X軸範囲[%]
---min=0
---max=100
local wx = 100

---$track:Y軸範囲[%]
---min=0
---max=100
local wy = 100

---$track:Z軸範囲[%]
---min=0
---max=100
local wz = 0

---$check:X回転
local kx = 0

---$check:Y回転
local ky = 0

---$check:Z回転
local kz = 1

---$track:拡大最小[-%]
---min=0
---max=100
local s_min = 0

local w = range / 100
local v = move_speed / 100
local r = rotation_speed / 100

local function random_transform(i)
    local x = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, -1 - i, 0) / 2 * w
        + obj.rand(-100, 100, -1 - i, 3) * obj.time * v
    )
        * wx
        / 100
    local y = (
        obj.rand(-obj.screen_h - obj.h, obj.screen_h + obj.h, -1 - i, 1) / 2 * w
        + obj.rand(-100, 100, -1 - i, 4) * obj.time * v
    )
        * wy
        / 100
    local z = (
        obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, -1 - i, 2) / 2 * w
        + obj.rand(-100, 100, -1 - i, 5) * obj.time * v
    )
        * wz
        / 100
    local zoom = obj.rand(100 - s_min, 100, -1 - i, 6) / 100
    local rx = (obj.rand(0, 360, -1 - i, 7) + obj.rand(-100, 100, -1 - i, 10) * obj.time * r) * kx
    local ry = (obj.rand(0, 360, -1 - i, 8) + obj.rand(-100, 100, -1 - i, 11) * obj.time * r) * ky
    local rz = (obj.rand(0, 360, -1 - i, 9) + obj.rand(-100, 100, -1 - i, 12) * obj.time * r) * kz

    return x, y, z, zoom, rx, ry, rz
end

obj.effect()
obj.setoption("culling", 1)
for i = 0, n - 1 do
    local x, y, z, zoom, rx, ry, rz = random_transform(i)
    obj.draw(x, y, z, zoom, 1, rx, ry, rz)
end

obj.load(file)
obj.effect("反転", "左右反転", reverse_back)
obj.effect()
for i = 0, n - 1 do
    local x, y, z, zoom, rx, ry, rz = random_transform(i)
    obj.draw(x, y, z, zoom, 1, rx, ry + 180, -rz - obj.getvalue("rz") * 2)
end
