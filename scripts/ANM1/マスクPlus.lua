--track0:X,-4000,4000,0
--track1:Y,-4000,4000,0
--track2:サイズ,0,2000,100,1
--track3:回転,-720,720,0
--dialog:マスクの種類/fig,fig="円";ライン幅,line=4000;Xスケール[%],asx=100;Yスケール[%],asy=100;透明度[%],alp=0;ぼかし,br=0;

obj.copybuffer("tmp", "obj")
obj.alpha = 0

obj.setoption("dst", "tmp")
obj.load("figure", fig, 0xffffff, obj.track2, line)
obj.effect("ぼかし", "範囲", br)
obj.setoption("blend", "alpha_sub")
cx, cy = obj.track0, obj.track1
w, h = obj.w / 2, obj.h / 2
l = math.sqrt((w * asx / 100) ^ 2 + (h * asy / 100) ^ 2)
r = math.rad(obj.track3)
x0 = cx + math.cos(math.atan2(-h * asy / 100, -w * asx / 100) + r) * l
x1 = cx + math.cos(math.atan2(-h * asy / 100, w * asx / 100) + r) * l
x2 = cx + math.cos(math.atan2(h * asy / 100, w * asx / 100) + r) * l
x3 = cx + math.cos(math.atan2(h * asy / 100, -w * asx / 100) + r) * l
y0 = cy + math.sin(math.atan2(-h * asy / 100, -w * asx / 100) + r) * l
y1 = cy + math.sin(math.atan2(-h * asy / 100, w * asx / 100) + r) * l
y2 = cy + math.sin(math.atan2(h * asy / 100, w * asx / 100) + r) * l
y3 = cy + math.sin(math.atan2(h * asy / 100, -w * asx / 100) + r) * l
obj.drawpoly(x0, y0, 0, x1, y1, 0, x2, y2, 0, x3, y3, 0, 0, 0, w * 2, 0, w * 2, h * 2, 0, h * 2, 1 - alp / 100)

obj.load("tempbuffer")
