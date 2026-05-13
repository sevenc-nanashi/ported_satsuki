--label:${ROOT_CATEGORY}\画像ファイル
---$track:連番桁
---min=1
---max=8
---step=1
local digit_count = 4
---$track:再生速度
---min=0
---max=1000
---step=1
local playback_speed = 100
---$track:開始位置
---min=0
---max=10000
---step=1
local start_frame = 0
---$track:ループ位置
---min=0
---max=10000
---step=1
local loop_frame = 10000
---$file:ファイル
local file = ""

--連番画像読み込み(hksy.obj)を改変したものです。
--ファイル名は(0001.png)などの連番数字が前提
local base_path, extension = string.match(file, "^(.*)%.([^%.\\/]*)$")

if base_path ~= nil then
    local path = string.sub(base_path, 1, string.len(base_path) - digit_count)
    local frame = obj.time * obj.framerate
    local image_number = (frame * (playback_speed / 100)) % (loop_frame - start_frame + 1) + start_frame
    local image_name = string.format("%0" .. digit_count .. "d", image_number) .. "." .. extension
    local image_path = path .. image_name

    obj.load("image", image_path)
else
    obj.load("image", file)
end
