---$script_tips:ギザギザの円状に画像をマスクします。
--label:${ROOT_CATEGORY}\クリッピング
---$tips:一つの四角形のサイズを指定します。
---$track:サイズ
---min=5
---max=500
---step=1
local s = 50
---$tips:円の半径を指定します。
---$track:半径
---min=0
---max=2000
local r = 100
---$tips:円の中心座標を指定します。
---$track:中心X
---min=-2000
---max=2000
local param_cx = 0
---$tips:円の中心座標を指定します。
---$track:中心Y
---min=-2000
---max=2000
local param_cy = 0
--trackgroup@param_cx,param_cy:中心
---$tips:マスク部分を反転させます。
---$check:反転
local flip = false

--[[pixelshader@pixelated_circle_clipping:
---$include "./shaders/pixelated_circle_clipping.hlsl"
]]

local zoom = obj.getvalue("zoom")
obj.pixelshader("pixelated_circle_clipping", "object", "object", {
    s,
    r,
    param_cx,
    param_cy,
    obj.w / zoom * 100,
    obj.h / zoom * 100,
    flip and 1 or 0,
})
