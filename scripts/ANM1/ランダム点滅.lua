--label:${ROOT_CATEGORY}\アニメーション効果
---$track:しきい値
---min=0
---max=100
---step=1
local track0 = 50
---$track:透明度
---min=0
---max=100
local track1 = 0
---$track:間隔[s]
---min=0.01
---max=5
---step=0.01
local track2 = 0.01
a = rand(0, 99, 1, math.floor(obj.time / track2))
if a >= track0 then
    obj.alpha = obj.alpha * track1 / 100
end
