--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:サイズ
---min=1
---max=256
---step=1
local size = 34
---$track:桁数
---min=0
---max=5
---step=1
local digits = 1
---$color:文字色
local col1 = 0xffffff

---$color:縁色
local col2 = 0x000000

---$value:座標
local pos = { 0, -100, 0, 0, 100, 0 }

obj.setanchor("pos", 3, "line")
obj.setfont("MS UI Gothic", size, 3, col1, col2)
local r1 = math.deg(math.atan2(pos[2] - pos[4], pos[1] - pos[3]) + math.pi)
local r2 = math.deg(math.atan2(pos[6] - pos[4], pos[5] - pos[3]) + math.pi)
local r0 = math.max(r1, r2) - math.min(r1, r2)
local bdk
if r0 > 180 then
    bdk = 180 - r0 % 180
else
    bdk = r0
end
obj.load("text", math.floor(bdk * 10 ^ digits) / 10 ^ digits)
