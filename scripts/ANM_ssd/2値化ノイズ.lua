--label:${ROOT_CATEGORY}\抽出
---$track:しきい値
---min=0
---max=255
---step=1
local sikii = 128
---$track:周期XY
---min=0
---max=50
---step=0.01
local syk = 5
---$track:変化速度
---min=0
---max=50
local hks = 0
---$select:ノイズの種類
---Type1=0
---Type2=1
---Type3=2
---Type4=3
---Type5=4
---Type6=5
local nizs = 0
---$color:色
local col = 0xffffff

---$check:輝度保持
local kdhj = 0

--[[pixelshader@binary_noise
---$include "./shaders/binary_noise.hlsl"
]]

obj.effect("単色化", "color", 0xffffff, "輝度を保持する", kdhj)
obj.effect("ノイズ", "変化速度", hks, "周期X", syk, "周期Y", syk, "mode", 1, "type", nizs)
obj.pixelshader("binary_noise", "object", "object", {
    sikii / 255,
    RGB(col),
})
