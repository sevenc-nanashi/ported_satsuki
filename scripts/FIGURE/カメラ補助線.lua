--label:${ROOT_CATEGORY}\ツール
---$track:サイズ
---min=1
---max=20000
---step=1
local size_doubled = 3000
---$track:ライン幅
---min=1
---max=100
---step=1
local line_weight = 10
---$track:テキスト
---min=0
---max=256
---step=1
local text_size = 80
---$color:平面色
local color = 0xffffff

local size = size_doubled / 2
local line_weight_half = line_weight / 2
local text_size_half = text_size / 2
obj.load("figure", "四角形", color, 2)
obj.drawpoly(-size, 0, size, size, 0, size, size, 0, -size, -size, 0, -size, 0, 0, 1, 0, 1, 1, 0, 1, 0.5)
obj.load("figure", "四角形", 0xffffff, 2)
obj.drawpoly(-line_weight_half, -size, 0, line_weight_half, -size, 0, line_weight_half, size, 0, -line_weight_half, size, 0)
obj.load("figure", "四角形", 0xff0000, 2)
obj.drawpoly(-size, 0, line_weight_half, size, 0, line_weight_half, size, 0, -line_weight_half, -size, 0, -line_weight_half)
obj.load("figure", "四角形", 0x0000ff, 2)
obj.drawpoly(-line_weight_half, 0, size, line_weight_half, 0, size, line_weight_half, 0, -size, -line_weight_half, 0, -size)

obj.load("figure", "円", 0x00ff00, size / 2 * 0.7, line_weight_half / 2)
obj.draw(0, 0, 0, 4, 1, 0, 0)
obj.draw(0, 0, 0, 4, 1, 90, 0)
obj.draw(0, 0, 0, 4, 1, 0, 90)
obj.draw(0, 0, 0, 4, 1, 90, 90)

local function draw_text(x, y, z, text)
    obj.setoption("billboard", 3)
    obj.setfont("MS UI Cothic", text_size_half, 3, 0xffff00, 0x000000)
    obj.load("text", text)
    obj.draw(x, y, z, 2)
end
draw_text(size, 0, 0, "+X")
draw_text(-size, 0, 0, "-X")
draw_text(0, size, 0, "+Y")
draw_text(0, -size, 0, "-Y")
draw_text(0, 0, size, "+Z")
draw_text(0, 0, -size, "-Z")
