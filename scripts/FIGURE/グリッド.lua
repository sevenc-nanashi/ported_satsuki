--track0:ライン幅,1,100,2
--track1:間隔,1,100,10
--track2:X範囲,0,500,100
--track3:Y範囲,0,500,100
--dialog:色/col,color=0x0000ff;横線のみ/chk,yoko=0;
obj.load("figure", "四角形", color, 2)
w = obj.screen_w * obj.track2 / 100
h = obj.screen_h * obj.track3 / 100
l0 = obj.track0
l1 = obj.track1
n = math.floor(math.max(w, h) / (l0 + l1) / 2)
obj.setoption("dst", "tmp", w, h)
for i = -n - 1, n do
	y0 = (l0 + l1) * i
	y2 = l0 + (l0 + l1) * i
	obj.drawpoly(-w / 2, y0, 0, w / 2, y0, 0, w / 2, y2, 0, -w / 2, y2, 0)
	if yoko == 0 then
		obj.drawpoly(y0, -h / 2, 0, y2, -h / 2, 0, y2, h / 2, 0, y0, h / 2, 0)
	end
end
obj.load("tempbuffer")
