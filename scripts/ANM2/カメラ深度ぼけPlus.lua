--label:${ROOT_CATEGORY}\ぼかし
---$track:範囲
---min=0
---max=1000
---step=1
local track0 = 50
---$track:Z基準
---min=-20000
---max=20000
local track1 = 0
---$track:最大値
---min=0
---max=1000
---step=1
local track2 = 300
---$check:奥をぼかす
local oku = 1

---$check:手前をぼかす
local mae = 1

if obj.z > track1 then
	l = (obj.z - track1) / 10000 * oku
else
	l = (track1 - obj.z) / 10000 * mae
end
l = math.min(l * track0, track2)
obj.effect("ぼかし", "範囲", l)
