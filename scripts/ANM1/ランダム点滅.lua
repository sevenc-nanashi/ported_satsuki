---$script_tips:画像等をランダムな間隔で点滅させます。
--label:${ROOT_CATEGORY}\アニメーション効果
---$tips:透明になる頻度を指定します。
---$track:しきい値
---min=0
---max=100
---step=1
local threshold = 50

---$tips:透明になった場合の透明度を指定します。
---$track:透明度
---min=0
---max=100
---step=0.1
local alpha_rate = 0

---$tips:透明になる時間間隔を指定します。
---:例えば、間隔=0.1の場合は0.1秒ごとに、しきい値に応じて点滅するかどうか判定されます。
---:小さな値だと、細かく点滅するイメージです。
---$track:間隔[s]
---min=0.01
---max=5
---step=0.01
local interval = 0.01

local random_value = obj.rand(0, 99, 1, math.floor(obj.time / interval))
if random_value >= threshold then
    obj.alpha = obj.alpha * alpha_rate / 100
end
