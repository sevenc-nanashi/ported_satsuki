--label:${ROOT_CATEGORY}\切り替え効果
---$track:方向
---min=-360
---max=360
---step=0.01
local track1 = 0
---$track:距離
---min=0
---max=20000
local l = 300
---$track:拡大率
---min=0
---max=800
local s = 100
---$track:縦横比[%]
---min=-100
---max=100
local as = 0

---$track:Z軸
---min=-20000
---max=20000
---step=1
local z = 0

---$track:X回転
---min=-720
---max=720
local rx = 0

---$track:Y回転
---min=-720
---max=720
local ry = 0

---$track:Z回転
---min=-720
---max=720
local rz = 0

--separator:加減速
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local ta = 1
---$track:加減速
---min=1
---max=5
---step=1
local beki = 2
---$select:モード
---減速=0
---加速=1
---S字=2
local mode = 0

--共通部分
local t
if ta == 0 then
    return
elseif ta < 0 then
    t = (ta - obj.time + obj.totaltime) / ta
else
    t = (ta - obj.time) / ta
end
t = math.max(0, t)

if mode < 1 then
    t = t ^ beki
elseif mode < 2 then
    t = 1 - (1 - t) ^ beki
else
    if t <= 0.5 then
        t = (2 * t) ^ beki / 2
    else
        t = (1 - (1 - (t - 0.5) * 2) ^ beki) / 2 + 0.5
    end
end

--フィルタ効果
local r = track1 + 90
obj.ox = obj.ox + l * math.cos(r * math.pi / 180) * t
obj.oy = obj.oy + l * math.sin(r * math.pi / 180) * t
obj.oz = obj.oz + z * t
obj.zoom = obj.zoom + (s / 100 - 1) * t
obj.aspect = obj.aspect + as / 100 * t
obj.rz = obj.rz + rz * t
obj.rx = obj.rx + rx * t
obj.ry = obj.ry + ry * t
