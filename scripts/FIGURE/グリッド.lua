--label:${ROOT_CATEGORY}\図形
---$script_tips:グリッドを作ります。
---$tips:グリッドのライン幅を指定します。
---$track:ライン幅
---min=1
---max=100
---step=1
local l0 = 2
---$tips:グリッドの間隔(px)を指定します
---$track:間隔
---min=1
---max=100
---step=1
local l1 = 10
---$tips:X軸方向、Y軸方向のグリッドの範囲を指定します。
---:画面サイズが100%となります。
---$track:X範囲
---min=0
---max=500
---step=1
local x_range = 100
---$tips:X軸方向、Y軸方向のグリッドの範囲を指定します。
---:画面サイズが100%となります。
---$track:Y範囲
---min=0
---max=500
---step=1
local y_range = 100
---$tips:グリッドの色を指定します。
---$color:色
local color = 0x0000ff

---$tips:チェックするとグリッドを横線のみの表示にします。
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
