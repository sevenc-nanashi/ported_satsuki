--label:${ROOT_CATEGORY}\アニメーション効果
---$track:X回転
---min=-720
---max=720
---step=0.1
local rotation_x = 0

---$track:Y回転
---min=-720
---max=720
---step=0.1
local rotation_y = 0

---$track:Z回転
---min=-720
---max=720
---step=0.1
local rotation_z = 0

--trackgroup@rotation_x,rotation_y,rotation_z:回転

---$track:頂点数
---min=1
---max=16
---step=1
local vertex_count = 1

---$check:X回転あり
local has_rotation_x = true

---$check:Y回転あり
local has_rotation_y = true

---$check:Z回転あり
local has_rotation_z = true

---$check:グラフ内
local clamp_graph = true

---$value:座標
local positions = {}

---$track:仮想bufサイズ[%]
---min=1
---max=400
---step=0.1
local buffer_size = 100

---$check:グラフ表示
local show_graph = true

--group:グラフ
---$track:G横サイズ
---min=1
---max=2000
---step=0.1
local graph_width = 400

---$track:G縦サイズ
---min=1
---max=2000
---step=0.1
local graph_height = 300

---$color:G色
local graph_color = 0xffff00

---$track:Gライン幅
---min=0
---max=100
---step=0.1
local graph_line_width = 5

---$track:G分割数
---min=1
---max=200
---step=1
local graph_division_count = 20

local line_half_width = math.floor(graph_line_width) / 2
local point_count = vertex_count + 1

--アンカーポイントの設置
obj.setanchor("positions", point_count - 1, "line")
for i = 0, point_count - 2 do
    positions[2 * i + 1] = -graph_width / 2 + graph_width / point_count * (i + 1)
end

--補完曲線の算定(ティム氏の簡易モーションパスより一部を改変して使用)
local points_x = {}
local points_y = {}
points_x[0] = -graph_width / 2
points_y[0] = graph_height / 2
points_x[point_count] = graph_width / 2
points_y[point_count] = -graph_height / 2
for i = 1, point_count - 1 do
    points_x[i] = positions[2 * (i - 1) + 1]
    points_y[i] = positions[2 * (i - 1) + 2]
end

local coefficient_x_a = {}
local coefficient_x_b = {}
local coefficient_x_c = {}
local coefficient_y_a = {}
local coefficient_y_b = {}
local coefficient_y_c = {}
for i = 1, point_count - 1 do
    coefficient_x_a[i] = 2 * points_x[i - 1] - 4 * points_x[i] + 2 * points_x[i + 1]
    coefficient_x_b[i] = -3 * points_x[i - 1] + 4 * points_x[i] - points_x[i + 1]
    coefficient_x_c[i] = points_x[i - 1]
    coefficient_y_a[i] = 2 * points_y[i - 1] - 4 * points_y[i] + 2 * points_y[i + 1]
    coefficient_y_b[i] = -3 * points_y[i - 1] + 4 * points_y[i] - points_y[i + 1]
    coefficient_y_c[i] = points_y[i - 1]
end

local function interpolate_path(progress) -- progress <= 1
    local path_position = point_count * progress
    local path_index = math.floor(path_position)
    local half_progress = (path_position - path_index) / 2
    local next_x
    local next_y

    if path_index <= 0 then
        next_x = coefficient_x_a[1] * half_progress * half_progress
            + coefficient_x_b[1] * half_progress
            + coefficient_x_c[1]
        next_y = coefficient_y_a[1] * half_progress * half_progress
            + coefficient_y_b[1] * half_progress
            + coefficient_y_c[1]
    elseif path_index == point_count - 1 then
        local shifted_progress = half_progress + 0.5
        next_x = coefficient_x_a[path_index] * shifted_progress * shifted_progress
            + coefficient_x_b[path_index] * shifted_progress
            + coefficient_x_c[path_index]
        next_y = coefficient_y_a[path_index] * shifted_progress * shifted_progress
            + coefficient_y_b[path_index] * shifted_progress
            + coefficient_y_c[path_index]
    elseif progress == 1 then
        next_x = points_x[point_count]
        next_y = points_y[point_count]
    else
        local shifted_progress = half_progress + 0.5
        local blend_progress = 2 * half_progress
        next_x = (
            coefficient_x_a[path_index] * shifted_progress * shifted_progress
            + coefficient_x_b[path_index] * shifted_progress
            + coefficient_x_c[path_index]
        )
                * (1 - blend_progress)
            + blend_progress
                * (coefficient_x_a[path_index + 1] * half_progress * half_progress + coefficient_x_b[path_index + 1] * half_progress + coefficient_x_c[path_index + 1])
        next_y = (
            coefficient_y_a[path_index] * shifted_progress * shifted_progress
            + coefficient_y_b[path_index] * shifted_progress
            + coefficient_y_c[path_index]
        )
                * (1 - blend_progress)
            + blend_progress
                * (coefficient_y_a[path_index + 1] * half_progress * half_progress + coefficient_y_b[path_index + 1] * half_progress + coefficient_y_c[path_index + 1])
    end

    return next_x, next_y
end

obj.setoption("drawtarget", "tempbuffer", obj.screen_w * buffer_size / 100, obj.screen_h * buffer_size / 100)

--加減速移動
local _, speed_progress = interpolate_path(obj.frame / obj.totalframe)
speed_progress = speed_progress / graph_height + 0.5
if clamp_graph then
    speed_progress = math.min(1, math.max(speed_progress, 0))
end

local function interpolate_track(track_name, enabled)
    if not enabled then
        return obj.getvalue(track_name)
    else
        return obj.getvalue(track_name, 0, 0)
            + (obj.getvalue(track_name, 0, -1) - obj.getvalue(track_name, 0, 0)) * (1 - speed_progress)
    end
end

obj.draw(
    0,
    0,
    0,
    1,
    1,
    interpolate_track("track.rotation_x", has_rotation_x),
    interpolate_track("track.rotation_y", has_rotation_y),
    interpolate_track("track.rotation_z", has_rotation_z)
)

--グラフ表示
if show_graph then
    local graph_sample_count = point_count * graph_division_count

    --ライン描画
    obj.load("figure", "四角形", graph_color, 1)
    -- obj.setoption("blend", "alpha_mix")
    local x0 = points_x[0]
    local y0 = points_y[0]
    for i = 1, graph_sample_count do
        local x1, y1 = interpolate_path(i / (point_count * graph_division_count))
        if clamp_graph then
            y1 = math.min(graph_height / 2, math.max(y1, -graph_height / 2))
        end
        local angle = math.atan2(y0 - y1, x1 - x0)
        local dx = math.sin(angle) * line_half_width
        local dy = math.cos(angle) * line_half_width
        obj.drawpoly(x0 - dx, y0 - dy, 0, x1 - dx, y1 - dy, 0, x1 + dx, y1 + dy, 0, x0 + dx, y0 + dy, 0)
        x0 = x1
        y0 = y1
    end

    --斜め線の描画
    local angle = math.atan2(graph_height, graph_width)
    local dx = math.sin(angle) * line_half_width / 2
    local dy = math.cos(angle) * line_half_width / 2
    obj.drawpoly(
        points_x[0] - dx,
        points_y[0] - dy,
        0,
        points_x[point_count] - dx,
        points_y[point_count] - dy,
        0,
        points_x[point_count] + dx,
        points_y[point_count] + dy,
        0,
        points_x[0] + dx,
        points_y[0] + dy,
        0,
        0,
        0,
        1,
        0,
        1,
        1,
        0,
        1,
        0.5
    )

    --頂点の描画
    obj.load("figure", "円", graph_color, line_half_width * 8)
    for i = 0, graph_sample_count do
        x0, y0 = interpolate_path(i / (point_count * graph_division_count))
        if clamp_graph then
            y0 = math.min(graph_height / 2, math.max(y0, -graph_height / 2))
        end
        obj.drawpoly(
            x0 - line_half_width,
            y0 - line_half_width,
            0,
            x0 + line_half_width,
            y0 - line_half_width,
            0,
            x0 + line_half_width,
            y0 + line_half_width,
            0,
            x0 - line_half_width,
            y0 + line_half_width,
            0
        )
    end

    --青い点の描画
    local anchor_size = line_half_width * 1.5
    obj.load("figure", "円", 0x0000ff, anchor_size * 8)
    for i = 1, point_count - 1 do
        x0, y0 = points_x[i], points_y[i]
        if clamp_graph then
            y0 = math.min(graph_height / 2, math.max(y0, -graph_height / 2))
        end
        obj.drawpoly(
            x0 - anchor_size,
            y0 - anchor_size,
            0,
            x0 + anchor_size,
            y0 - anchor_size,
            0,
            x0 + anchor_size,
            y0 + anchor_size,
            0,
            x0 - anchor_size,
            y0 + anchor_size,
            0
        )
    end

    --現在地の描画
    obj.load("figure", "円", 0xff0000, anchor_size * 8)
    x0, y0 = interpolate_path(obj.frame / obj.totalframe)
    if clamp_graph then
        y0 = math.min(graph_height / 2, math.max(y0, -graph_height / 2))
    end
    obj.drawpoly(
        x0 - anchor_size,
        y0 - anchor_size,
        0,
        x0 + anchor_size,
        y0 - anchor_size,
        0,
        x0 + anchor_size,
        y0 + anchor_size,
        0,
        x0 - anchor_size,
        y0 + anchor_size,
        0
    )

    obj.setoption("blend", 0)
end

obj.load("tempbuffer")
