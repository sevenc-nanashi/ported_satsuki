--track0:半径,1,2000,200,1
--track1:角幅,0,2000,5,1
--track2:円幅,0,2000,5,1
--track3:種類,1,7,2,1
--dialog:色/col,col=0xffffff;回転速度,v=1;図形2つ/chk,fig_num=1;外円調整(%),soto=100;text(英数字のみ),text="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ";textサイズ,tsize=34;textフォント,font="MS UI Gothic";text半径調整(%),tll=100;textサイズ調整(%),ttsize=100;

l = obj.track0
w = math.min(obj.track1, l)
cw = obj.track2
j = obj.track3
rv = obj.time * 36 * v

--多角形ラインの描画
list_n = { 3, 4, 5, 5, 7, 8, 9 }
list_m = { 1, 1, 1, 2, 2, 3, 2 }
n = list_n[j]
m = list_m[j]
obj.load("figure", "四角形", col, 2)
obj.setoption("dst", "tmp", l * 2, l * 2)
obj.setoption("blend", "alpha_add")
for i = 0, n - 1 do
	r0 = math.rad(m * 360 * i / n)
	r1 = math.rad(m * 360 * (i + 1) / n)
	x0 = math.cos(r0) * l
	x1 = math.cos(r1) * l
	x2 = math.cos(r1) * l * (1 - w / l)
	x3 = math.cos(r0) * l * (1 - w / l)
	y0 = math.sin(r0) * l
	y1 = math.sin(r1) * l
	y2 = math.sin(r1) * l * (1 - w / l)
	y3 = math.sin(r0) * l * (1 - w / l)
	obj.drawpoly(x0, y0, 0, x1, y1, 0, x2, y2, 0, x3, y3, 0, 0, 0, 1, 0, 1, 1, 0, 1)
end

obj.load("tempbuffer")
size = (l * 2 + cw + cw * 2 / 3 + tsize * 2) * soto / 100
obj.setoption("dst", "tmp", size, size)
obj.draw(0, 0, 0, 1, 1, 0, 0, rv)
if fig_num == 1 then
	obj.draw(0, 0, 0, 1, 1, 0, 0, -rv + 180 / n)
end

--円の描画
obj.load("figure", "円", col, l * 2 + cw * 2 / 3, cw * 2 / 3)
obj.draw()
obj.load("figure", "円", col, size, cw)
obj.draw()

--テキストの描画
tlen = string.len(text)
for i = 1, tlen do
	obj.setfont(font, tsize * ttsize / 100, 0, col)
	obj.load("text", string.sub(text, i, i))
	tl = (l + tsize / 2) * tll / 100
	tr = 360 * i / tlen - rv
	tx = math.sin(tr * math.pi / 180) * tl
	ty = -math.cos(tr * math.pi / 180) * tl
	obj.draw(tx, ty, 0, 1, 1, 0, 0, tr)
end
obj.load("tempbuffer")
