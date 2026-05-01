--label:${ROOT_CATEGORY}\切り替え効果
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local ta = 1
---$track:方向
---min=-360
---max=360
---step=0.01
local track1 = 0
---$track:距離
---min=0
---max=20000
local l = 300
---$track:拡大率
---min=0
---max=800
local s = 100
---$value:加減速[1-5]
local beki = 2

---$value:減
local mode = 0

---$value:縦横比[%]
local as = 0

---$value:Z軸
local z = 0

---$value:X回転
local rx = 0

---$value:Y回転
local ry = 0

---$value:Z回転
local rz = 0

--共通部分
if ta == 0 then
	return
elseif ta < 0 then
	t = (ta - obj.time + obj.totaltime) / ta
else
	t = (ta - obj.time) / ta
end
t = math.max(0, t)

if mode < 1 then
	t = t ^ beki
elseif mode < 2 then
	t = 1 - (1 - t) ^ beki
else
	if t <= 0.5 then
		t = (2 * t) ^ beki / 2
	else
		t = (1 - (1 - (t - 0.5) * 2) ^ beki) / 2 + 0.5
	end
end

--フィルタ効果
r = track1 + 90
obj.ox = obj.ox + l * math.cos(r * math.pi / 180) * t
obj.oy = obj.oy + l * math.sin(r * math.pi / 180) * t
obj.oz = obj.oz + z * t
obj.zoom = obj.zoom + (s / 100 - 1) * t
obj.aspect = obj.aspect + as / 100 * t
obj.rz = obj.rz + rz * t
obj.rx = obj.rx + rx * t
obj.ry = obj.ry + ry * t
