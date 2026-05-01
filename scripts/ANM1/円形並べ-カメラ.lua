--label:${ROOT_CATEGORY}\配置
---$track:個数
---min=0
---max=100
---step=1
local n = 10
---$track:距離
---min=0
---max=2000
local l = 200
---$track:拡大率
---min=0
---max=800
local track2 = 100
---$track:回転
---min=-360
---max=360
local rr = 0
---$check:Y軸回転なし
local __rename_me_check0 = false

k = track2 / 100
obj.effect()
for i = 0, n - 1 do
	r = 360 * i / n + rr
	x = math.sin(r * math.pi / 180) * l * k
	z = -math.cos(r * math.pi / 180) * l * k
	s = obj.zoom * k
	ry = -360 * i / n - rr
	if __rename_me_check0 then
		ry = ry * 0
	end
	obj.draw(x, 0, z, s, 1, 0, ry, 0)
end
