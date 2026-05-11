--label:${ROOT_CATEGORY}\クリッピング\削除済み
---$track:サイズ
---min=5
---max=500
local size = 50
---$track:隙間
---min=0
---max=100
local gap = 0
---$track:回転
---min=-360
---max=360
local angle = 0

--[[pixelshader@old_grid_mask:
---$include "./shaders/old_grid_mask.hlsl"
]]

obj.effect()

obj.pixelshader("old_grid_mask", "object", "object", {
    size,
    gap / 100,
    angle / 360 * math.pi,
})
