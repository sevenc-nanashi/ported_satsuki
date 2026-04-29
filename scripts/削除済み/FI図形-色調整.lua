--track0:サイズ,0,2000,100
--track1:赤,0,255,255
--track2:緑,0,255,255
--track3:青,0,255,255
--dialog:種類/fig,name="円";
r = math.floor(obj.track1)
g = math.floor(obj.track2)
b = math.floor(obj.track3)
color = string.format("0x%02x%02x%02x", r, g, b)
obj.load("figure", name, color, obj.track0, 1000)
