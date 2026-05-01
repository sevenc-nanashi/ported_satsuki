--label:${ROOT_CATEGORY}\配置
---$track:個数
---min=0
---max=100
---step=1
local n = 6
---$track:距離
---min=0
---max=2000
local l = 200
---$track:拡大率
---min=0
---max=800
local track2 = 100
---$track:回転
---min=-720
---max=720
local k = 0
---$check:外向き
local __rename_me_check0 = false

s = track2 / 100
lay = obj.layer
soto = 0
r = 360 * (obj.layer - lay) / n + k
obj.ox = math.sin(r * math.pi / 180) * l * s
obj.oy = -math.cos(r * math.pi / 180) * l * s
obj.zoom = obj.zoom * s
obj.rz = r
if __rename_me_check0 then
	obj.ox = -obj.ox
	obj.rz = -obj.rz - 180
	soto = 1
end
x = obj.x
y = obj.y
z = obj.z
