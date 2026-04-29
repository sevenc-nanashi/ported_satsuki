--track0:サイズ,1,1000,100,1
--track1:ライン幅,0,4000,10,1
--track2:透明度,0,100,50
--track3:明滅間隔,0,5,1,0.01
--dialog:縁色/col,col1=0xffffff;内色/col,col2=0x0000ff;明滅あり/chk,mode=0;
s1 = obj.track0
h = obj.track1
s2 = s1 - h * 2
a = obj.track2 / 100
t = obj.track3

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
