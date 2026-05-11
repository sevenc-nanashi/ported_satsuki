--label:${ROOT_CATEGORY}\クリッピング
---$track:時間経過
---min=0
---max=100
local elapsed = 0
---$track:サイズ
---min=0
---max=2000
local fsize = 100
---$track:ライン幅
---min=0
---max=4000
---step=1
local line = 4000
---$figure:図形
local name = "四角形"

---$check:反転
local flip = 0

---$value:座標
local pos = { -100, -100, 100, -100, 100, 100, -100, 100 }

---$track:分割数
---min=1
---max=50
---step=1
local div = 8

if obj.getoption("track_mode", "elapsed") == 0 then
    obj.setanchor("pos", 4, "loop")
else
    obj.setanchor("pos", 8, "loop", "inout")
    local s = elapsed / 100
    for i = 1, 8 do
        pos[i] = pos[i] + (pos[i + 8] - pos[i]) * s
    end
end
if div < 1 then
    div = 1
end
if div > 50 then
    div = 50
end

--[[pixelshader@transform_mask:
---$include "./shaders/transform_mask.hlsl"
]]

-- 仮想バッファの解像度を決める
local w = obj.w
local h = obj.h
obj.setoption("drawtarget", "tempbuffer", w, h)
obj.draw()
obj.copybuffer("cache:original", "tempbuffer")
obj.clearbuffer("tempbuffer")
obj.load("figure", name, 0xffffff, fsize, line)

-- 変形させて描画する
w, h = obj.getpixel()
local px0 = pos[1]
local py0 = pos[2]
local px1 = pos[3]
local py1 = pos[4]
local px2 = pos[5]
local py2 = pos[6]
local px3 = pos[7]
local py3 = pos[8]
local sx1 = px0
local sy1 = py0
local ex1 = px1
local ey1 = py1
local v1 = 0
for y = 1, div do
    local sx0 = sx1
    local sy0 = sy1
    local ex0 = ex1
    local ey0 = ey1
    sx1 = px0 + (px3 - px0) * y / div
    sy1 = py0 + (py3 - py0) * y / div
    ex1 = px1 + (px2 - px1) * y / div
    ey1 = py1 + (py2 - py1) * y / div
    local v0 = v1
    v1 = y * h / div
    local x1 = sx0
    local y1 = sy0
    local x2 = sx1
    local y2 = sy1
    local u1 = 0
    for x = 1, div do
        local x0 = x1
        local y0 = y1
        x1 = sx0 + (ex0 - sx0) * x / div
        y1 = sy0 + (ey0 - sy0) * x / div
        local x3 = x2
        local y3 = y2
        x2 = sx1 + (ex1 - sx1) * x / div
        y2 = sy1 + (ey1 - sy1) * x / div
        local u0 = u1
        u1 = x * w / div
        obj.drawpoly(x0, y0, 0, x1, y1, 0, x2, y2, 0, x3, y3, 0, u0, v0, u1, v0, u1, v1, u0, v1)
    end
end
obj.copybuffer("object", "cache:original")
obj.pixelshader("transform_mask", "object", { "cache:original", "tempbuffer" }, { flip })
-- obj.cx = obj.cx - sx
-- obj.cy = obj.cy - sy
