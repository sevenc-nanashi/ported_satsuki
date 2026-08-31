--label:${ROOT_CATEGORY}\動画ファイル
---$script_tips:動画ファイルを、それぞれ再生位置を変えて、ランダムな位置に配置されます。
---:それぞれの動画は、再生が終了すると最初から再生が繰り返され、ループするようになっています。
---$tips:ランダムに配置する数を指定します。
---$track:個数
---min=1
---max=20
---step=1
local n = 5
---$tips:動画の再生速度を指定します。
---$track:再生速度
---min=0
---max=800
---step=1
local playback_speed = 100
---$tips:全体の動画の再生位置をずらして調整します。
---$track:再生位置
---min=0
---max=300
---step=0.01
local playback_position = 0
---$tips:動画を配置する範囲を指定します。
---:100%が画面サイズとなります。
---$track:配置範囲
---min=0
---max=1000
---step=1
local placement_range = 100
---$tips:動画ファイルを読み込みます。
---$file:動画ファイル
local file = ""

local speed = playback_speed / 100
local range = placement_range / 100
local duration = obj.load(file)
for i = 0, n - 1 do
    local x = obj.rand(-obj.screen_w, obj.screen_w, i, 0) / 2 * range
    local y = obj.rand(-obj.screen_h, obj.screen_h, i, 1) / 2 * range
    obj.load(file, (playback_position + duration * i / n + obj.time * speed) % duration)
    obj.effect()
    obj.draw(x, y, 0, 1, 1, 0, 0, obj.rand(0, 360, i, 2))
end
