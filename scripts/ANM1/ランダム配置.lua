--label:${ROOT_CATEGORY}\配置
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

---$value:乱数
local ran = 0

---$check:ランダム固定
local fugo = 0

obj.effect()
w = track1 / 100 --範囲
v = track2 / 100 --移動速度
r = track3 / 100 --回転速度
for i = 0, n - 1 do
	seed = (i + 1 + ran) * (1 - 2 * fugo)
	x = (
		obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, seed, 0) / 2 * w
		+ obj.rand(-100, 100, seed, 3) * obj.time * v
	)
		* wx
		/ 100
	y = (
		obj.rand(-obj.screen_h - obj.h, obj.screen_h + obj.h, seed, 1) / 2 * w
		+ obj.rand(-100, 100, seed, 4) * obj.time * v
	)
		* wy
		/ 100
	z = (
		obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, seed, 2) / 2 * w
		+ obj.rand(-100, 100, seed, 5) * obj.time * v
	)
		* wz
		/ 100
	s = obj.rand(100 - s_min, 100, seed, 6) / 100
	rx = (obj.rand(0, 360, seed, 7) + obj.rand(-100, 100, seed, 10) * obj.time * r) * kx
	ry = (obj.rand(0, 360, seed, 8) + obj.rand(-100, 100, seed, 11) * obj.time * r) * ky
	rz = (obj.rand(0, 360, seed, 9) + obj.rand(-100, 100, seed, 12) * obj.time * r) * kz
	obj.draw(x, y, z, s, 1, rx, ry, rz)
end
