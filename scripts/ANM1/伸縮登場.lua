--label:${ROOT_CATEGORY}\切り替え効果
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local track0 = 0.3
---$track:変化増%
---min=-100
---max=100
local v = 0
---$value:X軸1
local xa = 40

---$value:X軸2
local xb = 150

---$value:Y軸1
local ya = 150

---$value:Y軸2
local yb = 80

t = track0 / 3
xa = xa + (xa - 100) * v / 100
xb = xb + (xb - 100) * v / 100
ya = ya + (ya - 100) * v / 100
yb = yb + (yb - 100) * v / 100

if t == 0 then
    return
elseif t > 0 then
    if obj.time < t then
        ta = (t - obj.time) / t
        xscale = 0 + (xa - 0) * (1 - ta)
        yscale = 0 + (ya - 0) * (1 - ta)
    elseif obj.time < 2 * t then
        tb = (t - (obj.time - t)) / t
        xscale = xa + (xb - xa) * (1 - tb)
        yscale = ya + (yb - ya) * (1 - tb)
    elseif obj.time < 3 * t then
        tc = (t - (obj.time - 2 * t)) / t
        xscale = xb + (100 - xb) * (1 - tc)
        yscale = yb + (100 - yb) * (1 - tc)
    else
        xscale = 100
        yscale = 100
    end
else
    t = math.abs(t)
    if obj.time > obj.totaltime - 3 * t then
        if obj.time < obj.totaltime - 2 * t then
            tc = (t - (obj.time - obj.totaltime + 3 * t)) / t
            xscale = 100 + (xb - 100) * (1 - tc)
            yscale = 100 + (yb - 100) * (1 - tc)
        elseif obj.time < obj.totaltime - t then
            tb = (t - (obj.time - obj.totaltime + 2 * t)) / t
            xscale = xb + (xa - xb) * (1 - tb)
            yscale = yb + (ya - yb) * (1 - tb)
        else
            ta = (t - (obj.time - obj.totaltime + t)) / t
            xscale = xa + (0 - xa) * (1 - ta)
            yscale = ya + (0 - ya) * (1 - ta)
        end
    else
        xscale = 100
        yscale = 100
    end
end

obj.zoom = math.max(xscale, yscale) / 100
if xscale > yscale then
    obj.aspect = yscale / xscale - 1
else
    obj.aspect = 1 - xscale / yscale
end
