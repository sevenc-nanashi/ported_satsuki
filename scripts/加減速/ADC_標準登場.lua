--label:${ROOT_CATEGORY}\切り替え効果
--separator:加減速
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 1
---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2
---$select:モード
---減速=0
---加速=1
---S字=2
local mode = 0

---$track:方向
---min=-360
---max=360
---step=0.01
local direction_angle = 0
---$track:距離
---min=0
---max=20000
---step=1
local distance = 300
---$track:拡大率
---min=0
---max=800
---step=1
local zoom = 100
---$track:縦横比[%]
---min=-100
---max=100
---step=1
local aspect_ratio = 0

---$track:Z軸
---min=-20000
---max=20000
---step=1
local z_distance = 0

--trackgroup@rotation_x,rotation_y,rotation_z:回転
---$track:X回転
---min=-720
---max=720
---step=1
local rotation_x = 0

---$track:Y回転
---min=-720
---max=720
---step=1
local rotation_y = 0

---$track:Z回転
---min=-720
---max=720
---step=1
local rotation_z = 0

--共通部分
local progress
if duration == 0 then
    return
elseif duration < 0 then
    progress = (duration - obj.time + obj.totaltime) / duration
else
    progress = (duration - obj.time) / duration
end
progress = math.max(0, progress)

if mode < 1 then
    progress = progress ^ easing_power
elseif mode < 2 then
    progress = 1 - (1 - progress) ^ easing_power
else
    if progress <= 0.5 then
        progress = (2 * progress) ^ easing_power / 2
    else
        progress = (1 - (1 - (progress - 0.5) * 2) ^ easing_power) / 2 + 0.5
    end
end

--フィルタ効果
local movement_angle = direction_angle + 90
obj.ox = obj.ox + distance * math.cos(movement_angle * math.pi / 180) * progress
obj.oy = obj.oy + distance * math.sin(movement_angle * math.pi / 180) * progress
obj.oz = obj.oz + z_distance * progress
obj.zoom = obj.zoom + (zoom / 100 - 1) * progress
obj.aspect = obj.aspect + aspect_ratio / 100 * progress
obj.rz = obj.rz + rotation_z * progress
obj.rx = obj.rx + rotation_x * progress
obj.ry = obj.ry + rotation_y * progress
