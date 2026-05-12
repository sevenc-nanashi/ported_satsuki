--label:${ROOT_CATEGORY}\抽出
---$track:しきい値
---min=0
---max=100
---step=1
local threshold = 50
---$track:間隔[s]
---min=0.01
---max=5
---step=0.01
local interval = 0.01

s = rand(0, 99, 0, math.floor(obj.time / interval))
if s >= threshold then
    obj.effect()
end
obj.draw()
