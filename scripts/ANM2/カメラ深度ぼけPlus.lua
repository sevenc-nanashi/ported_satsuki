--label:${ROOT_CATEGORY}\ぼかし
---$track:範囲
---min=0
---max=1000
---step=1
local range = 50
---$track:Z基準
---min=-20000
---max=20000
local base_z = 0
---$track:最大値
---min=0
---max=1000
---step=1
local max = 300
---$check:奥をぼかす
local oku = 1

---$check:手前をぼかす
local mae = 1

local l
if obj.z > base_z then
    l = (obj.z - base_z) / 10000 * oku
else
    l = (base_z - obj.z) / 10000 * mae
end
l = math.min(l * range, max)
obj.effect("ぼかし", "範囲", l)
