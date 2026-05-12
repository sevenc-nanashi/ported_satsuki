--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:時間[s]
---min=-10
---max=10
---step=0.01
local t = 2
---$track:間隔[s]
---min=0
---max=2
---step=0.01
local tb = 0.2
---$track:拡大率
---min=0
---max=1000
local track2 = 500
---$track:回数
---min=1
---max=10
---step=1
local track3 = 3
---$value:X距離
local x = 0

---$value:Y距離
local y = 0

---$value:Z距離
local z = 0

---$value:加減速[1-5]
local beki1 = 2

---$value:減衰[0-3]
local beki0 = 2

k = math.floor(track3)
s = track2 / 100 - 1

local indexes = {}
for i = 0, obj.num - 1 do
    indexes[i + 1] = i
end
for i = 0, obj.num - 1 do
    local dest = 0
    dest = rand(0, obj.num - 1, -obj.num, i + 1)
    local swap = indexes[i + 1]
    indexes[i + 1] = indexes[dest + 1]
    indexes[dest + 1] = swap
end
f = indexes[obj.index + 1] * tb

if t == 0 then
    return
elseif t > 0 then
    time = math.max(obj.time - f, 0)
else
    t = -t
    time = math.max(obj.totaltime - obj.time - f, 0)
end

l = t / k / 2
if time < t then
    r = math.sin(math.pi * time / l)
    if r > 0 then
        r = (r ^ beki1) * ((t - time) / t) ^ beki0
        obj.ox = obj.ox + x * r
        obj.oy = obj.oy + y * r
        obj.oz = obj.oz + z * r
        obj.zoom = obj.zoom * (1 + s * r)
    end
    if time < l / 4 then
        obj.alpha = 0
    elseif time < l / 2 then
        obj.alpha = 1 - (l / 4 - time + l / 4) / (l / 4)
    end
end
