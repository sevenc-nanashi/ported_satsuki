--label:${ROOT_CATEGORY}\切り替え効果\TA
---$track:拡大(小)
---min=0
---max=800
local track0 = 120
---$track:拡大(大)
---min=0
---max=800
local track1 = 500
---$track:閾値(小)
---min=0
---max=100
---step=1
local track2 = 50
---$track:閾値(大)
---min=0
---max=100
---step=1
local track3 = 90
---$value:切替時間[s]
local kt = 0.01

t = math.floor(obj.time / kt)
l = rand(0, 100, 0, t)
if l > track3 then
	obj.zoom = obj.zoom * obj.rand(100, track1, 1, t) / 100
elseif l > track2 then
	obj.zoom = obj.zoom * obj.rand(100, track0, 2, t) / 100
end
