--label:${ROOT_CATEGORY}\カスタムオブジェクト\模様
---$track:サイズ
---min=10
---max=500
local pattern_size = 50
---$track:ライン幅
---min=0
---max=50
local line_width = 2
---$track:横サイズ
---min=1
---max=4000
local width = 800
---$track:縦サイズ
---min=1
---max=4000
local height = 450
---$color:色1
local foreground_color = 0x000000

---$color:色2
local background_color = nil

local sqrt3 = math.sqrt(3)
local angle60 = math.rad(60)
local cut_width = math.min(line_width, 3 / (6 + 4 * sqrt3) * pattern_size)
local cut_length = pattern_size - (4 / sqrt3 + 2) * cut_width

obj.setoption("drawtarget", "tempbuffer", width, height)

-- ライン
obj.load("figure", "四角形", foreground_color, 2)
obj.drawpoly(-width / 2, -height / 2, 0, width / 2, -height / 2, 0, width / 2, height / 2, 0, -width / 2, height / 2, 0)

-- 三角

if background_color == nil then
    obj.setoption("blend", "alpha_sub")
else
    obj.setoption("blend", "alpha_add2")
    obj.load("figure", "四角形", background_color, 2)
end

local row_count = math.floor(height / pattern_size / sqrt3) + 1
local column_count = math.floor(width / pattern_size / 3) + 1

if cut_width > 0 then
    local vertices = {}
    local directions = {}
    for direction = 0, 3 do
        local direction_angle = angle60 * direction
        directions[direction + 1] = {
            cos = math.cos(direction_angle),
            sin = math.sin(direction_angle),
            angle = direction_angle,
        }
    end

    for row = 0, row_count do
        local base_y = -height / 2 + pattern_size * sqrt3 * row
        for column = 0, column_count do
            local base_x = -width / 2 + pattern_size * 3 * column
            for direction = 0, 3 do
                local direction_data = directions[direction + 1]
                local center_x = base_x + pattern_size * direction_data.cos
                local center_y = base_y + pattern_size * direction_data.sin
                for triangle = 0, 2 do
                    local triangle_angle = math.rad(triangle * 120) + direction_data.angle
                    local x0 = center_x + cut_width * math.cos(triangle_angle)
                    local y0 = center_y + cut_width * math.sin(triangle_angle)
                    local x1 = x0 + cut_length * math.cos(triangle_angle + angle60)
                    local y1 = y0 + cut_length * math.sin(triangle_angle + angle60)
                    local x2 = x0 + cut_length * math.cos(triangle_angle - angle60)
                    local y2 = y0 + cut_length * math.sin(triangle_angle - angle60)
                    vertices[#vertices + 1] = {
                        x0,
                        y0,
                        0,
                        x1,
                        y1,
                        0,
                        x2,
                        y2,
                        0,
                        x0,
                        y0,
                        0,
                        0,
                        0,
                        1,
                        0,
                        1,
                        1,
                        0,
                        1,
                    }
                end
            end
        end
    end
    obj.drawpoly(vertices)
else
    obj.drawpoly(
        -width / 2,
        -height / 2,
        0,
        width / 2,
        -height / 2,
        0,
        width / 2,
        height / 2,
        0,
        -width / 2,
        height / 2,
        0
    )
end

obj.load("tempbuffer")
