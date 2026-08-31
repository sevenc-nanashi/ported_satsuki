---$script_tips:格子状に画像をマスクします。
--label:${ROOT_CATEGORY}\クリッピング
---$tips:格子のサイズを指定します。
---$track:サイズ
---min=5
---max=500
---step=1
local size = 50
---$tips:格子の隙間部分の幅サイズを指定します。
---:トラックバーで移動させることにより、ワイプの代わりとしても使用できます。
---$track:隙間%
---min=0
---max=100
local gap = 10
---$tips:マスク部分を反転させます。
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
