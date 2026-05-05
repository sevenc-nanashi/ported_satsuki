--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:時間
---min=-5
---max=5
---step=0.01
local t = -1

---$track:走査幅
---min=1
---max=100
local l = 2

---$track:白線の幅
---min=0
---max=100
---step=1
local senhaba = 2

--group:縁
---$check:縁あり
local edg = 1

---$check:縁アス比
local as = 1

---$track:縁調整%
---min=100
---max=800
local ensize = 110

--group:走査線

---$check:走査線あり
local sou = 1

---$track:走査線強さ[%]
---min=0
---max=100
---step=1
local sou_alp = 50

---$color:走査線色
local sou_col = 0x000000

--group:影

---$check:影あり
local kage = 1

---$track:影速度
---min=-1000
---max=1000
local kage_v = 100

---$track:影の幅
---min=0
---max=500
---step=1
local kage_haba = 80

--[[pixelshader@tv_on_off_scanline:
---$include "./shaders/tv_on_off_scanline.hlsl"
]]

zoom = obj.getvalue("zoom") / 100
h = obj.h / zoom
w = obj.w / zoom

if t == 0 then
	i = 0
elseif t < 0 then
	i = (t + obj.totaltime - obj.time) / t
else
	i = (t - obj.time) / t
end
i = math.max(i, 0)

if i < 6 / 9 then
	obj.setoption("drawtarget", "tempbuffer", w, h)
	obj.draw()

	--走査線の描画
	if sou == 1 then
		local sou_r = math.floor(sou_col / 0x10000) % 0x100 / 255
		local sou_g = math.floor(sou_col / 0x100) % 0x100 / 255
		local sou_b = sou_col % 0x100 / 255
		obj.pixelshader("tv_on_off_scanline", "tempbuffer", "tempbuffer", {
			l,
			sou_alp / 100,
			sou_r,
			sou_g,
			sou_b,
		})
	end

	obj.setoption("blend", "none")
	--横影の描画
	if kage == 1 then
		obj.load("figure", "四角形", 0x000000, w)
		obj.effect("斜めクリッピング", "幅", kage_haba, "ぼかし", 20)
		obj.draw(0, h / 2 - (kage_v * obj.time) % (h + 80 * 2), 0, 1, 0.4)
	end

	--縁の描画
	if edg == 1 then
		ss = 50
		obj.load("figure", "四角形", 0x000000, ss * 2)
		obj.effect("マスク", "マスクの種類", "円", "サイズ", ss, "マスクの反転", 1)
		obj.effect("ぼかし", "範囲", 10, "サイズ固定", 1)
		w = w * ensize / 100
		h = h * ensize / 100
		if as == 0 then
			h = w
		end
		obj.drawpoly(
			-w / 2,
			-h / 2,
			0,
			w / 2,
			-h / 2,
			0,
			w / 2,
			h / 2,
			0,
			-w / 2,
			h / 2,
			0,
			ss / 2,
			ss / 2,
			ss * 3 / 2,
			ss / 2,
			ss * 3 / 2,
			ss * 3 / 2,
			ss / 2,
			ss * 3 / 2
		)
	end

	--全体を描画
	obj.load("tempbuffer")

	--登場・退場時のモーション
	function HNK(i, sti, edi, stval, edval)
		val = stval + (edval - stval) * (sti - i) / (sti - edi)
		return val
	end

	if i > 0 then
		if i > 5 / 9 then
			xscale = HNK(i, 6 / 9, 5 / 9, 0.7, 0.3)
			yscale = HNK(i, 6 / 9, 5 / 9, 0.35, 1)
			obj.effect("色調補正", "明るさ", HNK(i, 6 / 9, 5 / 9, 150, 120))
		elseif i > 3 / 9 then
			xscale = HNK(i, 5 / 9, 3 / 9, 0.3, 0.6)
			yscale = HNK(i, 5 / 9, 3 / 9, 1, 0.6)
			obj.effect("色調補正", "明るさ", HNK(i, 5 / 9, 3 / 9, 120, 100))
		elseif i > 0 then
			xscale = HNK(i, 3 / 9, 0, 0.6, 0.8)
			yscale = HNK(i, 3 / 9, 0, 0.6, 1)
		end

		obj.zoom = math.max(xscale, yscale)
		if xscale > yscale then
			obj.aspect = obj.aspect + yscale / xscale - 1
		else
			obj.aspect = obj.aspect + 1 - xscale / yscale
		end
	end
else
	--白線の描画
	obj.load("figure", "四角形", 0xffffff, w)
	obj.effect("斜めクリッピング", "幅", senhaba, "ぼかし", 0)
	obj.effect("斜めクリッピング", "角度", 90, "幅", 10 + w * (1 - i) * 9 / 4, "ぼかし", 50)
	obj.draw()
end
