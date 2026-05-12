--label:${ROOT_CATEGORY}\配置
---$track:個数
---min=1
---max=100
---step=1
local count = 6
---$track:距離
---min=-20000
---max=20000
---step=1
local distance = 500
---$track:拡大率
---min=0
---max=800
local scale = 100
---$track:回転
---min=-720
---max=720
local rotation = 0

S_circle_camera_layer_count = count
S_circle_camera_layer_distance = distance
S_circle_camera_layer_scale = scale / 100
S_circle_camera_layer_rotation = rotation
S_circle_camera_layer_base_layer = obj.layer
S_circle_camera_layer_base_x = obj.x
S_circle_camera_layer_base_y = obj.y
S_circle_camera_layer_base_z = obj.z

local angle = 360 * (obj.layer - S_circle_camera_layer_base_layer) / S_circle_camera_layer_count
    + S_circle_camera_layer_rotation
obj.ox = math.sin(angle * math.pi / 180) * S_circle_camera_layer_distance * S_circle_camera_layer_scale
obj.oz = -math.cos(angle * math.pi / 180) * S_circle_camera_layer_distance * S_circle_camera_layer_scale
obj.zoom = obj.zoom * S_circle_camera_layer_scale
