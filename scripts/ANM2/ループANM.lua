--label:${ROOT_CATEGORY}\配置
---$track:ループ[s]
---min=0
---max=20
---step=0.01
local t = 1
---$track:待機[s]
---min=0
---max=20
---step=0.01
local track1 = 0.2
---$track:拡大+%
---min=-100
---max=800
local track2 = 50
---$track:縦横比
---min=-100
---max=100
local track3 = 0
---$value:X
local x = 0

---$value:Y
local y = 0

---$value:Z
local z = 0

---$value:X軸回転
local rx = 0

---$value:Y軸回転
local ry = 0

---$value:Z軸回転
local rz = 0

---$value:開始位置[s]
local f = 0

---$check:待機2回
local wait = 0

w = math.min(track1, t)
r = 0
time0 = (math.max(obj.time - f, 0)) % t
if wait == 0 then
	if time0 <= t - w and time0 ~= 0 then
		r = math.sin(math.pi * time0 / (t - w))
	end
else
	time1 = (math.max(obj.time - f, 0)) % (2 * t)
	if time1 <= t - w then
		r = math.sin(math.pi * time0 / (t - w) / 2)
	elseif time1 <= t then
		r = 1
	elseif time1 <= 2 * t - w then
		r = 1 - math.sin(math.pi * time0 / (t - w) / 2)
	end
end
obj.ox = obj.ox + x * r
obj.oy = obj.oy + y * r
obj.oz = obj.oz + z * r
obj.zoom = obj.zoom * (1 + track2 / 100 * r)
obj.aspect = obj.aspect + track3 / 100 * r
obj.rx = obj.rx + rx * r
obj.ry = obj.ry + ry * r
obj.rz = obj.rz + rz * r
