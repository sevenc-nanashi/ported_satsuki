--label:${ROOT_CATEGORY}\配置
---$track:X間隔
---min=-1000
---max=1000
---step=1
local x_interval = 100
---$track:Y間隔
---min=-1000
---max=1000
---step=1
local y_interval = 100
---$track:Z間隔
---min=-2000
---max=2000
---step=1
local z_interval = 300

--trackgroup@x_interval,y_interval,z_interval:間隔

---$track:X個数
---min=1
---max=100
---step=1
local x_count = 3
---$track:Y個数
---min=1
---max=100
---step=1
local y_count = 3
---$track:Z個数
---min=1
---max=100
---step=1
local z_count = 1

---$check:XY軸段違い
local stagger_xy = false

---$check:ZY軸段違い
local stagger_zy = false

---$check:個別基準
local individual_origin = false

obj.effect()
if not individual_origin then
    local x_rate = x_interval / 100
    local y_rate = y_interval / 100
    local width = obj.w
    local height = obj.h
    for k = 0, z_count - 1 do
        local z = -z_interval * (z_count - 1) / 2 + k * z_interval
        for j = 0, y_count - 1 do
            local y0 = -(y_count + (y_count - 1) * (y_rate - 1)) * height / 2 + height * j * y_rate
            local y2 = -(y_count + (y_count - 1) * (y_rate - 1)) * height / 2 + height * (j * y_rate + 1)
            if stagger_zy and k % 2 == 1 then
                y0 = y0 + width / 2 * y_rate
                y2 = y2 + width / 2 * y_rate
            end
            for i = 0, x_count - 1 do
                local x0 = -(x_count + (x_count - 1) * (x_rate - 1)) * width / 2 + width * i * x_rate
                local x1 = -(x_count + (x_count - 1) * (x_rate - 1)) * width / 2 + width * (i * x_rate + 1)
                if stagger_xy and j % 2 == 0 then
                    x0 = x0 + width / 2 * x_rate
                    x1 = x1 + width / 2 * x_rate
                end
                obj.drawpoly(x0, y0, z, x1, y0, z, x1, y2, z, x0, y2, z, 0, 0, width, 0, width, height, 0, height)
            end
        end
    end
else
    for k = 0, z_count - 1 do
        local z = -z_interval * (z_count - 1) / 2 + k * z_interval
        for j = 0, y_count - 1 do
            local y = -y_interval * (y_count - 1) / 2 + j * y_interval
            if stagger_zy and k % 2 == 0 then
                y = y + y_interval / 2
            end
            for i = 0, x_count - 1 do
                local x = -x_interval * (x_count - 1) / 2 + i * x_interval
                if stagger_xy and j % 2 == 0 then
                    x = x + x_interval / 2
                end
                obj.draw(x, y, z)
            end
        end
    end
end
