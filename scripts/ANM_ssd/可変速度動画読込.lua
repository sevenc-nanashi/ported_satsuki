--label:${ROOT_CATEGORY}\動画ファイル
---$track:再生位置
---min=0
---max=50000
---step=1
local start_frame = 0
---$track:再生速度
---min=-1000
---max=1000
---step=1
local playback_speed = 100
---$check:ループ
local loop = true
---$check:透明あり
local has_alpha = false
---$file:ファイル
local file = ""

local _ = playback_speed --未使用警告回避

local frame_position = start_frame - 1
for i = 0, obj.frame do
    frame_position = frame_position + obj.getvalue("track.playback_speed", i / 30) / 100
end

local playback_time
if loop then
    local frames, rate, scale = obj.load("movie.info", file)
    if not frames then
        error("動画ファイルの情報を取得できませんでした。")
    end
    playback_time = (frame_position / obj.framerate) % (frames / rate * scale)
else
    playback_time = frame_position / obj.framerate
end

obj.load("movie", file, playback_time, has_alpha)

--再生速度を直線移動等で変化させることができます。
