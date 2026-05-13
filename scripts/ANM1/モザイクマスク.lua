--label:${ROOT_CATEGORY}\クリッピング
---$track:サイズ
---min=5
---max=500
---step=1
local s = 50
---$track:閾値
---min=0
---max=100
---step=1
local siki = 50
---$track:乱数
---min=0
---max=100
---step=1
local ransu = 0

--[[pixelshader@mosaic_mask:
---$include "./shaders/mosaic_mask.hlsl"
]]

obj.pixelshader("mosaic_mask", "object", { "object", "random" }, {
    s,
    siki / 100,
    ransu,
})
