--label:${ROOT_CATEGORY}\画面効果
---$track:ライン幅
---min=1
---max=100
local l0 = 20
---$track:間隔補正
---min=0
---max=500
local track1 = 100
---$track:範囲拡大
---min=0
---max=500
local track2 = 100
--color:0xffffff
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
