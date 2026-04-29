--track0:上辺[%],-800,800,100
--track1:右辺[%],-800,800,100
--track2:下辺[%],-800,800,100
--track3:左辺[%],-800,800,100
--dialog:上辺中心[%],e=0;右辺中心[%],f=0;下辺中心[%],g=0;左辺中心[%],h=0;
a = obj.track0
b = obj.track1
c = obj.track2
d = obj.track3
e = e / 100 * obj.w / 2
f = f / 100 * obj.h / 2
g = g / 100 * obj.w / 2
h = h / 100 * obj.h / 2
obj.effect()
obj.drawpoly(
	obj.ox + (-e - obj.w / 2) * a / 100 + e,
	obj.oy + (-h - obj.h / 2) * d / 100 + h,
	0,
	obj.ox + (-e + obj.w / 2) * a / 100 + e,
	obj.oy + (-f - obj.h / 2) * b / 100 + f,
	0,
	obj.ox + (-g + obj.w / 2) * c / 100 + g,
	obj.oy + (-f + obj.h / 2) * b / 100 + f,
	0,
	obj.ox + (-g - obj.w / 2) * c / 100 + g,
	obj.oy + (-h + obj.h / 2) * d / 100 + h,
	0
)
