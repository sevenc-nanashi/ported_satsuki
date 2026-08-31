---$script_tips:蝶の画像に適用すると、蝶が羽ばたくようなアニメーションをします。
---:あらかじめ画像の中心が蝶の中心になるように、画像を用意して下さい。
---:カメラ制御下で使用して下さい。
--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$tips:羽ばたきの速さを指定します。
---$track:羽ばたき
---min=0
---max=500
local amplitude = 100
---$tips:上下の羽ばたきの角度を指定します。
---$track:角度
---min=0
---max=180
local angle = 120
---$tips:画像全体を上下に動かします。その移動距離を指定。
---$track:上下
---min=0
---max=200
local vertical_amplitude = 30
---$tips:トラックバーで手動で羽ばたきを動かします。
---$track:羽(手動)
---min=-720
---max=720
local phase_shift = 0
obj.effect()
local r = math.sin(math.pi * 2 * obj.time * amplitude / 100)
local f = (angle * r + phase_shift) * math.pi / 180
local x = -obj.w / 2 * (1 + math.cos(f)) / 2
local z = -obj.w / 2 * math.sin(f / 2)
obj.oy = r * vertical_amplitude
obj.rx = -30
local w = obj.w / 2
local h = obj.h / 2
obj.drawpoly(x, -h, z, 0, -h, 0, 0, h, 0, x, h, z, 0, 0, w, 0, w, h * 2, 0, h * 2)
obj.drawpoly(0, -h, 0, -x, -h, z, -x, h, z, 0, h, 0, w, 0, w * 2, 0, w * 2, h * 2, w, h * 2)
