---$script_tips:画像をRGBの要素に分解し、一つの要素だけを表示します。
---:なお、R、G、Bの3つのオブジェクトを用意し、Rの画像にGとBの画像を加算合成すると、分解前の画像と同じになります。
--label:${ROOT_CATEGORY}\光効果
---$tips:R,G,Bの各色を選択します。
---$select:RGB
---赤=0
---緑=1
---青=2
local channel = 0
---$tips:オブジェクトの透明度を指定します。
---:100%のときは、「色ずれ」フィルタで分解された場合と同じ透明度になります。
---$track:濃さ[%]
---min=0
---max=300
local blend = 100
---$check:飽和する
local saturate = false

--[[pixelshader@channel_extraction:
---$include "./shaders/channel_extraction.hlsl"
]]

obj.pixelshader("channel_extraction", "object", "object", {
    channel,
    blend / 100,
    saturate and 1 or 0,
})
