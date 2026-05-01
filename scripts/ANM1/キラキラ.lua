--label:${ROOT_CATEGORY}\光効果
---$track:個数
---min=1
---max=500
---step=1
local n = 20
---$track:距離
---min=0
---max=10000
---step=1
local l = 300
---$track:速度
---min=1
---max=2000
---step=1
local track2 = 100
---$track:出現範囲
---min=0
---max=2000
local sl = 0
---$value:ランダム速度[-%]
local v_ran = 90

---$value:透過速度[%]
local av = 100

---$value:拡大速度[%]
local sv = 0

---$check:ランダム回転
local rz_ran = 0

---$value:回転速度[度]
local rzv_ran = 0

---$value:ランダム拡大[-%]
local s_ran = 0

---$value:減速度[1-5]
local beki = 3

---$check:終点で消える
local zero = 1

---$value:乱数
local ran = 0

obj.effect()
v = l / track2 --距離を進むのにかかる時間
for i = 0, n - 1 do
	t = math.max((v - obj.time) / v, 0)
	t = t ^ beki
	x = (l * (1 - t) + obj.rand(0, sl, i, ran))
		* math.cos(obj.rand(0, 360, i, ran) * math.pi / 180)
		* obj.rand(100 - v_ran, 100, i, 1 + ran)
		/ 100
	y = (l * (1 - t) + obj.rand(0, sl, i, ran))
		* math.sin(obj.rand(0, 360, i, ran) * math.pi / 180)
		* obj.rand(100 - v_ran, 100, i, 1 + ran)
		/ 100
	zoom = 1 + sv / 100 * (1 - t) - obj.rand(0, s_ran, i, 10 + ran) / 100
	alpha = 1 - av / 100 * (1 - t)
	rz = obj.rand(0, 360, i, 6 + ran) * rz_ran + obj.rand(-rzv_ran / 2, rzv_ran / 2, i, 9 + ran) * obj.time
	if zero == 1 and t == 0 then
		alpha = 0
	end
	obj.draw(x, y, 0, zoom, alpha, 0, 0, rz)
end
