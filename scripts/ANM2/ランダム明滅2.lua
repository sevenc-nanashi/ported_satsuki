--label:${ROOT_CATEGORY}\アニメーション効果
---$track:個数
---min=0
---max=1000
---step=1
local n = 5
---$track:範囲
---min=0
---max=1000
local track1 = 100
---$track:移動速度
---min=0
---max=1000
local track2 = 0
---$track:回転速度
---min=0
---max=1000
local track3 = 0
---$value:明滅最大[秒]
local max = 5

---$value:明滅最小[秒]
local min = 1

---$value:開始位置[秒]
local f = 3

---$value:閾値[%]
local si = 0

---$value:X軸範囲[%]
local wx = 100

---$value:Y軸範囲[%]
local wy = 100

---$value:Z軸範囲[%]
local wz = 0

---$check:X回転
local kx = 0

---$check:Y回転
local ky = 0

---$check:Z回転
local kz = 1

---$value:拡大最小[-%]
local s_min = 0

obj.effect()
w = track1 / 100 --範囲
v = track2 / 100 --移動速度
r = track3 / 100 --回転速度
for i = 0, n - 1 do
	x = (obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, i, 0) / 2 * w + obj.rand(-100, 100, i, 3) * obj.time * v)
		* wx
		/ 100
	y = (obj.rand(-obj.screen_h - obj.h, obj.screen_h + obj.h, i, 1) / 2 * w + obj.rand(-100, 100, i, 4) * obj.time * v)
		* wy
		/ 100
	z = (obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, i, 2) / 2 * w + obj.rand(-100, 100, i, 5) * obj.time * v)
		* wz
		/ 100
	s = obj.rand(100 - s_min, 100, i, 6) / 100
	rx = (obj.rand(0, 360, i, 7) + obj.rand(-100, 100, i, 10) * obj.time * r) * kx
	ry = (obj.rand(0, 360, i, 8) + obj.rand(-100, 100, i, 11) * obj.time * r) * ky
	rz = (obj.rand(0, 360, i, 9) + obj.rand(-100, 100, i, 12) * obj.time * r) * kz
	t = obj.rand(min * 1000, max * 1000, 0, i) / 1000
	alp = math.cos(2 * math.pi * (obj.time + f) * (1 / t)) * (0.5 + 0.5 * si / 100) + 0.5 - 0.5 * si / 100
	obj.draw(x, y, z, s, alp, rx, ry, rz)
end
