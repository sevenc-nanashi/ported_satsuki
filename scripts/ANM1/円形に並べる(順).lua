--label:${ROOT_CATEGORY}\配置
---$track:個数
---min=1
---max=100
---step=1
local count = 10
---$track:距離
---min=0
---max=2000
---step=1
local distance = 200
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 0.3
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local interval = 0.3
---$check:外向き
local outward = false

obj.effect()
for i = 0, count - 1 do
    local fade
    if duration == 0 then
        return
    elseif duration < 0 then
        fade = (duration - (count - 1) * interval - obj.time + obj.totaltime + i * interval) / duration
    else
        fade = (duration - obj.time + i * interval) / duration
    end
    fade = math.min(1, math.max(fade, 0))
    local angle = 360 * i / count
    local x = math.sin(angle * math.pi / 180) * distance
    local y = -math.cos(angle * math.pi / 180) * distance
    local rz = 360 * i / count
    if outward then
        x = -x
        rz = -rz - 180
    end
    obj.draw(x, y, 0, 1, 1 - fade, 0, 0, rz)
end
