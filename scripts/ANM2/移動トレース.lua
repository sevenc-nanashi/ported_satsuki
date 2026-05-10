--label:${ROOT_CATEGORY}\アニメーション効果
---$track:個数
---min=1
---max=500
---step=1
local n = 10
---$track:時間差[s]
---min=0
---max=3
---step=0.01
local t = 0.1
---$track:終時間[s]
---min=0
---max=30
---step=0.01
local f = 0
obj.effect()
for i = 0, n - 1 do
    if obj.time <= t * i then
        x = 0
        y = 0
        z = 0
        alpha = 0
    elseif obj.time >= obj.totaltime - f + t * i then
        x = 0
        y = 0
        z = 0
        alpha = 0
    else
        x = obj.getvalue("x", obj.time - t * i) - obj.getvalue("x")
        y = obj.getvalue("y", obj.time - t * i) - obj.getvalue("y")
        z = obj.getvalue("z", obj.time - t * i) - obj.getvalue("z")
        alpha = 1
    end
    obj.draw(x, y, z, 1, alpha)
end
