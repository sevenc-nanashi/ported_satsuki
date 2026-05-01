--label:${ROOT_CATEGORY}\切り替え効果
---$track:イン
---min=0
---max=10
---step=0.01
local track0 = 0.5
---$track:アウト
---min=0
---max=10
---step=0.01
local track1 = 0.5
--color:0xffffff
obj.load("figure", "背景", color, 100)
obj.alpha = 0
if obj.time < track0 then
	ta = (track0 - obj.time) / track0
	if track0 == 0 then
		ta = 1
	end
	obj.alpha = ta
end
if obj.time > obj.totaltime - track1 then
	tb = -(-track1 - obj.time + obj.totaltime) / track1
	if track1 == 0 then
		tb = 1
	end
	obj.alpha = tb
end
