---$script_tips:任意のフィルタ効果を、ランダムな間隔で適用させます。
--label:${ROOT_CATEGORY}\抽出
---$tips:フィルタ効果がかかる頻度を指定します。
---$track:しきい値
---min=0
---max=100
---step=1
local threshold = 50
---$tips:フィルタ効果がかかる時間間隔を指定します。
---:例えば、間隔=0.1の場合は0.1秒ごとに、しきい値に応じてフィルタ効果をかけるかどうか判定されます。
---:小さな値だと、細かくフィルタ効果がかかったり、かからなかったりするイメージです。
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
