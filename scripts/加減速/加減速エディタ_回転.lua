---$track:X回転
---min=-720
---max=720
local track0 = 0
---$track:Y回転
---min=-720
---max=720
local track1 = 0
---$track:Z回転
---min=-720
---max=720
local track2 = 0
---$track:頂点数
---min=1
---max=16
---step=1
local track3 = 1
---$check:X回転あり
local rx = 1

---$check:Y回転あり
local ry = 1

---$check:Z回転あり
local rz = 1

---$value:グラフ内[0-1]
local gn = 1

---$value:座標
local pos = {}

---$value:仮想bufサイズ[%]
local bufsize = 100

---$check:グラフ表示
local hojo = 1

---$value:G横サイズ
local gwsize = 400

---$value:G縦サイズ
local ghsize = 300

---$color:G色
local col = 0xffff00

---$value:Gライン幅
local line = 5

---$value:G分割数
local BN = 20


l = math.floor(line) / 2
NN = track3 + 1

--アンカーポイントの設置
obj.setanchor("pos", NN - 1, "line")
for i = 0, NN - 2 do
	pos[2 * i + 1] = -gwsize / 2 + gwsize / NN * (i + 1)
end

--補完曲線の算定(ティム氏の簡易モーションパスより一部を改変して使用)
XX = {}
YY = {}
XX[0] = -gwsize / 2
YY[0] = ghsize / 2
XX[NN] = gwsize / 2
YY[NN] = -ghsize / 2
for i = 1, NN - 1 do
	XX[i] = pos[2 * (i - 1) + 1]
	YY[i] = pos[2 * (i - 1) + 2]
end

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

obj.setoption("drawtarget", "tempbuffer", obj.screen_w * bufsize / 100, obj.screen_h * bufsize / 100)

--加減速移動
dpx, dp = PassXYZ(obj.frame / obj.totalframe)
dp = dp / ghsize + 0.5
if gn == 1 then
	dp = math.min(1, math.max(dp, 0))
end
function ADC(tr, jdg)
	if jdg == 0 then
		adc = obj.getvalue(tr)
	else
		adc = obj.getvalue(tr, 0, 0) + (obj.getvalue(tr, 0, -1) - obj.getvalue(tr, 0, 0)) * (1 - dp)
	end
	return adc
end
obj.draw(0, 0, 0, 1, 1, ADC(0, rx), ADC(1, ry), ADC(2, rz))

--グラフ表示
if hojo == 1 then
	Nmax = NN * BN

	--ライン描画
	obj.load("figure", "四角形", col, 1)
	obj.setoption("blend", "alpha_mix")
	x0 = XX[0]
	y0 = YY[0]
	for i = 1, Nmax do
		x1, y1 = PassXYZ(i / (NN * BN))
		if gn == 1 then
			y1 = math.min(ghsize / 2, math.max(y1, -ghsize / 2))
		end
		r = math.atan2(y0 - y1, x1 - x0)
		dx = math.sin(r) * l
		dy = math.cos(r) * l
		obj.drawpoly(x0 - dx, y0 - dy, 0, x1 - dx, y1 - dy, 0, x1 + dx, y1 + dy, 0, x0 + dx, y0 + dy, 0)
		x0 = x1
		y0 = y1
	end

	--斜め線の描画
	r = math.atan2(ghsize, gwsize)
	dx = math.sin(r) * l / 2
	dy = math.cos(r) * l / 2
	obj.drawpoly(
		XX[0] - dx,
		YY[0] - dy,
		0,
		XX[NN] - dx,
		YY[NN] - dy,
		0,
		XX[NN] + dx,
		YY[NN] + dy,
		0,
		XX[0] + dx,
		YY[0] + dy,
		0,
		0,
		0,
		1,
		0,
		1,
		1,
		0,
		1,
		0.5
	)

	--頂点の描画
	obj.load("figure", "円", col, l * 8)
	for i = 0, Nmax do
		x0, y0 = PassXYZ(i / (NN * BN))
		if gn == 1 then
			y0 = math.min(ghsize / 2, math.max(y0, -ghsize / 2))
		end
		obj.drawpoly(x0 - l, y0 - l, 0, x0 + l, y0 - l, 0, x0 + l, y0 + l, 0, x0 - l, y0 + l, 0)
	end

	--青い点の描画
	l = l * 1.5
	obj.load("figure", "円", 0x0000ff, l * 8)
	for i = 1, NN - 1 do
		x0, y0 = XX[i], YY[i]
		if gn == 1 then
			y0 = math.min(ghsize / 2, math.max(y0, -ghsize / 2))
		end
		obj.drawpoly(x0 - l, y0 - l, 0, x0 + l, y0 - l, 0, x0 + l, y0 + l, 0, x0 - l, y0 + l, 0)
	end

	--現在地の描画
	obj.load("figure", "円", 0xff0000, l * 8)
	x0, y0 = PassXYZ(obj.frame / obj.totalframe)
	if gn == 1 then
		y0 = math.min(ghsize / 2, math.max(y0, -ghsize / 2))
	end
	obj.drawpoly(x0 - l, y0 - l, 0, x0 + l, y0 - l, 0, x0 + l, y0 + l, 0, x0 - l, y0 + l, 0)

	obj.setoption("blend", 0)
end

obj.load("tempbuffer")
