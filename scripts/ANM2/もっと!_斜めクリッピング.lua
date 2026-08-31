---$script_tips:複数の斜めクリッピングを適用します。
--label:${ROOT_CATEGORY}\クリッピング
---$tips:斜めクリッピングの数を指定します。
---$track:個数
---min=0
---max=100
---step=1
local num = 8
---$tips:斜めクリッピングの幅を指定します。
---$track:幅
---min=0
---max=1000
---step=1
local width = 10
---$tips:斜めクリッピング全体の角度を変更します。
---$track:角度
---min=-720
---max=720
local angle = 0
---$tips:斜めクリッピングの中心座標を指定します。
---$track:中心X
---min=-1000
---max=1000
---step=0.1
local cx = 0
---$tips:斜めクリッピングの中心座標を指定します。
---$track:中心Y
---min=-1000
---max=1000
---step=0.1
local cy = 0
--trackgroup@cx,cy:中心

obj.setanchor("cx,cy", 0)

--[[pixelshader@extra_diagonal_clipping:
---$include "./shaders/extra_diagonal_clipping.hlsl"
]]

if num > 0 then
    obj.pixelshader("extra_diagonal_clipping", "object", "object", {
        cx,
        cy,
        angle / 180 * math.pi,
        width,
        num,
    })
end
