--label:${ROOT_CATEGORY}\光効果
---$track:個数
---min=1
---max=500
---step=1
local n = 20
---$track:距離
---min=0
---max=10000
---step=1
local l = 300
---$track:速度
---min=1
---max=2000
---step=1
local speed = 100
---$track:出現範囲
---min=0
---max=2000
local sl = 0
---$track:ランダム速度[-%]
---min=0
---max=100
---step=1
local v_ran = 90

---$track:透過速度[%]
---min=0
---max=400
---step=1
local av = 100

---$track:拡大速度[%]
---min=-400
---max=400
---step=1
local sv = 0

---$check:ランダム回転
local rz_ran = 0

---$track:回転速度[度]
---min=-3600
---max=3600
---step=1
local rzv_ran = 0

---$track:ランダム拡大[-%]
---min=0
---max=100
---step=1
local s_ran = 0

---$check:終点で消える
local zero = 1

---$track:減速度
---min=1
---max=5
---step=1
local beki = 3

---$track:乱数
---min=0
---max=100
---step=1
local ran = 0

obj.effect()
local v = l / speed --距離を進むのにかかる時間
for i = 0, n - 1 do
    local t = math.max((v - obj.time) / v, 0)
    t = t ^ beki
    local x = (l * (1 - t) + obj.rand(0, sl, i, ran))
        * math.cos(obj.rand(0, 360, i, ran) * math.pi / 180)
        * obj.rand(100 - v_ran, 100, i, 1 + ran)
        / 100
    local y = (l * (1 - t) + obj.rand(0, sl, i, ran))
        * math.sin(obj.rand(0, 360, i, ran) * math.pi / 180)
        * obj.rand(100 - v_ran, 100, i, 1 + ran)
        / 100
    local zoom = 1 + sv / 100 * (1 - t) - obj.rand(0, s_ran, i, 10 + ran) / 100
    local alpha = 1 - av / 100 * (1 - t)
    local rz = obj.rand(0, 360, i, 6 + ran) * rz_ran + obj.rand(-rzv_ran / 2, rzv_ran / 2, i, 9 + ran) * obj.time
    if zero == 1 and t == 0 then
        alpha = 0
    end
    obj.draw(x, y, 0, zoom, alpha, 0, 0, rz)
end
