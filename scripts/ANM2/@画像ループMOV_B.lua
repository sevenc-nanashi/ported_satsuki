--label:${ROOT_CATEGORY}\配置
---$track:再生速度
---min=0
---max=800
local track0 = 100
---$track:再生位置
---min=0
---max=300
---step=0.01
local track1 = 0
--file:
v = obj.track0 / 100
f = obj.track1
tt = obj.load(file)
for j = 0, ny - 1 do
    y = -gy * (ny - 1) / 2 + j * gy
    for i = 0, nx - 1 do
        x = -gx * (nx - 1) / 2 + i * gx
        if yd == 1 and j % 2 == 0 then
            x = x + gx / 2
        end
        obj.load(file, (f + tt * obj.rand(0, 100, i, j) / 100 + obj.time * v) % tt)
        obj.effect()
        obj.draw(x, y)
    end
end
