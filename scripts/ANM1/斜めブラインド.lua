--label:${ROOT_CATEGORY}\切り替え効果
---$track:割合
---min=0
---max=100
local ratio = 50
---$track:幅
---min=10
---max=800
---step=1
local blind_width = 30
---$track:角度
---min=-360
---max=360
local angle = 60
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 0.5
---$check:時間指定で登場
local use_timed_transition = false

--[[pixelshader@diagonal_blind:
---$include "./shaders/diagonal_blind.hlsl"
]]

local progress = 1 - ratio / 100
if use_timed_transition then
    if duration == 0 then
        return
    elseif duration < 0 then
        progress = (duration - obj.time + obj.totaltime) / duration
    else
        progress = (duration - obj.time) / duration
    end
    progress = math.max(progress, 0)
end

obj.pixelshader("diagonal_blind", "object", "object", {
    blind_width,
    math.rad(angle),
    progress,
})
