--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 0.3

---$track:間隔[s]
---min=0
---max=5
---step=0.01
local interval = 0.3

---$track:文字間隔
---min=-500
---max=500
local character_spacing = 34

---$track:拡大率
---min=0
---max=800
local zoom_rate = 100

---$track:切替フレーム
---min=1
---max=60
---step=1
local switch_frames = 3

---$check:フェード
local fades = false

---$track:Y軸
---min=-1000
---max=1000
local y_distance = 0

obj.effect()
obj.ox = 0
for i = 0, obj.num - 1 do
    local progress
    if duration == 0 then
        return
    elseif duration < 0 then
        progress = (duration - (obj.num - 1) * interval - obj.time + obj.totaltime + i * interval) / duration
    else
        progress = (duration - obj.time + i * interval) / duration
    end

    local alpha = 0
    if progress > 0 then
        if progress > 1 then
            obj.alpha = 0
            progress = 1
        end
        progress = progress * progress
        if fades then
            obj.alpha = obj.alpha * (1 - progress)
        end
        obj.zoom = obj.zoom + progress * (zoom_rate - 100) / 100
        obj.oy = obj.oy + y_distance * progress
        local random_index = (math.floor(obj.frame / switch_frames) + i * 3) % obj.num
        if obj.index == random_index then
            alpha = 1
        end
    else
        if i == obj.index then
            alpha = 1
        end
    end
    obj.draw(i * character_spacing, 0, 0, 1, alpha)
end
