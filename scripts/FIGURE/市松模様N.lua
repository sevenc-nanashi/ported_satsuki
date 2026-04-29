--track0:サイズ,1,800,25,1
--track1:横回数,1,200,2,1
--track2:縦回数,1,200,2,1
--dialog:色1/col,col1=0xffffff;色2/col,col2=0x000000;
s = obj.track0
w = obj.track1
h = obj.track2
function ICHIMATSU(col, a)
	obj.load("figure", "四角形", col, 2)
	obj.effect()
	for j = 0, h - 1 do
		y0 = (-h * s / 2 + s * j)
		y2 = (-h * s / 2 + s * (j + 1))
		for i = 0, w - 1 do
			x0 = (-w * s / 2 + s * i)
			x1 = (-w * s / 2 + s * (i + 1))
			alp = (i + j + a) % 2
			obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, 0, 0, 1, 0, 1, 1, 0, 1, alp)
		end
	end
end
obj.setoption("dst", "tmp", s * w, s * h)
ICHIMATSU(col1, 1)
ICHIMATSU(col2, 0)
obj.load("tempbuffer")
