--label:${ROOT_CATEGORY}\配置
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
local movement_speed = 0
---$track:回転速度
---min=0
---max=1000
local rotation_speed = 0
---$track:X軸範囲[%]
---min=0
---max=1000
local wx = 100

---$track:Y軸範囲[%]
---min=0
---max=1000
local wy = 100

---$track:Z軸範囲[%]
---min=0
---max=1000
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

---$track:乱数
---min=0
---max=1000
---step=1
local ran = 0

---$check:ランダム固定
local fugo = 0

obj.effect()
local w = range / 100 --範囲
local v = movement_speed / 100 --移動速度
local r = rotation_speed / 100 --回転速度
for i = 0, n - 1 do
    local seed = (i + 1 + ran) * (1 - 2 * fugo)
    local x = (
            obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, seed, 0) / 2 * w
            + obj.rand(-100, 100, seed, 3) * obj.time * v
        )
        * wx
        / 100
    local y = (
            obj.rand(-obj.screen_h - obj.h, obj.screen_h + obj.h, seed, 1) / 2 * w
            + obj.rand(-100, 100, seed, 4) * obj.time * v
        )
        * wy
        / 100
    local z = (
            obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, seed, 2) / 2 * w
            + obj.rand(-100, 100, seed, 5) * obj.time * v
        )
        * wz
        / 100
    local s = obj.rand(100 - s_min, 100, seed, 6) / 100
    local rx = (obj.rand(0, 360, seed, 7) + obj.rand(-100, 100, seed, 10) * obj.time * r) * kx
    local ry = (obj.rand(0, 360, seed, 8) + obj.rand(-100, 100, seed, 11) * obj.time * r) * ky
    local rz = (obj.rand(0, 360, seed, 9) + obj.rand(-100, 100, seed, 12) * obj.time * r) * kz
    obj.draw(x, y, z, s, 1, rx, ry, rz)
end
