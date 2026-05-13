--label:${ROOT_CATEGORY}\クリッピング
---$track:サイズ
---min=5
---max=500
---step=1
local size = 50
---$track:隙間%
---min=0
---max=100
local gap = 10
---$check:反転
local hanten = 0

--[[pixelshader@grid_mask:
---$include "./shaders/grid_mask.hlsl"
]]

obj.pixelshader("grid_mask", "object", "object", {
    size,
    gap / 100,
    hanten,
})
