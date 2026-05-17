--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:拡大率
---min=0
---max=800
---step=0.001
local zoom_rate = 100

---$track:X軸回転
---min=-720
---max=720
---step=0.01
local rotation_x = 0

---$track:Y軸回転
---min=-720
---max=720
---step=0.01
local rotation_y = 0

---$track:Z軸回転
---min=-720
---max=720
---step=0.01
local rotation_z = 0

--trackgroup@rotation_x,rotation_y,rotation_z:回転

local x = obj.ox
local y = obj.oy
local rz = math.rad(rotation_z)
obj.ox = x * math.cos(rz) - y * math.sin(rz)
obj.oy = x * math.sin(rz) + y * math.cos(rz)
obj.rz = obj.rz + rotation_z

y = obj.oy
local z = obj.oz
local rx = math.rad(rotation_x)
obj.oy = y * math.cos(rx) - z * math.sin(rx)
obj.oz = y * math.sin(rx) + z * math.cos(rx)
obj.rx = obj.rx + rotation_x

x = obj.ox
z = obj.oz
local ry = math.rad(rotation_y)
obj.oz = z * math.cos(ry) - x * math.sin(ry)
obj.ox = z * math.sin(ry) + x * math.cos(ry)
obj.ry = obj.ry + rotation_y

local zoom_scale = zoom_rate / 100
obj.ox = obj.ox * zoom_scale
obj.oy = obj.oy * zoom_scale
obj.zoom = obj.zoom * zoom_scale
