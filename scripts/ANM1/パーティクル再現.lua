--label:${ROOT_CATEGORY}\配置
---$track:頻度
---min=0.1
---max=500
local track0 = 10
---$track:距離
---min=1
---max=10000
local l = 500
---$track:速度
---min=1
---max=2000
local track2 = 400
---$track:方向
---min=-360
---max=360
local track3 = 0
---$track:ランダム方向[度]
---min=0
---max=360
local dir_ran = 30

---$track:透過速度[%]
---min=0
---max=400
local av = 100

---$track:拡大速度[%]
---min=-400
---max=400
local sv = 0

---$track:ランダム速度[-%]
---min=0
---max=100
local v_ran = 0

---$track:ランダム拡大[-%]
---min=0
---max=100
local s_ran = 0

---$track:ランダムZ角度[度]
---min=0
---max=360
local rz_ran = 0

---$track:X軸ランダム
---min=0
---max=1000
local x_ran = 0

---$track:Y軸ランダム
---min=0
---max=1000
local y_ran = 0

---$track:Z軸ランダム
---min=0
---max=1000
local z_ran = 0

---$track:回転速度[度]
---min=-3600
---max=3600
local rv_ran = 0

---$check:XY回転あり
local rxy_ran = 0

---$track:Z軸ランダム方向
---min=0
---max=1000
local zi_ran = 0

obj.effect()
local b = 1 / track0 --出力間隔(秒)
local v = l / track2 --距離を進むのにかかる時間
local dir = -track3 + 90 --出力方向
local n = obj.totaltime / b
for i = 0, n - 1 do
    local t = (v - obj.time + i * b) / v
    t = math.min(1, math.max(t, 0))
    local direct = obj.rand(dir - dir_ran / 2, dir + dir_ran / 2, i, 0)
    local x = l * math.cos(direct * math.pi / 180) * (1 - t) * obj.rand(100 - v_ran, 100, i, 12) / 100
        + obj.rand(-x_ran / 2, x_ran / 2, i, 1)
    local y = l * math.sin(direct * math.pi / 180) * (1 - t) * obj.rand(100 - v_ran, 100, i, 12) / 100
        + obj.rand(-y_ran / 2, y_ran / 2, i, 2)
    local z = obj.rand(-zi_ran / 2, zi_ran / 2, i, 11) * (1 - t) * obj.rand(100 - v_ran, 100, i, 12) / 100
        + obj.rand(-z_ran / 2, z_ran / 2, i, 3)
    local zoom = 1 + sv / 100 * (1 - t) - obj.rand(0, s_ran, i, 10) / 100
    local alpha = 1 - av / 100 * (1 - t)
    local rx = rxy_ran * (obj.rand(0, 360, i, 4) + obj.rand(-rv_ran / 2, rv_ran / 2, i, 7) * obj.time)
    local ry = rxy_ran * (obj.rand(0, 360, i, 5) + obj.rand(-rv_ran / 2, rv_ran / 2, i, 8) * obj.time)
    local rz = obj.rand(-rz_ran / 2, rz_ran / 2, i, 6) + obj.rand(-rv_ran / 2, rv_ran / 2, i, 9) * obj.time
    if t == 0 or t == 1 then
        alpha = 0
    end
    obj.draw(x, y, z, zoom, alpha, rx, ry, rz)
end
