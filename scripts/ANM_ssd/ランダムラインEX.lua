--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:個数
---min=1
---max=100
---step=1
local n = 3
---$track:幅
---min=0
---max=2000
---step=1
local d = 6
---$track:しきい値
---min=0
---max=255
---step=1
local sikii = 128
---$track:細かさ
---min=0
---max=50
---step=0.01
local koma = 12
---$track:横サイズ
---min=0
---max=4000
---step=1
local sw = 800

---$track:縦サイズ
---min=0
---max=4000
---step=1
local sh = 450

---$track:ランダム＋幅
---min=0
---max=2000
---step=1
local habar = 0

---$track:乱数
---min=0
---max=10000
---step=1
local rns = 0

---$color:色
local col = 0xffffff

--[[pixelshader@randomLineExApplyTexture:
---$include "shaders/random_line_ex_apply_texture.hlsl"
]]

local ln = math.sqrt(sw ^ 2 + sh ^ 2)

--ライン
obj.setoption("drawtarget", "tempbuffer", sw, sh)

obj.load("figure", "四角形", 0xffffff, 2)
local figure_w = obj.w
local figure_h = obj.h
local vertices = {}

for i = 0, n - 1 do
	local cx = obj.rand(-sw / 2, sw / 2, i + 0, rns)
	local cy = obj.rand(-sh / 2, sh / 2, i + 1, rns)
	local r = math.rad(obj.rand(0, 180, i + 2, rns))
	local dr = obj.rand(d, d + habar, i + 3, rns)
	local cos_r = math.cos(r)
	local sin_r = math.sin(r)
	local half_dr = dr / 2

	local x0 = cx + cos_r * ln - sin_r * half_dr
	local x1 = cx + cos_r * ln + sin_r * half_dr
	local x2 = cx - cos_r * ln + sin_r * half_dr
	local x3 = cx - cos_r * ln - sin_r * half_dr
	local y0 = cy + sin_r * ln + cos_r * half_dr
	local y1 = cy + sin_r * ln - cos_r * half_dr
	local y2 = cy - sin_r * ln - cos_r * half_dr
	local y3 = cy - sin_r * ln + cos_r * half_dr

	vertices[#vertices + 1] = {
		x0,
		y0,
		0,
		x1,
		y1,
		0,
		x2,
		y2,
		0,
		x3,
		y3,
		0,
		0,
		0,
		figure_w,
		0,
		figure_w,
		figure_h,
		0,
		figure_h,
	}
end
obj.drawpoly(vertices)

obj.load("tempbuffer")

--ノイズ
obj.effect("ノイズ", "周期X", koma, "周期Y", koma, "mode", 1)

obj.pixelshader("randomLineExApplyTexture", "object", "object", { sikii })

obj.effect("単色化", "color", col, "輝度を保持する", 0)
