--label:${ROOT_CATEGORY}\アニメーション効果
---$track:しきい値
---min=0
---max=100
---step=1
local threshold = 50

---$track:透明度
---min=0
---max=100
---step=0.1
local alpha_rate = 0

---$track:間隔[s]
---min=0.01
---max=5
---step=0.01
local interval = 0.01

local random_value = obj.rand(0, 99, 1, math.floor(obj.time / interval))
if random_value >= threshold then
    obj.alpha = obj.alpha * alpha_rate / 100
end
