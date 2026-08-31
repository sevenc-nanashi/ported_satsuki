--label:${ROOT_CATEGORY}\図形
---$script_tips:星型の図形を作ります。星の内角を変更できることがポイント。
---$tips:星型のサイズ(半径)を指定します。
---$track:半径
---min=1
---max=2000
local radius = 100
---$tips:星型の内角の大きさを指定します。
---$track:内角
---min=1
---max=108
local inner_angle = 36
---$tips:ライン幅を指定します。
---:数値は、100%だとライン幅ゼロ、0%だとライン表現なしになります。
---$track:ライン幅
---min=0
---max=100
local weight = 0
---$tips:ライン幅を設定した場合の、空白部分の透明度を指定します。
---$track:透明度
---min=0
---max=100
local alpha = 0
---$tips:図形の色を指定します。
---$color:色
local color = 0xffffff

local r = math.rad(inner_angle)

obj.load("figure", "四角形", color, 2)
local x = math.tan(r / 2) * radius
obj.setoption("drawtarget", "tempbuffer", radius * 2, radius * 2)
obj.drawpoly(-x, 0, 0, -x, 0, 0, 0, -radius, 0, x, 0, 0)

obj.load("tempbuffer")
obj.effect("斜めクリッピング", "中心Y", 5, "角度", inner_angle * 54 / 108)
obj.effect("斜めクリッピング", "中心Y", 5, "角度", -inner_angle * 54 / 108)
obj.setoption("dst", "tmp", radius * 2, radius * 2)
for i = 0, 4 do
    obj.draw(0, 0, 0, 1, 1, 0, 0, 72 * i)
end

obj.load("tempbuffer")
obj.setoption("drawtarget", "tempbuffer")
obj.setoption("blend", "alpha_sub")
obj.draw(0, 0, 0, weight / 100, 1 - alpha / 100)
obj.load("tempbuffer")
