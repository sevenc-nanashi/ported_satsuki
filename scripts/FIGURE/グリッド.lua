---$track:ライン幅
---min=1
---max=100
local l0 = 2
---$track:間隔
---min=1
---max=100
local l1 = 10
---$track:X範囲
---min=0
---max=500
local track2 = 100
---$track:Y範囲
---min=0
---max=500
local track3 = 100
---$color:色
local color = 0x0000ff

---$check:横線のみ
local yoko = 0

obj.load("figure", "四角形", color, 2)
w = obj.screen_w * track2 / 100
h = obj.screen_h * track3 / 100
n = math.floor(math.max(w, h) / (l0 + l1) / 2)
obj.setoption("dst", "tmp", w, h)
for i = -n - 1, n do
	y0 = (l0 + l1) * i
	y2 = l0 + (l0 + l1) * i
	obj.drawpoly(-w / 2, y0, 0, w / 2, y0, 0, w / 2, y2, 0, -w / 2, y2, 0)
	if yoko == 0 then
		obj.drawpoly(y0, -h / 2, 0, y2, -h / 2, 0, y2, h / 2, 0, y0, h / 2, 0)
	end
end
obj.load("tempbuffer")
