--label:${ROOT_CATEGORY}\アニメーション効果\削除済み
---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2
---$select:モード
---減速=0
---加速=1
---S字=2
local mode = 0
---$check:非表示
local hidden = false

---$check:X軸
local include_x = 1

---$check:Y軸
local include_y = 1

---$check:Z軸
local include_z = 1

---$check:拡大率
local include_scale = 1

---$color:色
local color = 0xff0000

--beki=math.floor(beki)
mode = math.floor(mode)

local progress = 1 - obj.time / obj.totaltime

if progress > 0 then
    if progress > 1 then
        progress = 1
    end
    if mode < 1 then
        progress = progress ^ easing_power
    elseif mode < 2 then
        progress = 1 - (1 - progress) ^ easing_power
    else
        if progress <= 0.5 then
            progress = (2 * progress) ^ easing_power / 2
        else
            progress = (1 - (1 - (progress - 0.5) * 2) ^ easing_power) / 2 + 0.5
        end
    end

    local dx = (obj.getvalue("x", obj.totaltime) - obj.getvalue("x", 0)) * (1 - progress)
    local dy = (obj.getvalue("y", obj.totaltime) - obj.getvalue("y", 0)) * (1 - progress)
    local dz = (obj.getvalue("z", obj.totaltime) - obj.getvalue("z", 0)) * (1 - progress)
    local ds = (obj.getvalue("zoom", obj.totaltime) - obj.getvalue("zoom", 0)) * (1 - progress)

    obj.ox = obj.ox + (obj.getvalue("x", 0) + dx - obj.getvalue("x")) * include_x
    obj.oy = obj.oy + (obj.getvalue("y", 0) + dy - obj.getvalue("y")) * include_y
    obj.oz = obj.oz + (obj.getvalue("z", 0) + dz - obj.getvalue("z")) * include_z
    obj.zoom = obj.zoom + (obj.getvalue("zoom", 0) + ds - obj.getvalue("zoom")) * include_scale / 100
end
obj.draw()

--補助線
local alpha = 1 / 2
if not hidden then
    local h = obj.screen_h / 3
    local zoom = 100 / obj.getvalue("zoom")

    obj.setoption("billboard", 3)
    obj.load("figure", "円", color, 50)
    obj.draw(-h - obj.getvalue("x"), h - obj.getvalue("y"), 0, zoom, alpha)
    obj.setoption("billboard", 3)
    obj.load("figure", "円", color, 50)
    obj.draw(h - obj.getvalue("x"), -h - obj.getvalue("y"), 0, zoom, alpha)

    obj.setoption("billboard", 3)
    obj.load("figure", "円", color, 10)
    local num_points = 20
    for i = 0, num_points do
        local point_rate = i / num_points
        local point_progress = 1 - point_rate

        if mode < 1 then
            point_progress = point_progress ^ easing_power
        elseif mode < 2 then
            point_progress = 1 - (1 - point_progress) ^ easing_power
        else
            if point_progress <= 0.5 then
                point_progress = (2 * point_progress) ^ easing_power / 2
            else
                point_progress = (1 - (1 - (point_progress - 0.5) * 2) ^ easing_power) / 2 + 0.5
            end
        end
        local x = point_rate * h * 2 - h - obj.getvalue("x")
        local y = -h + point_progress * h * 2 - obj.getvalue("y")
        obj.draw(x, y, 0, zoom, alpha)
    end
end
