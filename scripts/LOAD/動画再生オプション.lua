--label:${ROOT_CATEGORY}\動画ファイル
---$script_tips:動画ファイルを加速して再生させたりします。
---:再生が終了すると最初から再生が繰り返され、ループするようになっています。
---$tips:再生の開始位置を指定します。
---$track:開始[s]
---min=0
---max=600
---step=0.01
local start_time = 0
---$tips:再生速度を指定します。
---$track:速度[%]
---min=-2000
---max=2000
local playback_speed = 100
---$tips:動画の再生を段々と加速させます。
---:マイナスでは減速し、再生速度ゼロで停止します。
---$track:加速度
---min=-100
---max=100
local acceleration = 0
---$tips:コマ落ちのように、指定した時間間隔[s]でカクカクした再生となります。
---$track:コマ落ち間隔[s]
---min=0.01
---max=5
---step=0.01
local frame_drop_interval = 0.01
---$tips:動画ファイルを読み込みます。
---$file:ファイル
local video_file = ""

local speed = playback_speed / 100
local acceleration_rate = acceleration / 100
local time_offset = 0

if acceleration_rate < 0 and 2 * acceleration_rate * obj.time <= -speed then
    time_offset = -speed / 2 / acceleration_rate * (speed - acceleration_rate * speed / 2 / acceleration_rate)
    acceleration_rate = 0
    speed = 0
end

local playback_time = start_time
    + frame_drop_interval
        * math.floor((obj.time * speed + acceleration_rate * obj.time * obj.time + time_offset) / frame_drop_interval)

obj.load(video_file, playback_time % obj.load(video_file))
