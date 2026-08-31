--label:${ROOT_CATEGORY}\画面効果
---$script_tips:走査線を作ります。
---:本家「走査線」と異なり、走査線の範囲を広げたり、フィルタ効果をかけたりすることが出来ます。
---$tips:走査線の幅の大きさを指定します。
---$track:ライン幅
---min=1
---max=100
local l0 = 20
---$tips:走査線の空白部分の間隔を指定します。
---:数値は、間隔=ライン幅×間隔補正(%)となります
---$track:間隔補正
---min=0
---max=500
local track1 = 100
---$tips:走査線を描画する範囲を調整します。
---:100%で画面サイズとなります。
---$track:範囲拡大
---min=0
---max=500
local track2 = 100
---$tips:走査線の色を指定します。
---$color:色
local color = 0xffffff

obj.load("figure", "四角形", color, 2)

--[[pixelshader@scanline2:
---$include "./shaders/scanline2.hlsl"
]]

local w = obj.screen_w * track2 / 100
local h = obj.screen_h * track2 / 100
local l1 = l0 * track1 / 100

obj.setoption("drawtarget", "tempbuffer", w, h)
obj.drawpoly(-w / 2, -h / 2, 0, w / 2, -h / 2, 0, w / 2, h / 2, 0, -w / 2, h / 2, 0)
obj.pixelshader("scanline2", "tempbuffer", "tempbuffer", {
    l0,
    l0 + l1,
})
obj.load("tempbuffer")
