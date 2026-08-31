---$script_tips:モザイク状に画像をマスクします。
--label:${ROOT_CATEGORY}\クリッピング
---$tips:モザイクのサイズを指定します。
---$track:サイズ
---min=5
---max=500
---step=1
local s = 50
---$tips:マスク部分の割合を指定します。
---:トラックバーで移動させることにより、モザイク状のワイプの代わりとしても使用できます。
---$track:閾値
---min=0
---max=100
---step=1
local siki = 50
---$tips:各種のランダムに設定された結果を、別のランダム結果に変更します。
---:数値は適当な整数を入力すればよいので、好みのランダム結果が表示されるようにいろいろ試すとよいかもしれません。
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
