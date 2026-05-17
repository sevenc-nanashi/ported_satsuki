--label:${ROOT_CATEGORY}\アニメーション効果
---$track:個数
---min=1
---max=500
---step=1
local count = 10

---$track:時間差[s]
---min=0
---max=3
---step=0.01
local interval = 0.1

---$track:終時間[s]
---min=0
---max=30
---step=0.01
local end_duration = 0

obj.effect()
local time = obj.time
local total_time = obj.totaltime
local base_x = obj.getvalue("x")
local base_y = obj.getvalue("y")
local base_z = obj.getvalue("z")

for i = 0, count - 1 do
    local delay = interval * i
    local x = 0
    local y = 0
    local z = 0
    local alpha = 0

    if time <= delay then
        alpha = 0
    elseif time >= total_time - end_duration + delay then
        alpha = 0
    else
        local trace_time = time - delay
        x = obj.getvalue("x", trace_time) - base_x
        y = obj.getvalue("y", trace_time) - base_y
        z = obj.getvalue("z", trace_time) - base_z
        alpha = 1
    end
    obj.draw(x, y, z, 1, alpha)
end
