--label:${ROOT_CATEGORY}\動画ファイル
---$track:開始[s]
---min=0
---max=600
---step=0.01
local start_time = 0
---$track:速度[%]
---min=-2000
---max=2000
local playback_speed = 100
---$track:加速度
---min=-100
---max=100
local acceleration = 0
---$track:コマ落ち間隔[s]
---min=0.01
---max=5
---step=0.01
local frame_drop_interval = 0.01
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
