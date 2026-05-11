--label:${ROOT_CATEGORY}\クリッピング
---$track:深さ
---min=1
---max=500
local depth = 60
---$track:開角度調整
---min=-360
---max=360
local open_angle = 10
---$track:角度調整
---min=-360
---max=360
local angle = 10
---$track:切込数
---min=2
---max=50
---step=1
local num_notches = 8

---$track:中心X
---min=-4000
---max=4000
---step=0.01
local cx = 0

---$track:中心Y
---min=-4000
---max=4000
---step=0.01
local cy = 0

--trackgroup@cx,cy:中心

---$check:新方式を使用
local use_new = true

--[[pixelshader@notch:
---$include "./shaders/notch.hlsl"
]]

if use_new then
    obj.setanchor("cx,cy", 1)
    obj.pixelshader("notch", "object", "object", {
        cx,
        cy,
        open_angle / 180 * math.pi,
        angle / 180 * math.pi,
        depth,
        num_notches,
    })
else
    local sizew = obj.w / obj.getvalue("zoom") * 100
    local sizeh = obj.h / obj.getvalue("zoom") * 100
    obj.setoption("dst", "tmp", sizew, sizeh)
    obj.effect("斜めクリッピング", "中心Y", depth, "角度", open_angle)
    obj.effect("斜めクリッピング", "中心Y", -depth, "角度", 180 - open_angle)
    obj.effect("斜めクリッピング", "角度", 270)
    local n = math.floor(num_notches / 2) * 2
    for i = 0, n - 1 do
        obj.draw(0, 0, 0, 1, 1, 0, 0, 360 / n * i)
    end
    obj.load("tempbuffer")
end
