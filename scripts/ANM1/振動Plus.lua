--label:${ROOT_CATEGORY}\アニメーション効果
---$track:振幅
---min=0
---max=1000
local l = 50
---$track:周期[s]
---min=0
---max=2
---step=0.01
local time = 0.2
---$track:個数
---min=0
---max=100
---step=1
local n = 10
---$track:閾値
---min=0
---max=100
local siki = 0
---$check:z軸振動の有無
local zz = 1


function sindo(x, y, z, t, s)
	a = obj.rand(0, 100, 0, math.floor(obj.time / t))
	if a < s then
		obj.effect("振動", "X", x, "Y", y, "Z", z, "周期", t * obj.framerate)
	end
end

for i = 1, n do
	ax = obj.rand(0, 1, i, 0) == 1 and 1 or -1
	ay = obj.rand(0, 1, i, 1) == 1 and 1 or -1
	az = obj.rand(0, 1, i, 2) == 1 and 1 or -1
	xi = i / n * ax * l
	yi = i / n * ay * l
	zi = i / n * az * l * zz
	ti = i * obj.rand(50, 100, i, 3) / 100 * time
	si = 100 - i / n * siki
	sindo(xi, yi, zi, ti, si)
end
