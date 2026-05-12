--label:${ROOT_CATEGORY}\光効果
---$select:RGB
---赤=0
---緑=1
---青=2
local channel = 0
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
