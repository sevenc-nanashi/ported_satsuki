---$track:ライン幅
---min=1
---max=1000
local track0 = 20
---$track:先端size
---min=0
---max=1000
---step=1
local track1 = 50
---$track:頂点数
---min=3
---max=16
---step=1
local track2 = 3
---$track:分割数
---min=1
---max=50
---step=1
local BN = 20
---$color:色
local col = 0xffff00

---$figure:先端図形
local fig = "三角形"

---$check:両端を丸める
local maru = 0

---$value:座標
local pos = {-100,0,0,-50,100,0}


l = math.floor(track0) / 2
size = track1 / math.sqrt(2)
NN = track2 - 1
obj.setanchor("pos", NN + 1, "line")

XX = {}
YY = {}
for i = 0, NN do
	XX[i] = pos[2 * i + 1]
	YY[i] = pos[2 * i + 2]
end

--補完曲線の算定(ティム氏の簡易モーションパスより一部を改変して使用)
function PassXYZ(s) -- s<=1
	Ns = NN * s
	Ns1 = math.floor(Ns)
	Ns2 = (Ns - Ns1) / 2
	if Ns1 <= 0 then
		nx = Ax[1] * Ns2 * Ns2 + Bx[1] * Ns2 + Cx[1]
		ny = Ay[1] * Ns2 * Ns2 + By[1] * Ns2 + Cy[1]
	elseif Ns1 == NN - 1 then
		SS1 = Ns2 + 0.5
		nx = Ax[Ns1] * SS1 * SS1 + Bx[Ns1] * SS1 + Cx[Ns1]
		ny = Ay[Ns1] * SS1 * SS1 + By[Ns1] * SS1 + Cy[Ns1]
	elseif s == 1 then
		nx = XX[NN]
		ny = YY[NN]
	else
		SS1 = Ns2 + 0.5
		SS2 = Ns2
		RS = 2 * Ns2
		nx = (Ax[Ns1] * SS1 * SS1 + Bx[Ns1] * SS1 + Cx[Ns1]) * (1 - RS)
			+ RS * (Ax[Ns1 + 1] * SS2 * SS2 + Bx[Ns1 + 1] * SS2 + Cx[Ns1 + 1])
		ny = (Ay[Ns1] * SS1 * SS1 + By[Ns1] * SS1 + Cy[Ns1]) * (1 - RS)
			+ RS * (Ay[Ns1 + 1] * SS2 * SS2 + By[Ns1 + 1] * SS2 + Cy[Ns1 + 1])
	end
	return nx, ny
end

Ax = {}
Bx = {}
Cx = {}
Ay = {}
By = {}
Cy = {}
for M = 1, NN - 1 do
	Ax[M] = 2 * XX[M - 1] - 4 * XX[M] + 2 * XX[M + 1]
	Bx[M] = -3 * XX[M - 1] + 4 * XX[M] - XX[M + 1]
	Cx[M] = XX[M - 1]
	Ay[M] = 2 * YY[M - 1] - 4 * YY[M] + 2 * YY[M + 1]
	By[M] = -3 * YY[M - 1] + 4 * YY[M] - YY[M + 1]
	Cy[M] = YY[M - 1]
end

Nmax = NN * BN

--仮想バッファサイズ計算
w = 0
h = 0
for i = 0, NN do
	dx = math.ceil(math.abs(pos[i * 2 + 1]) + l + size + 1)
	dy = math.ceil(math.abs(pos[i * 2 + 2]) + l + size + 1)
	if w < dx then
		w = dx
	end
	if h < dy then
		h = dy
	end
end
obj.setoption("drawtarget", "tempbuffer", w * 2.5, h * 2.5)

--ライン描画
obj.load("figure", "四角形", col, 1)
obj.setoption("blend", "alpha_mix")
x0 = pos[1]
y0 = pos[2]
for i = 1, Nmax do
	x1, y1 = PassXYZ(i / (NN * BN))
	r = math.atan2(y0 - y1, x1 - x0)
	dx = math.sin(r) * l
	dy = math.cos(r) * l
	obj.drawpoly(x0 - dx, y0 - dy, 0, x1 - dx, y1 - dy, 0, x1 + dx, y1 + dy, 0, x0 + dx, y0 + dy, 0)
	x0 = x1
	y0 = y1
end

--先端描画
obj.load("figure", fig, col, size * 4)
sx = {}
sy = {}
sx1, sy1 = PassXYZ(0 / (NN * BN))
sx2, sy2 = PassXYZ(1 / (NN * BN))
r = math.atan2(sy1 - sy2, sx2 - sx1)
for i = 1, 4 do
	sx[i] = sx1 + math.cos(math.rad(-225 + (i - 1) * 90) - r) * size
	sy[i] = sy1 + math.sin(math.rad(-225 + (i - 1) * 90) - r) * size
end
obj.drawpoly(sx[1], sy[1], 0, sx[2], sy[2], 0, sx[3], sy[3], 0, sx[4], sy[4], 0)

--頂点の描画
obj.load("figure", "円", col, l * 8)
for i = 1 - maru, Nmax - 1 + maru do
	x0, y0 = PassXYZ(i / (NN * BN))
	obj.drawpoly(x0 - l, y0 - l, 0, x0 + l, y0 - l, 0, x0 + l, y0 + l, 0, x0 - l, y0 + l, 0)
end

obj.setoption("blend", 0)
obj.load("tempbuffer")
