--label:${ROOT_CATEGORY}\クリッピング
---$track:横幅
---min=5
---max=500
local lw = 50
---$track:高さ
---min=0
---max=1000
local lh = 50
---$track:オフセット
---min=-500
---max=500
local set = 0
---$check:上
local dir1 = true

---$check:下
local dir2 = true

---$check:左
local dir3 = false

---$check:右
local dir4 = false

local offs = set % lw * 2

--[[pixelshader@triangle_clipping:
---$include "./shaders/triangle_clipping.hlsl"
]]

obj.pixelshader("triangle_clipping", "object", "object", {
    lw,
    lh,
    offs,
    dir1 and 1 or 0,
    dir2 and 1 or 0,
    dir3 and 1 or 0,
    dir4 and 1 or 0,
})
