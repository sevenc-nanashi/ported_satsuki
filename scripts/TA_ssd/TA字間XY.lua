--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:X拡大率
---min=0
---max=1000
local track0 = 100
---$track:中心X
---min=-1000
---max=1000
local track1 = 0
---$track:Y拡大率
---min=0
---max=1000
local track2 = 100
---$track:中心Y
---min=-1000
---max=1000
local track3 = 0
---$check:自動調節
local __rename_me_check0 = false

if __rename_me_check0 then
	s = obj.getvalue("zoom") / 100
else
	s = 1
end
obj.ox = track1 + (obj.ox - track1) * track0 / 100 * s
obj.oy = track3 + (obj.oy - track3) * track2 / 100 * s

--自動調節は、「文字毎に個別オブジェクト」にチェックした状態で拡大率を変化させても、字間が自動で調節されるようにします。
