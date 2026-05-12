--label:${ROOT_CATEGORY}\配置
local angle = 360 * (obj.layer - S_circle_camera_layer_base_layer) / S_circle_camera_layer_count
    + S_circle_camera_layer_rotation
obj.ox = math.sin(angle * math.pi / 180) * S_circle_camera_layer_distance * S_circle_camera_layer_scale
    + S_circle_camera_layer_base_x
obj.oy = S_circle_camera_layer_base_y
obj.oz = -math.cos(angle * math.pi / 180) * S_circle_camera_layer_distance * S_circle_camera_layer_scale
    + S_circle_camera_layer_base_z
obj.zoom = obj.zoom * S_circle_camera_layer_scale
