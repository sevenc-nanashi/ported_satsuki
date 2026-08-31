--label:${ROOT_CATEGORY}\図形\立体図形
---$script_tips:正多角形の立体図形を作ります。
---:カメラ制御下で使用して下さい。
---$tips:図形のサイズを指定します。
---$track:サイズ
---min=1
---max=1000
---step=1
local size = 100
---$tips:図形の奥行き(厚み)を指定します。
---$track:奥行き
---min=1
---max=500
---step=1
local length = 20
---$tips:図形のライン幅を指定します。
---$track:ライン幅
---min=0
---max=4000
---step=1
local weight = 4000
---$tips:多角形の角数を指定します。
---$select:図形
---三角形=0
---四角形=1
---五角形=2
---六角形=3
local figure = 4

---$tips:図形の色を指定します。
---$color:色
local color = 0xffffff

local h = math.min(weight, size / 2)

local figure_names = { "三角形", "四角形", "五角形", "六角形" }
obj.load("figure", figure_names[figure + 1], color, size, h)
obj.effect()
local x = obj.w / 2
local y = obj.h / 2
obj.drawpoly(-x, -y, length / 2, x, -y, length / 2, x, y, length / 2, -x, y, length / 2)
obj.drawpoly(-x, -y, -length / 2, x, -y, -length / 2, x, y, -length / 2, -x, y, -length / 2)

local corners = figure + 3
for k = 0, 1 do
    size = size - 2 * h * k
    local l, sr
    if corners == 4 then
        l = size / 2 * math.sqrt(2) - 1
        sr = 45
    else
        l = size / 2 - 1
        sr = 90
    end
    obj.load("figure", "四角形", color, 2)
    obj.effect()
    local r = 360 / corners
    local polygons = {}
    for i = 0, corners - 1 do
        local x0 = l * math.cos((sr + r * i) * math.pi / 180)
        local x1 = l * math.cos((sr - r + r * i) * math.pi / 180)
        local y0 = -l * math.sin((sr + r * i) * math.pi / 180)
        local y1 = -l * math.sin((sr - r + r * i) * math.pi / 180)
        table.insert(polygons, {
            x0,
            y0,
            -length / 2,
            x0,
            y0,
            length / 2,
            x1,
            y1,
            length / 2,
            x1,
            y1,
            -length / 2,
            0,
            0,
            obj.w,
            0,
            obj.w,
            obj.h,
            0,
            obj.h,
        })
    end
    obj.drawpoly(polygons)
end
