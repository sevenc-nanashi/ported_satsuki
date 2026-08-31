--label:${ROOT_CATEGORY}\図形\立体図形
---$script_tips:縁がついた立方体の図形を作ります。
---:カメラ制御下で使用して下さい。
---$tips:図形のサイズを指定します。
---$track:サイズ
---min=1
---max=1000
---step=1
local size = 100
---$tips:縁部分の幅を指定します。
---$track:ライン幅
---min=0
---max=4000
---step=1
local line_width = 10
---$tips:内側部分の透明度を指定します。
---$track:透明度
---min=0
---max=100
local fill_opacity = 50
---$tips:「明滅あり」にチェックした場合に有効です。
---:明滅させる時間間隔[s]を指定します。
---$track:明滅間隔[s]
---min=0
---max=5
---step=0.01
local blink_interval = 1
---$tips:縁部分または内側部分の色をしていします。
---$color:縁色
local edge_color = 0xffffff

---$tips:縁部分または内側部分の色をしていします。
---$color:内色
local fill_color = 0x0000ff

---$tips:チェックすると、内側部分が明滅します。
---$check:明滅あり
local use_blink = false
--hide@blink_interval:use_blink==0

local fill_size = size - line_width * 2
local max_alpha = fill_opacity / 100

local fill_alpha
if use_blink and blink_interval > 0 then
    fill_alpha = (math.sin(2 * math.pi * obj.time / blink_interval) * 0.5 + 0.5) * max_alpha
else
    fill_alpha = max_alpha
end

local function quad(texture_size, x0, y0, z0, x1, y1, z1, x2, y2, z2, x3, y3, z3)
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
        texture_size,
        0,
        texture_size,
        texture_size,
        0,
        texture_size,
    }
end

obj.load("figure", "四角形", edge_color, size, line_width)
obj.effect()
local edge_half_size = obj.w / 2
local edge_texture_size = obj.w
obj.drawpoly({
    quad(
        edge_texture_size,
        -edge_half_size,
        -edge_half_size,
        -edge_half_size,
        edge_half_size,
        -edge_half_size,
        -edge_half_size,
        edge_half_size,
        edge_half_size,
        -edge_half_size,
        -edge_half_size,
        edge_half_size,
        -edge_half_size
    ),
    quad(
        edge_texture_size,
        edge_half_size,
        -edge_half_size,
        edge_half_size,
        -edge_half_size,
        -edge_half_size,
        edge_half_size,
        -edge_half_size,
        edge_half_size,
        edge_half_size,
        edge_half_size,
        edge_half_size,
        edge_half_size,
        edge_half_size
    ),
    quad(
        edge_texture_size,
        -edge_half_size,
        edge_half_size,
        -edge_half_size,
        edge_half_size,
        edge_half_size,
        -edge_half_size,
        edge_half_size,
        edge_half_size,
        edge_half_size,
        -edge_half_size,
        edge_half_size,
        edge_half_size
    ),
    quad(
        edge_texture_size,
        edge_half_size,
        -edge_half_size,
        -edge_half_size,
        -edge_half_size,
        -edge_half_size,
        -edge_half_size,
        -edge_half_size,
        -edge_half_size,
        edge_half_size,
        edge_half_size,
        -edge_half_size,
        edge_half_size
    ),
    quad(
        edge_texture_size,
        edge_half_size,
        -edge_half_size,
        -edge_half_size,
        edge_half_size,
        -edge_half_size,
        edge_half_size,
        edge_half_size,
        edge_half_size,
        edge_half_size,
        edge_half_size,
        edge_half_size,
        -edge_half_size
    ),
    quad(
        edge_texture_size,
        -edge_half_size,
        -edge_half_size,
        edge_half_size,
        -edge_half_size,
        -edge_half_size,
        -edge_half_size,
        -edge_half_size,
        edge_half_size,
        -edge_half_size,
        -edge_half_size,
        edge_half_size,
        edge_half_size
    ),
})

obj.load("figure", "四角形", fill_color, fill_size)
obj.effect()
local fill_half_size = obj.w / 2
obj.alpha = fill_alpha
local fill_texture_size = obj.w
obj.drawpoly({
    quad(
        fill_texture_size,
        -fill_half_size,
        -fill_half_size,
        -fill_half_size - line_width,
        fill_half_size,
        -fill_half_size,
        -fill_half_size - line_width,
        fill_half_size,
        fill_half_size,
        -fill_half_size - line_width,
        -fill_half_size,
        fill_half_size,
        -fill_half_size - line_width
    ),
    quad(
        fill_texture_size,
        fill_half_size,
        -fill_half_size,
        fill_half_size + line_width,
        -fill_half_size,
        -fill_half_size,
        fill_half_size + line_width,
        -fill_half_size,
        fill_half_size,
        fill_half_size + line_width,
        fill_half_size,
        fill_half_size,
        fill_half_size + line_width
    ),
    quad(
        fill_texture_size,
        -fill_half_size,
        fill_half_size + line_width,
        -fill_half_size,
        fill_half_size,
        fill_half_size + line_width,
        -fill_half_size,
        fill_half_size,
        fill_half_size + line_width,
        fill_half_size,
        -fill_half_size,
        fill_half_size + line_width,
        fill_half_size
    ),
    quad(
        fill_texture_size,
        fill_half_size,
        -fill_half_size - line_width,
        -fill_half_size,
        -fill_half_size,
        -fill_half_size - line_width,
        -fill_half_size,
        -fill_half_size,
        -fill_half_size - line_width,
        fill_half_size,
        fill_half_size,
        -fill_half_size - line_width,
        fill_half_size
    ),
    quad(
        fill_texture_size,
        fill_half_size + line_width,
        -fill_half_size,
        -fill_half_size,
        fill_half_size + line_width,
        -fill_half_size,
        fill_half_size,
        fill_half_size + line_width,
        fill_half_size,
        fill_half_size,
        fill_half_size + line_width,
        fill_half_size,
        -fill_half_size
    ),
    quad(
        fill_texture_size,
        -fill_half_size - line_width,
        -fill_half_size,
        fill_half_size,
        -fill_half_size - line_width,
        -fill_half_size,
        -fill_half_size,
        -fill_half_size - line_width,
        fill_half_size,
        -fill_half_size,
        -fill_half_size - line_width,
        fill_half_size,
        fill_half_size
    ),
})
