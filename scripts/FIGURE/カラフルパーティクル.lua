--label:${ROOT_CATEGORY}\パーティクル出力
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
---$figure:種類
local name = "円"

---$value:サイズ
local f_size = 100

---$value:ライン幅
local f_line = 4000

---$value:ランダム方向
local dir_ran = 30

---$value:ランダム速度[-%]
local v_ran = 0

---$value:透過速度[%]
local av = 100

---$value:拡大速度[%]
local sv = 0

---$value:ランダムZ角度
local rz_ran = 0

---$value:X軸ランダム
local x_ran = 0

---$value:Y軸ランダム
local y_ran = 0

---$value:ランダムZ回転
local rzv_ran = 0

---$value:ランダム拡大[-%]
local s_ran = 0

b = 1 / track0 --出力間隔(秒)
v = l / track2 --距離を進むのにかかる時間
dir = -track3 + 90 --出力方向
rxy_ran = 0 --ランダムXY角度[未使用]
z_ran = 0 --Z軸ランダム[未使用]
rxyv_ran = 0 --ランダムXY回転[未使用]
zi_ran = 0 --Z軸ランダム移動[未使用]

n = obj.totaltime / b
for i = 0, n - 1 do
    c = (obj.rand(0, 100, i, 100) - 50) / 100
    if c < 0 then
        c = math.floor(math.cos(math.pi * c) * 255) * 256 + math.floor(math.sin(math.pi * -c) * 255)
    else
        c = math.floor(math.cos(math.pi * c) * 255) * 256 + math.floor(math.sin(math.pi * c) * 255) * 65536
    end
    obj.load("figure", name, c, f_size, f_line)
    obj.effect()
    t = (v - obj.time + i * b) / v
    t = math.min(1, math.max(t, 0))
    direct = obj.rand(dir - dir_ran / 2, dir + dir_ran / 2, i, 0)
    x = l * math.cos(direct * math.pi / 180) * (1 - t) * obj.rand(100 - v_ran, 100, i, 12) / 100
        + obj.rand(-x_ran / 2, x_ran / 2, i, 1)
    y = l * math.sin(direct * math.pi / 180) * (1 - t) * obj.rand(100 - v_ran, 100, i, 12) / 100
        + obj.rand(-y_ran / 2, y_ran / 2, i, 2)
    z = obj.rand(-zi_ran / 2, zi_ran / 2, i, 11) * (1 - t) * obj.rand(100 - v_ran, 100, i, 12) / 100
        + obj.rand(-z_ran / 2, z_ran / 2, i, 3)
    zoom = 1 + sv / 100 * (1 - t) - obj.rand(0, s_ran, i, 10) / 100
    alpha = 1 - av / 100 * (1 - t)
    rx = obj.rand(-rxy_ran / 2, rxy_ran / 2, i, 4) + obj.rand(-rxyv_ran / 2, rxyv_ran / 2, i, 7) * obj.time
    ry = obj.rand(-rxy_ran / 2, rxy_ran / 2, i, 5) + obj.rand(-rxyv_ran / 2, rxyv_ran / 2, i, 8) * obj.time
    rz = obj.rand(-rz_ran / 2, rz_ran / 2, i, 6) + obj.rand(-rzv_ran / 2, rzv_ran / 2, i, 9) * obj.time
    if t == 0 or t == 1 then
        alpha = 0
    end
    obj.draw(x, y, z, zoom, alpha, rx, ry, rz)
end
