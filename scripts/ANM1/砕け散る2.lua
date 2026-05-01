--label:${ROOT_CATEGORY}\アニメーション効果
---$track:経過時間
---min=0
---max=50
---step=0.01
local track0 = 0
---$track:中心X
---min=-1000
---max=1000
local ax = 0
---$track:中心Y
---min=-1000
---max=1000
local ay = 0
---$track:中心z
---min=-1000
---max=1000
local az = 0
---$value:破片サイズ
local size = 50

---$value:速度
local speed = 100

---$value:重力
local grav = 100

---$value:時間差
local delay = 100

---$value:距離影響
local impact = 100

---$value:ランダム回転
local spin = 100

---$value:ランダム方向
local diff = 100

---$value:再生速度
local step = 1.0

local px = {}
local py = {}
local pz = {}
local pu = {}
local pv = {}

tm = track0 / 10 * step
obj.effect()
grav = grav * 6
delay = delay * 0.002
impact = impact * 0.1
spin = math.floor(spin * 10)
diff = diff / 80
if size < 10 then
	size = 10
end
xl = obj.w
yl = obj.h
sp = speed * 0.01 * math.sqrt(impact)
w = math.floor(xl / size)
h = math.floor(yl / size)
l = math.sqrt(xl * xl + yl * yl)
if w < 2 then
	w = 2
elseif w > xl then
	w = xl
end
if h < 2 then
	h = 2
elseif h > yl then
	h = yl
end
pw = xl / w / 2.3
ph = yl / h / 2.3
for y = 0, h - 1 do
	for x = 0, w - 1 do
		-- 各頂点を計算
		pu[0] = xl * x / w
		pu[1] = xl * (x + 1) / w
		pu[2] = pu[1]
		pu[3] = pu[0]
		pv[0] = yl * y / h
		pv[1] = pv[0]
		pv[2] = yl * (y + 1) / h
		pv[3] = pv[2]
		pu[0] = pu[0] + obj.rand(-pw, pw, x, y)
		pu[1] = pu[1] + obj.rand(-pw, pw, x + 1, y)
		pu[2] = pu[2] + obj.rand(-pw, pw, x + 1, y + 1)
		pu[3] = pu[3] + obj.rand(-pw, pw, x, y + 1)
		pv[0] = pv[0] + obj.rand(-ph, ph, x, y + 1000)
		pv[1] = pv[1] + obj.rand(-ph, ph, x + 1, y + 1000)
		pv[2] = pv[2] + obj.rand(-ph, ph, x + 1, y + 1 + 1000)
		pv[3] = pv[3] + obj.rand(-ph, ph, x, y + 1 + 1000)
		if x == 0 then
			pu[0] = 0
			pu[3] = 0
		elseif x == w - 1 then
			pu[1] = xl
			pu[2] = xl
		end
		if y == 0 then
			pv[0] = 0
			pv[1] = 0
		elseif y == h - 1 then
			pv[2] = yl
			pv[3] = yl
		end
		-- 基準の計算
		gx = (pu[0] + pu[1] + pu[2] + pu[3]) / 4
		gy = (pv[0] + pv[1] + pv[2] + pv[3]) / 4
		gz = 0
		cx = gx - xl / 2
		cy = gy - yl / 2
		cz = 0
		vx = cx - ax
		vy = cy - ay
		vz = -az
		v = math.sqrt(vx * vx + vy * vy + vz * vz)
		-- 時間の計算
		t = tm - v / l * delay
		if t < 0 then
			t = 0
			obj.setoption("antialias", 0)
		else
			obj.setoption("antialias", 1)
		end
		-- 回転を計算
		xx = t * obj.rand(-spin, spin, x, y + 2000) / 100
		yy = t * obj.rand(-spin, spin, x, y + 3000) / 100
		zz = t * obj.rand(-spin, spin, x, y + 4000) / 100
		sin_x = math.sin(xx)
		cos_x = math.cos(xx)
		sin_y = math.sin(yy)
		cos_y = math.cos(yy)
		sin_z = math.sin(zz)
		cos_z = math.cos(zz)
		m00 = cos_y * cos_z
		m01 = -cos_y * sin_z
		m10 = cos_x * sin_z + sin_x * cos_z * sin_y
		m11 = cos_x * cos_z - sin_x * sin_z * sin_y
		m20 = sin_x * sin_z - cos_x * cos_z * sin_y
		m21 = sin_x * cos_z + cos_x * sin_z * sin_y
		for i = 0, 3 do
			xx = pu[i] - gx
			yy = pv[i] - gy
			px[i] = m00 * xx + m01 * yy
			py[i] = m10 * xx + m11 * yy
			pz[i] = m20 * xx + m21 * yy
		end
		-- 表示座標を計算
		v = 1 / (1 + v * v / (l * l) * impact)
		vx = vx * v + obj.rand(-size, size, x, y + 4000) * diff
		vy = vy * v + obj.rand(-size, size, x, y + 5000) * diff
		vz = vz * v + obj.rand(-size, size, x, y + 6000) * diff
		cx = cx + t * vx * sp
		cy = cy + t * vy * sp + t * t * grav
		cz = cz + t * vz * sp
		obj.drawpoly(
			px[0] + cx,
			py[0] + cy,
			pz[0] + cz,
			px[1] + cx,
			py[1] + cy,
			pz[1] + cz,
			px[2] + cx,
			py[2] + cy,
			pz[2] + cz,
			px[3] + cx,
			py[3] + cy,
			pz[3] + cz,
			pu[0],
			pv[0],
			pu[1],
			pv[1],
			pu[2],
			pv[2],
			pu[3],
			pv[3]
		)
	end
end
