--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:基準layer
---min=1
---max=100
---step=1
local lay = 1
---$track:時間差[ms]
---min=-5000
---max=5000
local delay_ms = 0
---$track:X倍率
---min=-1000
---max=1000
---step=1
local xx = 100

---$track:Y倍率
---min=-1000
---max=1000
---step=1
local yy = 100

---$track:Z倍率
---min=-1000
---max=1000
---step=1
local zz = 100

---$track:拡大倍率
---min=0
---max=1000
---step=1
local ss = 100

local delay = delay_ms / 1000
obj.ox = obj.getvalue("layer" .. lay .. ".x", obj.time + delay) * xx / 100
obj.oy = obj.getvalue("layer" .. lay .. ".y", obj.time + delay) * yy / 100
obj.oz = obj.getvalue("layer" .. lay .. ".z", obj.time + delay) * zz / 100
obj.zoom = obj.getvalue("layer" .. lay .. ".zoom", obj.time + delay) / 100 * ss / 100
