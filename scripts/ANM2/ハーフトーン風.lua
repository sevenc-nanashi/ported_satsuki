--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:サイズ
---min=5
---max=200
local size = 50
---$track:size閾値
---min=0
---max=100
local size_threshold = 50
---$track:透明閾値
---min=0
---max=100
local alpha_threshold = 50
---$track:回転
---min=-720
---max=720
local rr = 0
---$figure:図形
local fig = "円"

---$color:色
local col = nil

---$check:反転
local inverted = 0

---$check:サイズ二値化
local nt = 0

---$check:透明二値化
local nta = 0

---$value:個別拡大[%]
local ss = 100

---$check:文字
local tex = 0

---$string:文字(文字)
local text = "＋"

---$font:文字(font)
local font = "MS UI Gothic"

obj.effect("反転", "輝度反転", inverted)
local w = obj.w * 100 / obj.getvalue("zoom")
local h = obj.h * 100 / obj.getvalue("zoom")
local s = math.min(size, w, h)
local si = size_threshold / 100
local sia = alpha_threshold / 100
local use_source_color = col == nil or col < 0
local draw_col = use_source_color and 0xffffff or col

--[[pixelshader@halftone:
---$include "./shaders/halftone.hlsl"
]]
obj.copybuffer("cache:original", "object")
obj.setoption("drawtarget", "tempbuffer", s, s)
if tex < 1 then
	obj.load("figure", fig, draw_col, s)
else
	obj.setfont(font, s, 0, draw_col)
	obj.load("text", text)
end
obj.draw()
obj.copybuffer("cache:figure", "tempbuffer")
obj.copybuffer("object", "cache:original")
obj.setoption("drawtarget", "framebuffer")
obj.pixelshader("halftone", "object", { "object", "cache:figure" }, {
	s,
	si,
	sia,
	nt,
	nta,
	ss / 100,
	math.rad(rr),
	w,
	h,
	use_source_color and 1 or 0,
})
