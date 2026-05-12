--label:${ROOT_CATEGORY}\配置
---$track:ループ[s]
---min=0
---max=20
---step=0.01
local duration = 1
---$track:待機[s]
---min=0
---max=20
---step=0.01
local initial_wait = 0.2

---$track:開始位置[s]
---min=0
---max=20
---step=0.01
local f = 0

---$check:待機2回
local wait = 0
---$track:X
---min=-1000
---max=1000
local x = 0

---$track:Y
---min=-1000
---max=1000
local y = 0

---$track:Z
---min=-1000
---max=1000
local z = 0
--trackgroup@x,y,z:移動

---$track:X軸回転
---min=-3600
---max=3600
local rx = 0

---$track:Y軸回転
---min=-3600
---max=3600
local ry = 0

---$track:Z軸回転
---min=-3600
---max=3600
local rz = 0

--trackgroup@rx,ry,rz:回転
---$track:拡大+%
---min=-100
---max=800
local scale_offset = 50
---$track:縦横比
---min=-100
---max=100
local aspect_offset = 0

local w = math.min(initial_wait, duration)
local r = 0
local time0 = (math.max(obj.time - f, 0)) % duration
if wait == 0 then
    if time0 <= duration - w and time0 ~= 0 then
        r = math.sin(math.pi * time0 / (duration - w))
    end
else
    local time1 = (math.max(obj.time - f, 0)) % (2 * duration)
    if time1 <= duration - w then
        r = math.sin(math.pi * time0 / (duration - w) / 2)
    elseif time1 <= duration then
        r = 1
    elseif time1 <= 2 * duration - w then
        r = 1 - math.sin(math.pi * time0 / (duration - w) / 2)
    end
end
obj.ox = obj.ox + x * r
obj.oy = obj.oy + y * r
obj.oz = obj.oz + z * r
obj.zoom = obj.zoom * (1 + scale_offset / 100 * r)
obj.aspect = obj.aspect + aspect_offset / 100 * r
obj.rx = obj.rx + rx * r
obj.ry = obj.ry + ry * r
obj.rz = obj.rz + rz * r
