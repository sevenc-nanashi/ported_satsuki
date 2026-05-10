--label:${ROOT_CATEGORY}\加工
---$track:サイズ
---min=10
---max=500
local l = 50
---$track:ライン幅
---min=0
---max=50
local track1 = 2
---$track:横サイズ
---min=0
---max=4000
local w = 800
---$track:縦サイズ
---min=0
---max=4000
local h = 450
---$color:色1
local col1 = 0x000000

---$color:色2(負値で透明)
local col2 = 0xffffff

local d = math.min(track1, 3 / (6 + 4 * math.sqrt(3)) * l)
local sl = l - (4 / math.sqrt(3) + 2) * d

obj.setoption("drawtarget", "tempbuffer", w, h)

--ライン
obj.load("figure", "四角形", col1, 2)
obj.drawpoly(-w / 2, -h / 2, 0, w / 2, -h / 2, 0, w / 2, h / 2, 0, -w / 2, h / 2, 0)

--三角

if col2 <= 0 then
    obj.setoption("blend", "alpha_sub")
else
    obj.setoption("blend", "alpha_add2")
    obj.load("figure", "四角形", col2, 2)
end

ny_n = math.floor(h / l / math.sqrt(3)) + 1
nx_n = math.floor(w / l / 3) + 1

if d > 0 then
    for ny = 0, ny_n do
        yy = -h / 2 + l * math.sqrt(3) * ny
        for nx = 0, nx_n do
            xx = -w / 2 + l * 3 * nx
            for k = 0, 3 do
                for i = 0, 2 do
                    xa0 = xx + l * math.cos(math.rad(k * 60)) + d * math.cos(math.rad(i * 120 + k * 60))
                    ya0 = yy + l * math.sin(math.rad(k * 60)) + d * math.sin(math.rad(i * 120 + k * 60))
                    xa1 = xa0 + sl * math.cos(math.rad(60 + i * 120 + k * 60))
                    ya1 = ya0 + sl * math.sin(math.rad(60 + i * 120 + k * 60))
                    xa2 = xa0 + sl * math.cos(math.rad(-60 + i * 120 + k * 60))
                    ya2 = ya0 + sl * math.sin(math.rad(-60 + i * 120 + k * 60))
                    obj.drawpoly(xa0, ya0, 0, xa1, ya1, 0, xa2, ya2, 0, xa0, ya0, 0)
                end
            end
        end
    end
else
    obj.drawpoly(-w / 2, -h / 2, 0, w / 2, -h / 2, 0, w / 2, h / 2, 0, -w / 2, h / 2, 0)
end

obj.load("tempbuffer")
