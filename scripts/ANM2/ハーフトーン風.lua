---$script_tips:元画像の輝度に合わせて、図形やテキストを配置します。
--label:${ROOT_CATEGORY}\カスタムオブジェクト
--group:サイズ
---$tips:配置する図形のサイズを指定します。
---:小さな値だと非常に重くなるので注意が必要です。
---$track:val::サイズ
---min=5
---max=200
local size = 50

---$tips:チェックしていない場合は、元画像の輝度に応じて図形のサイズが異なりますが、
---:チェックすると、図形のサイズが均一となります。
---:図形を表示する割合は「size閾値」で指定します。
---$check:サイズ二値化
local nt = 0
---$tips:「サイズ二値化」にチェックした場合に有効な項目です。
---:図形を表示する割合を指定します。
---$track:サイズ閾値
---min=0
---max=100
local size_threshold = 50

--group:透明度
---$tips:チェックしていない場合は、元画像の透明度に応じて図形の透明度が異なりますが、
---:チェックすると、図形の透明度が均一となります。
---:図形を表示する割合は「透明閾値」で指定します。
---$check:透明二値化
local nta = 0
---$tips:「透明二値化」にチェックした場合に有効な項目です。
---:図形を表示する割合を指定します。
---$track:透明閾値
---min=0
---max=100
local alpha_threshold = 50

--group

---$tips:個別の図形等を回転させます。
---$track:回転
---min=-720
---max=720
local rr = 0

---$tips:配置する図形の色を指定します。
---:負の値に設定すると、元画像の色を取得します。
---$color:色
local col = nil

---$tips:チェックすると図形を配置する位置を反転します。
---$check:反転
local inverted = 0

---$tips:配置した個別の図形の拡大率を変更します。
---$track:個別拡大[%]
---min=0
---max=200
---step=1
local ss = 100

--group:図形
---$tips:チェックすると図形ではなく文字を配置します。
---$check:val::文字
local tex = 0

---$tips:配置する図形の種類を指定します。
---$figure:図形
local fig = "円"

---$tips:文字の内容を入力して下さい。基本的に全角一文字のみ。
---$string:文字(文字)
local text = "＋"

---$tips:文字のフォントを指定します。
---$font:文字(font)
local font = "MS UI Gothic"

--hide@size_threshold:nt==0
--hide@alpha_threshold:nta==0
--hide@fig:tex==1
--hide@text:tex==0
--hide@font:tex==0

obj.effect("反転", "輝度反転", inverted)
local w = obj.w * 100 / obj.getvalue("zoom")
local h = obj.h * 100 / obj.getvalue("zoom")
local s = math.min(size, w, h)
local si = size_threshold / 100
local sia = alpha_threshold / 100
local use_source_color = col == nil or col < 0
local draw_col = use_source_color and 0xffffff or col

--[[pixelshader@halftone:
---$include "./shaders/halftone.hlsl"
]]
obj.copybuffer("cache:original", "object")
obj.setoption("drawtarget", "tempbuffer", s, s)
if tex < 1 then
    obj.load("figure", fig, draw_col, s)
else
    obj.setfont(font, s, 0, draw_col)
    obj.load("text", text)
end
obj.draw()
obj.copybuffer("cache:figure", "tempbuffer")
obj.copybuffer("object", "cache:original")
obj.setoption("drawtarget", "framebuffer")
obj.pixelshader("halftone", "object", { "object", "cache:figure" }, {
    s,
    si,
    sia,
    nt,
    nta,
    ss / 100,
    math.rad(rr),
    w,
    h,
    use_source_color and 1 or 0,
})
