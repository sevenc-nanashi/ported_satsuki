--label:${ROOT_CATEGORY}\動画ファイル
---$track:File数
---min=0
---max=500
---step=1
local file_count = 10
---$track:連番桁
---min=1
---max=8
---step=1
local digit_count = 4
---$track:速度[%]
---min=0
---max=2000
local speed_percent = 100
---$track:加速度
---min=0
---max=100
local acceleration = 0
---$file:ファイル
local file = ""

local duration = file_count / obj.framerate
local speed = speed_percent / 100 / obj.framerate
local acceleration_per_frame = acceleration / 100 / obj.framerate
local base_path, extension = string.match(file, "^(.*)%.([^%.\\/]*)$")

if base_path ~= nil then
    local path = string.sub(base_path, 1, string.len(base_path) - digit_count)
    local frame_number = 1
        + math.floor(((obj.time * speed + acceleration_per_frame * obj.time ^ 2) % duration) * obj.framerate)
    local image_name = string.format("%0" .. digit_count .. "d", frame_number) .. "." .. extension
    local image_path = path .. image_name

    obj.load("image", image_path)
else
    obj.load("image", file)
end
