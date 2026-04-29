---$track:横幅
---min=1
---max=500
local ww = 15
---$track:長さ
---min=1
---max=500
local hh = 65
---$track:横サイズ
---min=0
---max=4000
local w = 800
---$track:縦サイズ
---min=0
---max=4000
local h = 450
--dialog:ライン幅,lhb=2;色1/col,col1=0x000000;色2(負値で透明)/col,col2=0xffffff;タイプ2/chk,uuss=1;

obj.setoption("drawtarget", "tempbuffer", w, h)

--背景
if col2 >= 0 then
	obj.load("figure", "四角形", col2, 2)
	obj.drawpoly(-w / 2, -h / 2, 0, w / 2, -h / 2, 0, w / 2, h / 2, 0, -w / 2, h / 2, 0)
end

--模様
obj.load("figure", "四角形", col1, 2)

local nx = math.floor(w / (ww * 4 + lhb * 2)) + 1
local ny = math.floor(h / hh) + 1

for j = -3, ny do
	y = -h / 2 + hh * j
	for i = 0, nx do
		if j % 2 == 0 then
			x = -w / 2 + (ww * 4 + lhb * 2) * i
		else
			x = -w / 2 + (ww * 4 + lhb * 2) * i + ww * 2 + lhb
		end
		if uuss == 0 then
			obj.drawpoly(
				x - ww - lhb / 2,
				y + ww,
				0,
				x - lhb / 2,
				y,
				0,
				x - lhb / 2,
				y + hh,
				0,
				x - ww - lhb / 2,
				y + ww + hh,
				0
			) --上向（左）
			obj.drawpoly(
				x + lhb / 2,
				y,
				0,
				x + ww + lhb / 2,
				y + ww,
				0,
				x + ww + lhb / 2,
				y + ww + hh,
				0,
				x + lhb / 2,
				y + hh,
				0
			) --上向（右）
			obj.drawpoly(
				x + lhb / 2 + ww * 2,
				y,
				0,
				x + lhb / 2 + ww * 2 + lhb,
				y,
				0,
				x + lhb / 2 + ww * 2 + lhb,
				y + hh,
				0,
				x + lhb / 2 + ww * 2,
				y + hh,
				0
			) --ライン
		else
			if i % 2 == 0 then
				obj.drawpoly(
					x - ww - lhb / 2,
					y + ww,
					0,
					x - lhb / 2,
					y,
					0,
					x - lhb / 2,
					y + hh,
					0,
					x - ww - lhb / 2,
					y + ww + hh,
					0
				) --上向（左）
				obj.drawpoly(
					x + lhb / 2,
					y,
					0,
					x + ww + lhb / 2,
					y + ww,
					0,
					x + ww + lhb / 2,
					y + ww + hh,
					0,
					x + lhb / 2,
					y + hh,
					0
				) --上向（右）
				obj.drawpoly(
					x - lhb / 2,
					y + hh,
					0,
					x + lhb / 2,
					y + hh,
					0,
					x + lhb / 2,
					y + hh * 2,
					0,
					x - lhb / 2,
					y + hh * 2,
					0
				) --ライン
			else
				obj.drawpoly(
					x - ww - lhb / 2,
					y + ww,
					0,
					x - lhb / 2,
					y + ww * 2,
					0,
					x - lhb / 2,
					y + hh + ww * 2,
					0,
					x - ww - lhb / 2,
					y + ww + hh,
					0
				) --下向（左）
				obj.drawpoly(
					x + lhb / 2,
					y + ww * 2,
					0,
					x + ww + lhb / 2,
					y + ww,
					0,
					x + ww + lhb / 2,
					y + ww + hh,
					0,
					x + lhb / 2,
					y + hh + ww * 2,
					0
				) --下向（右）
				obj.drawpoly(
					x - lhb / 2,
					y + ww * 2 - hh,
					0,
					x + lhb / 2,
					y + ww * 2 - hh,
					0,
					x + lhb / 2,
					y + ww * 2,
					0,
					x - lhb / 2,
					y + ww * 2,
					0
				) --ライン
			end
		end
	end
end

obj.load("tempbuffer")
