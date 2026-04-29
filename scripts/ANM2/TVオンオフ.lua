---$track:時間
---min=-5
---max=5
---step=0.01
local t = -1
---$track:走査幅
---min=1
---max=100
local l = 2
---$track:縁調整%
---min=100
---max=800
local ensize = 110
---$track:影速度
---min=-1000
---max=1000
local kage_v = 100
--dialog:縁あり/chk,edg=1;縁アス比/chk,as=1;走査線あり/chk,sou=1;走査線強さ[%],sou_alp=50;走査線色/col,sou_col=0x000000;影あり/chk,kage=1;影の幅,kage_haba=80;白線の幅,senhaba=2;
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
		obj.setoption("blend", 5)
		obj.load("figure", "四角形", sou_col, 2)
		n = math.floor(h / l / 2)
		for i = 0, n do
			x0 = -w / 2
			x1 = w / 2
			y0 = -h / 2 + 2 * l * i
			y2 = -h / 2 + l + 2 * l * i
			obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, 0, 0, 1, 0, 1, 1, 0, 1, sou_alp / 100)
		end
	end

	obj.setoption("blend", 0)
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
		obj.effect("マスク", "type", 1, "サイズ", ss, "マスクの反転", 1)
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
