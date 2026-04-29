---$track:半径
---min=1
---max=2000
---step=1
local l = 200
---$track:角幅
---min=0
---max=2000
---step=1
local track1 = 5
---$track:円幅
---min=0
---max=2000
---step=1
local cw = 5
---$track:種類
---min=1
---max=7
---step=1
local j = 2
--dialog:色/col,col=0xffffff;回転速度,v=1;図形2つ/chk,fig_num=1;外円調整(%),soto=100;text(英数字のみ),text="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ";textサイズ,tsize=34;textフォント,font="MS UI Gothic";text半径調整(%),tll=100;textサイズ調整(%),ttsize=100;

w = math.min(track1, l)
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
