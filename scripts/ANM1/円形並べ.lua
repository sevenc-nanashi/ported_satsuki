--label:${ROOT_CATEGORY}\配置
---$track:個数
---min=1
---max=100
---step=1
local n = 10
---$track:距離
---min=0
---max=2000
---step=1
local distance = 200
---$track:拡大率
---min=0
---max=800
local scale = 100
---$track:回転
---min=-360
---max=360
local rotation = 0
---$check:回転なし
local no_rotation = false

---$check:個別基準
local individual_origin = false

local scale_rate = scale / 100

if not individual_origin then
    local zoom = obj.getvalue("zoom") / 100 / scale_rate
    local buffer_size = distance * 2 + math.sqrt((obj.w / zoom) ^ 2 + (obj.h / zoom) ^ 2)
    obj.setoption("drawtarget", "tempbuffer", buffer_size, buffer_size)
    for i = 0, n - 1 do
        local angle = 360 * i / n
        local x = math.sin(angle * math.pi / 180) * distance
        local y = -math.cos(angle * math.pi / 180) * distance
        local draw_rotation = rotation
        if not no_rotation then
            draw_rotation = draw_rotation + angle
        end
        obj.draw(x, y, 0, scale_rate, 1, 0, 0, draw_rotation)
    end
    obj.load("tempbuffer")
else
    obj.effect()
    for i = 0, n - 1 do
        local angle = 360 * i / n + rotation
        local x = math.sin(angle * math.pi / 180) * distance
        local y = -math.cos(angle * math.pi / 180) * distance
        local draw_rotation = 0
        if not no_rotation then
            draw_rotation = angle
        end
        obj.draw(x, y, 0, scale_rate, 1, 0, 0, draw_rotation)
    end
end
