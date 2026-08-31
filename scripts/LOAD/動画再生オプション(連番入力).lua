--label:${ROOT_CATEGORY}\画像ファイル
---$script_tips:連番画像を加速して再生させます。
---:連番画像の取り扱いは、連番スクリプトの項目を参照。
---$tips:読み込むファイルの範囲を指定します。
---$track:File数
---min=0
---max=500
---step=1
local file_count = 10
---$tips:連番部分の桁数を指定します。
---$track:連番桁
---min=1
---max=8
---step=1
local digit_count = 4
---$tips:再生速度を指定します。
---$track:速度[%]
---min=0
---max=2000
local speed_percent = 100
---$tips:動画の再生を段々と加速させます。
---:マイナスでは減速し、再生速度ゼロで停止します。
---$track:加速度
---min=0
---max=100
local acceleration = 0
---$tips:連番画像を読み込みます。
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
