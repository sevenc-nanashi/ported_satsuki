--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$script_tips:テキストを一文字毎にランダムに拡大します。
---:拡大(小)と拡大(大)の2つの拡大率がランダムにかかります。
---:細かく拡大縮小しつつも、ときどき大きく拡大するイメージです。
---$tips:小さく拡大する場合の拡大率を指定します。
---$track:拡大(小)
---min=0
---max=800
---step=1
local small_zoom = 120

---$tips:大きく拡大する場合の拡大率を指定します。
---$track:拡大(大)
---min=0
---max=800
---step=1
local large_zoom = 500

---$tips:小さく拡大する頻度を指定します。
---:まず、拡大(大)の判定がなされ、次に拡大(小)の判定がされます。
---:なので基本的に「閾値(小)＜閾値(大)」という関係になるように設定して下さい。
---$track:閾値(小)
---min=0
---max=100
---step=1
local small_threshold = 50

---$tips:大きく拡大する頻度を指定します。
---$track:閾値(大)
---min=0
---max=100
---step=1
local large_threshold = 90

---$tips:ランダムに切り替わる時間間隔(秒)を指定します。
---:例えば、切替時間=0.5と設定すると、0.5秒ごとに拡大するかどうか判定されます。
---$track:切替時間[s]
---min=0.01
---max=5
---step=0.01
local interval = 0.01

local interval_index = math.floor(obj.time / interval)
local threshold_roll = obj.rand(0, 100, 0, interval_index)

if threshold_roll > large_threshold then
    obj.zoom = obj.zoom * obj.rand(100, large_zoom, 1, interval_index) / 100
elseif threshold_roll > small_threshold then
    obj.zoom = obj.zoom * obj.rand(100, small_zoom, 2, interval_index) / 100
end
