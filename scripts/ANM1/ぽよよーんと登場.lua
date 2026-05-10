--label:${ROOT_CATEGORY}\切り替え効果
---$track:時間
---min=-5
---max=5
---step=0.01
local track0 = 0.6
---$track:勢い
---min=0
---max=8
---step=0.01
local track1 = 2.0
---$track:揺れ幅
---min=0
---max=800
local track2 = 100
---$track:種類
---min=0
---max=4
---step=1
local track3 = 0
if track0 == 0 then
    return
elseif track0 < 0 then
    t = (track0 - obj.time + obj.totaltime) / track0
else
    t = (track0 - obj.time) / track0
end
if t >= 0 then
    n = track1 * 2 + 1
    if n <= 1 then
        t = t * t
    elseif t > 1 - 1 / n then
        t = 1 - (1 - t) * n
    else
        t = t * n / (n - 1)
        t = math.sin((t - 1) * (n - 1) * math.pi) * t * 0.4 / (1 + (1 - t) * 3)
    end
    if track3 == 0 then
        x = 1
        y = 1
    elseif track3 == 1 then
        x = 0
        y = 1
    elseif track3 == 2 then
        x = 1
        y = 0
    elseif track3 == 3 then
        x = -1
        y = 1
    else
        x = 1
        y = -1
    end
    xscale = math.max(0, 100 - t * x * track2)
    yscale = math.max(0, 100 - t * y * track2)
    obj.zoom = math.max(xscale, yscale) / 100
    if xscale > yscale then
        obj.aspect = yscale / xscale - 1
    else
        obj.aspect = 1 - xscale / yscale
    end
end
