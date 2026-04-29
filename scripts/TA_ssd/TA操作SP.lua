--track0:最大値,100,800,200
--track1:拡大率,0,800,100
--dialog:一体化/chk,itk=0;座標,pos={};

n = obj.num
W = obj.screen_w / 2
H = obj.screen_h / 2 * 2 / 3
ss = obj.track1 / 100

obj.setanchor("pos", n * 2, "line", "inout")

--仮想バッファ用
if itk == 1 then
	ww = obj.w
	ksw = 0
	ksh = 0
	for i = 0, n - 1 do
		dx = math.ceil(math.abs(pos[i * 2 + 1]) + ww + 1)
		dy = math.ceil(math.abs(pos[i * 2 + 2]) + ww + 1)
		if ksw < dx then
			ksw = dx
		end
		if ksh < dy then
			ksh = dy
		end
	end
	obj.setoption("drawtarget", "tempbuffer", ksw * 2 * ss, ksh * 2 * ss)
end

--ここまで

for i = 0, (n - 1) * 2 do
	if obj.index == i then
		x = pos[i * 2 + 1] * ss
		y = pos[i * 2 + 2] * ss
		zzx = pos[i * 2 + 1 + n * 2]
		zzy = pos[i * 2 + 2 + n * 2]

		if math.abs(zzx) > W or math.abs(zzy) > H then
			zoom = 1 * ss
		else
			zoom = (zzx + W) / W / 2 * obj.track0 / 100 * ss
		end
		if itk == 1 then
			obj.draw(x, y, 0, zoom)
		else
			obj.ox = x
			obj.oy = y
			obj.zoom = zoom
		end
	end
end

if itk == 1 then
	obj.load("tempbuffer")
end

--8文字までしか使えません。
--右端が拡大率：最大値、左端が拡大率：ゼロ
--上下各3分の1、画面外の領域は拡大率100%になります。
