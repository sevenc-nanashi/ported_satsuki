---$track:サイズ
---min=1
---max=1000
---step=1
local s1 = 100
---$track:ライン幅
---min=0
---max=4000
---step=1
local h = 10
---$track:透明度
---min=0
---max=100
local track2 = 50
---$track:明滅間隔
---min=0
---max=5
---step=0.01
local t = 1
---$color:縁色
local col1 = 0xffffff

---$color:内色
local col2 = 0x0000ff

---$check:明滅あり
local mode = 0

s2 = s1 - h * 2
a = track2 / 100

if mode < 1 then
	alp = a
else
	alp = (math.sin(2 * math.pi * obj.time * (1 / t)) * 0.5 + 0.5) * a
end

obj.load("figure", "四角形", col1, s1, h)
obj.effect()
l = obj.w / 2
obj.drawpoly(-l, -l, -l, l, -l, -l, l, l, -l, -l, l, -l)
obj.drawpoly(l, -l, l, -l, -l, l, -l, l, l, l, l, l)
obj.drawpoly(-l, l, -l, l, l, -l, l, l, l, -l, l, l)
obj.drawpoly(l, -l, -l, -l, -l, -l, -l, -l, l, l, -l, l)
obj.drawpoly(l, -l, -l, l, -l, l, l, l, l, l, l, -l)
obj.drawpoly(-l, -l, l, -l, -l, -l, -l, l, -l, -l, l, l)

obj.load("figure", "四角形", col2, s2)
obj.effect()
l = obj.w / 2
obj.alpha = alp
obj.drawpoly(-l, -l, -l - h, l, -l, -l - h, l, l, -l - h, -l, l, -l - h)
obj.drawpoly(l, -l, l + h, -l, -l, l + h, -l, l, l + h, l, l, l + h)
obj.drawpoly(-l, l + h, -l, l, l + h, -l, l, l + h, l, -l, l + h, l)
obj.drawpoly(l, -l - h, -l, -l, -l - h, -l, -l, -l - h, l, l, -l - h, l)
obj.drawpoly(l + h, -l, -l, l + h, -l, l, l + h, l, l, l + h, l, -l)
obj.drawpoly(-l - h, -l, l, -l - h, -l, -l, -l - h, l, -l, -l - h, l, l)
