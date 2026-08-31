---$script_tips:Z座標の数値によって「ぼかし」フィルタの強さが変わります。
---:カメラ制御の深度ぼけのようなものです。
--label:${ROOT_CATEGORY}\ぼかし
---$tips:ぼかしの強さを指定します。
---$track:範囲
---min=0
---max=1000
---step=1
local range = 50
---$tips:ぼかす基準座標を設定します。
---:この基準と同じ位置にある画像は、ぼかしの強さ=ゼロとなります。
---:基準から離れるほど、強くぼかしフィルタがかかります。
---$track:Z基準
---min=-20000
---max=20000
local base_z = 0
---$tips:ぼかしの範囲の最大値を設定します。
---$track:最大値
---min=0
---max=1000
---step=1
local max = 300
---$tips:チェックするとZ基準より奥にあるものに、ぼかしフィルタがかかります。
---$check:奥をぼかす
local oku = 1

---$tips:チェックするとZ基準より手前にあるものに、ぼかしフィルタがかかります。
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
