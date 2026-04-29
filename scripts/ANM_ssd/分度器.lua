---$track:サイズ
---min=1
---max=256
---step=1
local track0 = 34
---$track:桁数
---min=0
---max=5
---step=1
local track1 = 1
--dialog:文字色/col,col1=0xffffff;縁色/col,col2=0x000000;座標,pos={};
obj.setanchor("pos", 3, "line")
obj.setfont("MS UI Gothic", track0, 3, col1, col2)
local r1 = math.deg(math.atan2(pos[2] - pos[4], pos[1] - pos[3]) + math.pi)
local r2 = math.deg(math.atan2(pos[6] - pos[4], pos[5] - pos[3]) + math.pi)
local r0 = math.max(r1, r2) - math.min(r1, r2)
if r0 > 180 then
	bdk = 180 - r0 % 180
else
	bdk = r0
end
obj.load("text", math.floor(bdk * 10 ^ track1) / 10 ^ track1)
