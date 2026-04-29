--track0:ライン幅,2,100,20,1
--track1:頂点数,2,16,3,1
--track2:固定ｻｲｽﾞ,0,2000,0,1
--track3:縦横比,-100,100,0
--dialog:色/col,col=0xffffff;座標,pos={0,-150,130,75,-130,75};繰り返し描画数,r_num=nil;繰り返し分周,r_frq=nil;簡易塗り潰し/chk,fill=0;震える範囲,f_ran=20;震える間隔,f_kan=10;カクカク/chk,kak=0;
if r_num == nil then
	r_num = 1
end
if r_num < 1 then
	r_num = 1
end
if r_num > 100 then
	r_num = 100
end
if r_frq == nil then
	r_frq = 1
end
if r_frq < 1 then
	r_frq = 1
end
f_kan = f_kan * (1 - kak * 2)

n = obj.track1
l = math.floor(obj.track0) / 2
if obj.track2 > 0 then
	-- 固定座標
	w = obj.track2 / 2
	for i = 0, n - 1 do
		if f_kan > 0 then
			t = obj.time * 100 / f_kan
			p = math.floor(t)
			t = t - p
			x0 = obj.rand(-1000, 1000, i, p + 0) / 1000 * f_ran
			x1 = obj.rand(-1000, 1000, i, p + 1) / 1000 * f_ran
			x2 = obj.rand(-1000, 1000, i, p + 2) / 1000 * f_ran
			x3 = obj.rand(-1000, 1000, i, p + 3) / 1000 * f_ran
			y0 = obj.rand(-1000, 1000, i + n + 1, p + 0) / 1000 * f_ran
			y1 = obj.rand(-1000, 1000, i + n + 1, p + 1) / 1000 * f_ran
			y2 = obj.rand(-1000, 1000, i + n + 1, p + 2) / 1000 * f_ran
			y3 = obj.rand(-1000, 1000, i + n + 1, p + 3) / 1000 * f_ran
			xx, yy = obj.interpolation(t, x0, y0, x1, y1, x2, y2, x3, y3)
		else
			xx = obj.rand(-1000, 1000, i, math.floor(obj.frame / f_kan)) / 1000 * f_ran
			yy = obj.rand(-1000, 1000, i + n + 1, math.floor(obj.frame / f_kan)) / 1000 * f_ran
		end
		r = i * math.pi * 2 / n
		if n == 4 then
			r = r + math.pi / 4
		end
		pos[i * 2 + 1] = math.sin(r) * w + xx
		pos[i * 2 + 2] = -math.cos(r) * w + yy
	end
else
	-- 任意座標
	obj.setanchor("pos", n, "loop")
	for i = 0, n - 1 do
		if f_kan > 0 then
			t = obj.time * 100 / f_kan
			p = math.floor(t)
			t = t - p
			x0 = obj.rand(-1000, 1000, i, p + 0) / 1000 * f_ran
			x1 = obj.rand(-1000, 1000, i, p + 1) / 1000 * f_ran
			x2 = obj.rand(-1000, 1000, i, p + 2) / 1000 * f_ran
			x3 = obj.rand(-1000, 1000, i, p + 3) / 1000 * f_ran
			y0 = obj.rand(-1000, 1000, i + n + 1, p + 0) / 1000 * f_ran
			y1 = obj.rand(-1000, 1000, i + n + 1, p + 1) / 1000 * f_ran
			y2 = obj.rand(-1000, 1000, i + n + 1, p + 2) / 1000 * f_ran
			y3 = obj.rand(-1000, 1000, i + n + 1, p + 3) / 1000 * f_ran
			xx, yy = obj.interpolation(t, x0, y0, x1, y1, x2, y2, x3, y3)
		else
			xx = obj.rand(-1000, 1000, i, math.floor(obj.frame / f_kan)) / 1000 * f_ran
			yy = obj.rand(-1000, 1000, i + n + 1, math.floor(obj.frame / f_kan)) / 1000 * f_ran
		end
		pos[i * 2 + 1] = pos[i * 2 + 1] + xx
		pos[i * 2 + 2] = pos[i * 2 + 2] + yy
	end
end
-- 縦横比変更
if obj.track3 < 0 then
	dy = 1 + obj.track3 / 100
	for i = 0, n - 1 do
		pos[i * 2 + 2] = pos[i * 2 + 2] * dy
	end
elseif obj.track3 > 0 then
	dx = 1 - obj.track3 / 100
	for i = 0, n - 1 do
		pos[i * 2 + 1] = pos[i * 2 + 1] * dx
	end
end
-- 仮想バッファサイズ計算
w = 0
h = 0
for i = 0, n - 1 do
	dx = math.ceil(math.abs(pos[i * 2 + 1]) + l + 1)
	dy = math.ceil(math.abs(pos[i * 2 + 2]) + l + 1)
	if w < dx then
		w = dx
	end
	if h < dy then
		h = dy
	end
end
obj.setoption("drawtarget", "tempbuffer", w * 2, h * 2)
obj.load("figure", "四角形", col, 1)
-- 塗り潰し(凸多角形以外は駄目かも)
if fill == 1 then
	obj.setoption("blend", "alpha_add")
	dx = 0
	dy = 0
	for i = 0, n - 1 do
		dx = dx + pos[i * 2 + 1]
		dy = dy + pos[i * 2 + 2]
	end
	dx = dx / n
	dy = dy / n
	x0 = pos[(n - 1) * 2 + 1]
	y0 = pos[(n - 1) * 2 + 2]
	for i = 0, n - 1 do
		x1 = pos[i * 2 + 1]
		y1 = pos[i * 2 + 2]
		obj.drawpoly(x0, y0, 0, x1, y1, 0, dx, dy, 0, dx, dy, 0)
		x0 = x1
		y0 = y1
	end
end
-- ライン描画
obj.setoption("blend", "alpha_mix")
x0 = pos[(n - 1) * 2 + 1]
y0 = pos[(n - 1) * 2 + 2]
for i = 0, n - 1 do
	x1 = pos[i * 2 + 1]
	y1 = pos[i * 2 + 2]
	r = math.atan2(y0 - y1, x1 - x0)
	dx = math.sin(r) * l
	dy = math.cos(r) * l
	obj.drawpoly(x0 - dx, y0 - dy, 0, x1 - dx, y1 - dy, 0, x1 + dx, y1 + dy, 0, x0 + dx, y0 + dy, 0)
	x0 = x1
	y0 = y1
end
-- 頂点描画
obj.load("figure", "円", col, l * 8)
for i = 0, n - 1 do
	x0 = pos[i * 2 + 1]
	y0 = pos[i * 2 + 2]
	obj.drawpoly(x0 - l, y0 - l, 0, x0 + l, y0 - l, 0, x0 + l, y0 + l, 0, x0 - l, y0 + l, 0)
end
obj.setoption("blend", 0)
obj.load("tempbuffer")
-- 繰り返し描画
if r_num > 1 then
	w = math.ceil(math.sqrt(w * w + h * h))
	h = w
	obj.setoption("dst", "tmp", w * 2, h * 2)
	for i = 0, r_num - 1 do
		obj.draw(0, 0, 0, 1, 1, 0, 0, i * 360 / (r_num * r_frq))
	end
	obj.load("tempbuffer")
end
