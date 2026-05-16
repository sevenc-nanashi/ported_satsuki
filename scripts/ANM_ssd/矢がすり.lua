--label:${ROOT_CATEGORY}\カスタムオブジェクト\模様
---$track:横幅
---min=1
---max=500
local arrow_width = 15
---$track:長さ
---min=1
---max=500
local arrow_length = 65
---$track:横サイズ
---min=1
---max=4000
local width = 800
---$track:縦サイズ
---min=1
---max=4000
local height = 450
---$track:ライン幅
---min=0
---max=500
local line_width = 2

---$color:色1
local foreground_color = 0x000000

---$color:色2
local background_color = nil

---$check:タイプ2
local alternate_type = true

obj.setoption("drawtarget", "tempbuffer", width, height)

-- 背景
if background_color then
    obj.load("figure", "四角形", background_color, 2)
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

-- 模様
obj.load("figure", "四角形", foreground_color, 2)

local vertices = {}

local function add_quad(x1, y1, x2, y2, x3, y3, x4, y4)
    vertices[#vertices + 1] = {
        x1,
        y1,
        0,
        x2,
        y2,
        0,
        x3,
        y3,
        0,
        x4,
        y4,
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

local x_period = arrow_width * 4 + line_width * 2
local column_count = math.floor(width / x_period) + 1
local row_count = math.floor(height / arrow_length) + 1

for row = -3, row_count do
    local y = -height / 2 + arrow_length * row
    for column = 0, column_count do
        local x
        if row % 2 == 0 then
            x = -width / 2 + x_period * column
        else
            x = -width / 2 + x_period * column + arrow_width * 2 + line_width
        end

        if not alternate_type then
            add_quad(
                x - arrow_width - line_width / 2,
                y + arrow_width,
                x - line_width / 2,
                y,
                x - line_width / 2,
                y + arrow_length,
                x - arrow_width - line_width / 2,
                y + arrow_width + arrow_length
            ) --上向（左）
            add_quad(
                x + line_width / 2,
                y,
                x + arrow_width + line_width / 2,
                y + arrow_width,
                x + arrow_width + line_width / 2,
                y + arrow_width + arrow_length,
                x + line_width / 2,
                y + arrow_length
            ) --上向（右）
            add_quad(
                x + line_width / 2 + arrow_width * 2,
                y,
                x + line_width / 2 + arrow_width * 2 + line_width,
                y,
                x + line_width / 2 + arrow_width * 2 + line_width,
                y + arrow_length,
                x + line_width / 2 + arrow_width * 2,
                y + arrow_length
            ) --ライン
        else
            if column % 2 == 0 then
                add_quad(
                    x - arrow_width - line_width / 2,
                    y + arrow_width,
                    x - line_width / 2,
                    y,
                    x - line_width / 2,
                    y + arrow_length,
                    x - arrow_width - line_width / 2,
                    y + arrow_width + arrow_length
                ) --上向（左）
                add_quad(
                    x + line_width / 2,
                    y,
                    x + arrow_width + line_width / 2,
                    y + arrow_width,
                    x + arrow_width + line_width / 2,
                    y + arrow_width + arrow_length,
                    x + line_width / 2,
                    y + arrow_length
                ) --上向（右）
                add_quad(
                    x - line_width / 2,
                    y + arrow_length,
                    x + line_width / 2,
                    y + arrow_length,
                    x + line_width / 2,
                    y + arrow_length * 2,
                    x - line_width / 2,
                    y + arrow_length * 2
                ) --ライン
            else
                add_quad(
                    x - arrow_width - line_width / 2,
                    y + arrow_width,
                    x - line_width / 2,
                    y + arrow_width * 2,
                    x - line_width / 2,
                    y + arrow_length + arrow_width * 2,
                    x - arrow_width - line_width / 2,
                    y + arrow_width + arrow_length
                ) --下向（左）
                add_quad(
                    x + line_width / 2,
                    y + arrow_width * 2,
                    x + arrow_width + line_width / 2,
                    y + arrow_width,
                    x + arrow_width + line_width / 2,
                    y + arrow_width + arrow_length,
                    x + line_width / 2,
                    y + arrow_length + arrow_width * 2
                ) --下向（右）
                add_quad(
                    x - line_width / 2,
                    y + arrow_width * 2 - arrow_length,
                    x + line_width / 2,
                    y + arrow_width * 2 - arrow_length,
                    x + line_width / 2,
                    y + arrow_width * 2,
                    x - line_width / 2,
                    y + arrow_width * 2
                ) --ライン
            end
        end
    end
end

obj.drawpoly(vertices)
obj.load("tempbuffer")
