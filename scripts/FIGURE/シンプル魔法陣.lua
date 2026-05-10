--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$color:色
local col = 0xffffff
--group:外円
---$track:半径
---min=1
---max=2000
---step=1
local l = 200
---$track:円幅
---min=0
---max=2000
---step=1
local cw = 5

---$track:外円調整[%]
---min=0
---max=500
---step=1
local soto = 100

--group:内部
---$select:種類
---三角形=1
---四角形=2
---五角形=3
---五芒星=4
---七芒星=5
---八芒星=6
---九芒星=7
local j = 2
---$track:角幅
---min=0
---max=2000
---step=1
local circle_weight = 5

---$track:回転速度
---min=-100
---max=100
---step=0.01
local v = 1

---$check:図形2つ
local fig_num = true

--group:テキスト

---$string:テキスト内容
local text = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"

---$track:テキストサイズ
---min=1
---max=500
---step=1
local tsize = 34

---$font:テキストフォント
local font = "MS UI Gothic"

---$track:テキスト半径調整[%]
---min=0
---max=500
---step=1
local tll = 100

---$track:テキストサイズ調整[%]
---min=0
---max=500
---step=1
local ttsize = 100

--[[pixelshader@simple_magic_circle:
---$include "./shaders/simple_magic_circle.hlsl"
]]

local w = math.min(circle_weight, l)
local rv = obj.time * 36 * v
local list_n = { 3, 4, 5, 5, 7, 8, 9 }
local list_m = { 1, 1, 1, 2, 2, 3, 2 }
local n = list_n[j]
local m = list_m[j]
local size = (l * 2 + cw + cw * 2 / 3 + tsize * 2) * soto / 100
local draw_second_figure = fig_num and 1 or 0

obj.load("figure", "四角形", col, 2)
obj.setoption("drawtarget", "tempbuffer", size, size)
obj.setoption("blend", "alpha_add")
obj.drawpoly(-size / 2, -size / 2, 0, size / 2, -size / 2, 0, size / 2, size / 2, 0, -size / 2, size / 2, 0)
obj.pixelshader("simple_magic_circle", "tempbuffer", "tempbuffer", {
    size,
    l,
    w,
    cw,
    rv,
    n,
    m,
    draw_second_figure,
})

--テキストの描画
local tlen = string.len(text)
for i = 1, tlen do
    obj.setfont(font, tsize * ttsize / 100, 0, col)
    obj.load("text", string.sub(text, i, i))
    local tl = (l + tsize / 2) * tll / 100
    local tr = 360 * i / tlen - rv
    local tx = math.sin(tr * math.pi / 180) * tl
    local ty = -math.cos(tr * math.pi / 180) * tl
    obj.draw(tx, ty, 0, 1, 1, 0, 0, tr)
end
obj.load("tempbuffer")
