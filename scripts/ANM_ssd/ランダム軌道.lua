---$track:XY振幅
---min=0
---max=500
local track0 = 200
---$track:間隔
---min=1
---max=500
local track1 = 100
---$track:個数
---min=1
---max=100
---step=1
local n = 3
---$track:範囲
---min=0
---max=100
local track3 = 100
---$value:Z軸振幅
local zsh = 0

---$value:Z軸回転範囲
local rz = 10

---$value:ランダム角度
local rrz = 0

---$value:ランダムサイズ[-%]
local rs = 0

---$value:ランダム透明度[-%]
local ralp = 0

---$value:差分
local sbn = 7.7


thuk = track3 / 100
for i = 0, n - 1 do
	t = (obj.time + i * sbn) * 100 / track1
	p = math.floor(t)
	t = t - p
	x0 = obj.rand(-1000, 1000, 0 + i, p + 0) / 1000 * track0 * thuk
	x1 = obj.rand(-1000, 1000, 0 + i, p + 1) / 1000 * track0 * thuk
	x2 = obj.rand(-1000, 1000, 0 + i, p + 2) / 1000 * track0 * thuk
	x3 = obj.rand(-1000, 1000, 0 + i, p + 3) / 1000 * track0 * thuk
	y0 = obj.rand(-1000, 1000, 1 + i, p + 0) / 1000 * track0 * thuk
	y1 = obj.rand(-1000, 1000, 1 + i, p + 1) / 1000 * track0 * thuk
	y2 = obj.rand(-1000, 1000, 1 + i, p + 2) / 1000 * track0 * thuk
	y3 = obj.rand(-1000, 1000, 1 + i, p + 3) / 1000 * track0 * thuk
	z0 = obj.rand(-1000, 1000, 2 + i, p + 0) / 1000 * zsh * thuk
	z1 = obj.rand(-1000, 1000, 2 + i, p + 1) / 1000 * zsh * thuk
	z2 = obj.rand(-1000, 1000, 2 + i, p + 2) / 1000 * zsh * thuk
	z3 = obj.rand(-1000, 1000, 2 + i, p + 3) / 1000 * zsh * thuk
	r0 = obj.rand(-1000, 1000, 3 + i, p + 0) / 1000 * rz * thuk
	r1 = obj.rand(-1000, 1000, 3 + i, p + 1) / 1000 * rz * thuk
	r2 = obj.rand(-1000, 1000, 3 + i, p + 2) / 1000 * rz * thuk
	r3 = obj.rand(-1000, 1000, 3 + i, p + 3) / 1000 * rz * thuk
	x, y, z = obj.interpolation(t, x0, y0, z0, x1, y1, z1, x2, y2, z2, x3, y3, z3)
	r = obj.interpolation(t, r0, r1, r2, r3)
	s = 1 - obj.rand(0, 1000, 10 + i, 10) / 1000 * rs / 100
	alp = 1 - obj.rand(0, 1000, 11 + i, 11) / 1000 * ralp / 100
	rrz1 = obj.rand(-rrz / 2, rrz / 2, 12 + i, 12)
	obj.draw(x, y, z, s, alp, 0, 0, r + rrz1)
end
