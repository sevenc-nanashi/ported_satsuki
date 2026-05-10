--label:${ROOT_CATEGORY}\切り替え効果\TA
---$track:時間[s]
---min=-10
---max=10
---step=0.01
local t = 3
---$track:角度
---min=-720
---max=720
local rz = 360
---$track:加減速
---min=1
---max=5
---step=1
local track2 = 2
---$check:文字回転
local k = 1

beki = math.floor(track2)
mode = (obj.num - 1) / 2 - math.abs((obj.num - 1) / 2 - obj.index)
ta = t * (1 - mode / obj.num)
tb = t / obj.num
if t == 0 then
    return
elseif t < 0 then
    i = (ta - obj.time + obj.totaltime + tb * mode) / ta
else
    i = (ta - obj.time + tb * mode) / ta
end
if i > 0 then
    if i > 1 then
        i = 1
    end
    i = i ^ beki
    x = obj.ox * (1 - i)
    y = obj.oy
    r = rz * math.pi / 180 * i
    obj.ox = x * math.cos(r) - y * math.sin(r)
    obj.oy = x * math.sin(r) + y * math.cos(r)
    obj.rz = obj.rz + math.deg(r) * k
end
