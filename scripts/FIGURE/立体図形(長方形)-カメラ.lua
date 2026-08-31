--label:${ROOT_CATEGORY}\図形\立体図形
---$script_tips:長方形の立体図形を作ります。
---:カメラ制御下で使用して下さい。
---:星型の立体図形を作ります。
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
---$tips:図形の縦横比を指定します。
---$track:縦横比
---min=-100
---max=100
local aspect = 0
---$tips:図形の色を指定します。
---$color:色
local color = 0xffffff

local h = math.min(weight, size / 2)
local asx = math.max(aspect, 0)
local asy = math.max(-aspect, 0)

obj.load("figure", "四角形", color, size, h)
obj.effect()
local x0 = size / 2 * (1 - asx / 100)
local y0 = size / 2 * (1 - asy / 100)
obj.drawpoly(-x0, -y0, length / 2, x0, -y0, length / 2, x0, y0, length / 2, -x0, y0, length / 2)
obj.drawpoly(-x0, -y0, -length / 2, x0, -y0, -length / 2, x0, y0, -length / 2, -x0, y0, -length / 2)

for k = 0, 1 do
    size = size - 2 * h * k
    obj.load("figure", "四角形", color, size / 2)
    obj.effect()
    x0 = size / 2 * (1 - asx / 100)
    y0 = -size / 2 * (1 - asy / 100)
    obj.drawpoly(x0, y0, -length / 2, x0, y0, length / 2, x0, -y0, length / 2, x0, -y0, -length / 2)
    obj.drawpoly(-x0, y0, -length / 2, -x0, y0, length / 2, -x0, -y0, length / 2, -x0, -y0, -length / 2)
    obj.drawpoly(-x0, y0, -length / 2, -x0, y0, length / 2, x0, y0, length / 2, x0, y0, -length / 2)
    obj.drawpoly(-x0, -y0, -length / 2, -x0, -y0, length / 2, x0, -y0, length / 2, x0, -y0, -length / 2)
end
