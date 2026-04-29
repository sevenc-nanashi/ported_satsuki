--track0:本数,1,400,10,1
--track1:幅,0,100,2
--track2:幅[+%],0,200,50,1
--track3:斜閾値,0,300,50,1
--dialog:色/col,col=0xff8000;ランダム変化/chk,chk=1;
n = obj.track0
dw0 = obj.track1
dwr = obj.track2
k = obj.track3
w = obj.screen_w / 2
h = obj.screen_h / 2
L = math.sqrt(obj.screen_w ^ 2, obj.screen_h / 2 ^ 2) * 2
ran = 0
if chk == 1 then
	ran = obj.rand(0, 100)
end

obj.setoption("dst", "tmp", w * 2 + 100, h * 2 + 100)
obj.load("figure", "四角形", col, 2)
for i = 0, n - 1 do
	cx = obj.rand(-w, w, i, ran + 0)
	cy = obj.rand(-h, h, i, ran + 1)
	dw = dw0 * (1 + obj.rand(0, dwr, i, ran + 2) / 100)
	l = math.sqrt((dw / 2) ^ 2 + L ^ 2)
	r_jud = obj.rand(0, 200 + k, i, ran + 3)
	if r_jud <= 100 then
		r = 0
	elseif r_jud <= 200 then
		r = math.rad(90)
	else
		r = math.rad(obj.rand(0, 180, i, ran + 4))
	end
	x0 = cx + math.cos(math.atan2(-L / 2, -dw / 2) + r) * l
	x1 = cx + math.cos(math.atan2(-L / 2, dw / 2) + r) * l
	x2 = cx + math.cos(math.atan2(L / 2, dw / 2) + r) * l
	x3 = cx + math.cos(math.atan2(L / 2, -dw / 2) + r) * l
	y0 = cy + math.sin(math.atan2(-L / 2, -dw / 2) + r) * l
	y1 = cy + math.sin(math.atan2(-L / 2, dw / 2) + r) * l
	y2 = cy + math.sin(math.atan2(L / 2, dw / 2) + r) * l
	y3 = cy + math.sin(math.atan2(L / 2, -dw / 2) + r) * l
	obj.drawpoly(x0, y0, 0, x1, y1, 0, x2, y2, 0, x3, y3, 0)
end
obj.load("tempbuffer")
