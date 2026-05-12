--label:${ROOT_CATEGORY}\カスタムオブジェクト\図形
---$track:ライン幅
---min=1
---max=100
---step=1
local l0 = 2
---$track:間隔
---min=1
---max=100
---step=1
local l1 = 10
---$track:X範囲
---min=0
---max=500
---step=1
local x_range = 100
---$track:Y範囲
---min=0
---max=500
---step=1
local y_range = 100
---$color:色
local color = 0x0000ff

---$check:横線のみ
local yoko = false

--[[pixelshader@grid:
---$include "./shaders/grid.hlsl"
]]

obj.load("figure", "四角形", color, 2)
local w = obj.screen_w * x_range / 100
local h = obj.screen_h * y_range / 100
local period = l0 + l1
local horizontal_only = yoko and 1 or 0

obj.setoption("drawtarget", "tempbuffer", w, h)
obj.drawpoly(-w / 2, -h / 2, 0, w / 2, -h / 2, 0, w / 2, h / 2, 0, -w / 2, h / 2, 0)
obj.pixelshader("grid", "tempbuffer", "tempbuffer", {
    l0,
    period,
    w,
    h,
    horizontal_only,
})
obj.load("tempbuffer")
