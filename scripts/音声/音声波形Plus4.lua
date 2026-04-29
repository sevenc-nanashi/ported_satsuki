--track0:分割数,2,1024,51,1
--track1:ライン幅,1,100,3
--track2:横幅,1,2000,640
--track3:閾値,1,2000,500,1
--dialog:高さ[%],H=150;色/col,color=0x00ff00;尖鋭化/chk,kaku=1;閾値を減算/chk,sist=1;
n = obj.track0
l = obj.track1 / 2
W = obj.track2
siki = obj.track3 * 10
w = W / (n - 1)
bun = math.floor(1024 / n)
buf = {}
obj.getaudio(buf, "audiobuffer", "pcm", 1024)
obj.setoption("dst", "tmp", W, W)

--ラインの描画
obj.setoption("blend", "alpha_mix")
obj.load("figure", "四角形", color, 1)
y0 = 0
y1 = 0
for i = 1, n - 1 do
	x0 = (i - 1) * w - W / 2
	x1 = i * w - W / 2
	if math.abs(buf[bun * (i + 1)]) > siki then
		if buf[bun * (i + 1)] > 0 then
			y1 = -(buf[bun * (i + 1)] - siki * sist) / 200 * H / 100
		else
			y1 = -(buf[bun * (i + 1)] + siki * sist) / 200 * H / 100
		end
	end
	if kaku == 1 then
		if i % 2 == 1 then
			y0 = 0
		else
			y1 = 0
		end
	end
	r = math.atan2(y0 - y1, x1 - x0)
	dx = math.sin(r) * l
	dy = math.cos(r) * l
	obj.drawpoly(x0 - dx, y0 - dy, 0, x1 - dx, y1 - dy, 0, x1 + dx, y1 + dy, 0, x0 + dx, y0 + dy, 0)
	y0 = y1
end

--頂点の描画
obj.load("figure", "円", color, l * 8)
for i = 1, n - 1 do
	x0 = (i - 1) * w - W / 2
	y0 = 0
	if math.abs(buf[bun * i]) > siki then
		if buf[bun * i] > 0 then
			y0 = -(buf[bun * i] - siki * sist) / 200 * H / 100
		else
			y0 = -(buf[bun * i] + siki * sist) / 200 * H / 100
		end
	end
	if kaku == 1 and i % 2 == 1 then
		y0 = 0
	end
	obj.drawpoly(x0 - l, y0 - l, 0, x0 + l, y0 - l, 0, x0 + l, y0 + l, 0, x0 - l, y0 + l, 0)
end

obj.load("tempbuffer")
