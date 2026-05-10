--label:${ROOT_CATEGORY}\配置
---$track:個数
---min=1
---max=200
---step=1
local n = 5
---$track:間隔
---min=-1000
---max=1000
local l = 50
---$track:角度
---min=-720
---max=720
local track2 = 0
---$track:回転軸
---min=0
---max=2
---step=1
local track3 = 0
---$check:双方向
local __rename_me_check0 = false

obj.effect()
r = track2 + 90
w, h = obj.w, obj.h
aa = 0
bb = n - 1
if __rename_me_check0 then
    aa = -n + 1
    bb = n - 1
end
for i = aa, bb do
    sin = math.sin(r * math.pi / 180) * l * i
    cos = -math.cos(r * math.pi / 180) * l * i
    if track3 < 1 then
        cx = sin
        cy = cos
        z = 0
    elseif track3 < 2 then
        cx = sin
        cy = 0
        z = cos
    else
        cx = 0
        cy = cos
        z = sin
    end
    x0, x1 = cx - w / 2, cx + w / 2
    y0, y2 = cy - h / 2, cy + h / 2
    obj.drawpoly(x0, y0, z, x1, y0, z, x1, y2, z, x0, y2, z)
end
