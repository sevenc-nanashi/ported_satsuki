--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:拡大(小)
---min=0
---max=800
---step=1
local small_zoom = 120

---$track:拡大(大)
---min=0
---max=800
---step=1
local large_zoom = 500

---$track:閾値(小)
---min=0
---max=100
---step=1
local small_threshold = 50

---$track:閾値(大)
---min=0
---max=100
---step=1
local large_threshold = 90

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
