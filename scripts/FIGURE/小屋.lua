--label:${ROOT_CATEGORY}\図形\立体図形
---$track:サイズ
---min=0
---max=1000
---step=1
local size = 100
---$track:横幅比
---min=0
---max=100
---step=0.1
local width_ratio = 20
---$track:奥行き
---min=0
---max=1000
---step=1
local depth = 150
---$track:角度
---min=0
---max=180
---step=0.1
local roof_angle = 90
---$color:壁色
local wall_color = 0xffffff

---$color:屋根色
local roof_color = 0xff0000

---$track:ひさし1
---min=0
---max=5
---step=0.01
local front_eaves = 1.1

---$track:ひさし2
---min=0
---max=5
---step=0.01
local side_eaves = 1.2

---$track:屋根隙間
---min=0
---max=100
---step=0.1
local roof_gap = 5

local wall_height = size
local top_width_ratio = width_ratio / 100
local half_depth = wall_height * depth / 100 / 2
local half_wall_width = wall_height * (1 - top_width_ratio) / 2

local function quad(uv_size, x0, y0, z0, x1, y1, z1, x2, y2, z2, x3, y3, z3)
    return {
        x0,
        y0,
        z0,
        x1,
        y1,
        z1,
        x2,
        y2,
        z2,
        x3,
        y3,
        z3,
        0,
        0,
        uv_size,
        0,
        uv_size,
        uv_size,
        0,
        uv_size,
    }
end

--正面、背面
obj.load("figure", "四角形", wall_color, wall_height)
obj.effect("斜めクリッピング", "中心Y", -wall_height / 2, "角度", 90 + roof_angle / 2)
obj.effect("斜めクリッピング", "中心Y", -wall_height / 2, "角度", 270 - roof_angle / 2)
obj.effect("クリッピング", "左", wall_height * top_width_ratio / 2, "右", wall_height * top_width_ratio / 2)
obj.drawpoly(
    -half_wall_width,
    -wall_height,
    -half_depth,
    half_wall_width,
    -wall_height,
    -half_depth,
    half_wall_width,
    0,
    -half_depth,
    -half_wall_width,
    0,
    -half_depth
)
obj.drawpoly(
    -half_wall_width,
    -wall_height,
    half_depth,
    half_wall_width,
    -wall_height,
    half_depth,
    half_wall_width,
    0,
    half_depth,
    -half_wall_width,
    0,
    half_depth
)

--側面、底面
obj.load("figure", "四角形", wall_color, 2)
local wall_top_y = wall_height - half_wall_width / math.tan(math.rad(roof_angle / 2))
obj.drawpoly({
    quad(
        2,
        -half_wall_width,
        -wall_top_y,
        -half_depth,
        -half_wall_width,
        -wall_top_y,
        half_depth,
        -half_wall_width,
        0,
        half_depth,
        -half_wall_width,
        0,
        -half_depth
    ),
    quad(
        2,
        half_wall_width,
        -wall_top_y,
        -half_depth,
        half_wall_width,
        -wall_top_y,
        half_depth,
        half_wall_width,
        0,
        half_depth,
        half_wall_width,
        0,
        -half_depth
    ),
    quad(
        2,
        half_wall_width,
        0,
        -half_depth,
        half_wall_width,
        0,
        half_depth,
        -half_wall_width,
        0,
        half_depth,
        -half_wall_width,
        0,
        -half_depth
    ),
})

--屋根
obj.load("figure", "四角形", roof_color, 2)
local roof_depth = half_depth * front_eaves
local roof_side_x = half_wall_width * side_eaves
local roof_side_y = -wall_top_y + (wall_height - wall_top_y) * (side_eaves - 1) - roof_gap
obj.drawpoly({
    quad(
        2,
        0,
        -wall_height - roof_gap,
        -roof_depth,
        0,
        -wall_height - roof_gap,
        roof_depth,
        -roof_side_x,
        roof_side_y,
        roof_depth,
        -roof_side_x,
        roof_side_y,
        -roof_depth
    ),
    quad(
        2,
        0,
        -wall_height - roof_gap,
        -roof_depth,
        0,
        -wall_height - roof_gap,
        roof_depth,
        roof_side_x,
        roof_side_y,
        roof_depth,
        roof_side_x,
        roof_side_y,
        -roof_depth
    ),
})
