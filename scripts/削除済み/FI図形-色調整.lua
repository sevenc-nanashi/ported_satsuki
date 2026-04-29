---$track:サイズ
---min=0
---max=2000
local track0 = 100
---$track:赤
---min=0
---max=255
local track1 = 255
---$track:緑
---min=0
---max=255
local track2 = 255
---$track:青
---min=0
---max=255
local track3 = 255
--dialog:種類/fig,name="円";
r = math.floor(track1)
g = math.floor(track2)
b = math.floor(track3)
color = string.format("0x%02x%02x%02x", r, g, b)
obj.load("figure", name, color, track0, 1000)
