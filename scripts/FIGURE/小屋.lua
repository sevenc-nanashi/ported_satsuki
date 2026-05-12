--label:${ROOT_CATEGORY}\カスタムオブジェクト\立体図形
---$track:サイズ
---min=0
---max=1000
---step=1
local track0 = 100
---$track:横幅比
---min=0
---max=100
local track1 = 20
---$track:奥行き
---min=0
---max=1000
local track2 = 150
---$track:角度
---min=0
---max=180
local track3 = 90
---$color:壁色
local color1 = 0xffffff

---$color:屋根色
local color2 = 0xff0000

---$value:ひさし1
local lp1 = 1.1

---$value:ひさし2
local lp2 = 1.2

---$value:屋根隙間
local d = 5

h = track0
as = track1 / 100
l = h * track2 / 100 / 2
r = track3
w = h * (1 - as) / 2

--正面、背面
obj.load("figure", "四角形", color1, h)
obj.effect("斜めクリッピング", "中心Y", -h / 2, "角度", 90 + r / 2)
obj.effect("斜めクリッピング", "中心Y", -h / 2, "角度", 270 - r / 2)
obj.effect("クリッピング", "左", h * as / 2, "右", h * as / 2)
obj.drawpoly(-w, -h, -l, w, -h, -l, w, 0, -l, -w, 0, -l)
obj.drawpoly(-w, -h, l, w, -h, l, w, 0, l, -w, 0, l)

--側面、底面
obj.load("figure", "四角形", color1, 2)
la = h - w / math.tan(math.pi / 180 * r / 2)
obj.drawpoly(-w, -la, -l, -w, -la, l, -w, 0, l, -w, 0, -l)
obj.drawpoly(w, -la, -l, w, -la, l, w, 0, l, w, 0, -l)
obj.drawpoly(w, 0, -l, w, 0, l, -w, 0, l, -w, 0, -l)

--屋根
obj.load("figure", "四角形", color2, 2)
obj.drawpoly(
    0,
    -h - d,
    -l * lp1,
    0,
    -h - d,
    l * lp1,
    -w * lp2,
    -la + (h - la) * (lp2 - 1) - d,
    l * lp1,
    -w * lp2,
    -la + (h - la) * (lp2 - 1) - d,
    -l * lp1
)
obj.drawpoly(
    0,
    -h - d,
    -l * lp1,
    0,
    -h - d,
    l * lp1,
    w * lp2,
    -la + (h - la) * (lp2 - 1) - d,
    l * lp1,
    w * lp2,
    -la + (h - la) * (lp2 - 1) - d,
    -l * lp1
)
