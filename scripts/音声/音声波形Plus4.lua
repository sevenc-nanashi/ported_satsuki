--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:分割数
---min=2
---max=1024
---step=1
local n_divisions = 51
---$track:ライン幅
---min=1
---max=100
local weight = 3
---$track:横幅
---min=1
---max=2000
local width = 640
---$track:閾値
---min=1
---max=2000
---step=1
local threshold = 500
---$track:高さ[%]
---min=0
---max=800
---step=0.1
local height = 150

---$color:色
local color = 0x00ff00

---$check:尖鋭化
local kaku = 1

---$check:閾値を減算
local sist = 1

local l = weight / 2
local siki = threshold * 10
local w = width / (n_divisions - 1)
local bun = math.floor(1024 / n_divisions)
local buf = {}
obj.getaudio(buf, "audiobuffer", "pcm", 1024)
obj.setoption("dst", "tmp", width, width)

--ラインの描画
-- obj.setoption("blend", "alpha_mix")
obj.load("figure", "四角形", color, 1)
local y0 = 0
local y1 = 0
local polygons = {}
for i = 1, n_divisions - 1 do
    local x0 = (i - 1) * w - width / 2
    local x1 = i * w - width / 2
    if math.abs(buf[bun * (i + 1)]) > siki then
        if buf[bun * (i + 1)] > 0 then
            y1 = -(buf[bun * (i + 1)] - siki * sist) / 200 * height / 100
        else
            y1 = -(buf[bun * (i + 1)] + siki * sist) / 200 * height / 100
        end
    end
    if kaku == 1 then
        if i % 2 == 1 then
            y0 = 0
        else
            y1 = 0
        end
    end
    local r = math.atan2(y0 - y1, x1 - x0)
    local dx = math.sin(r) * l
    local dy = math.cos(r) * l
    table.insert(polygons, {
        x0 - dx,
        y0 - dy,
        0,
        x1 - dx,
        y1 - dy,
        0,
        x1 + dx,
        y1 + dy,
        0,
        x0 + dx,
        y0 + dy,
        0,
        0,
        0,
        obj.w,
        0,
        obj.w,
        obj.h,
        0,
        obj.h,
    })
    y0 = y1
end
obj.drawpoly(polygons)

local polygons2 = {}
--頂点の描画
obj.load("figure", "円", color, l * 8)
for i = 1, n_divisions - 1 do
    local x0 = (i - 1) * w - width / 2
    local y0 = 0
    if math.abs(buf[bun * i]) > siki then
        if buf[bun * i] > 0 then
            y0 = -(buf[bun * i] - siki * sist) / 200 * height / 100
        else
            y0 = -(buf[bun * i] + siki * sist) / 200 * height / 100
        end
    end
    if kaku == 1 and i % 2 == 1 then
        y0 = 0
    end
    table.insert(polygons2, {
        x0 - l,
        y0 - l,
        0,
        x0 + l,
        y0 - l,
        0,
        x0 + l,
        y0 + l,
        0,
        x0 - l,
        y0 + l,
        0,
        0,
        0,
        obj.w,
        0,
        obj.w,
        obj.h,
        0,
        obj.h,
    })
end
obj.drawpoly(polygons2)

obj.load("tempbuffer")
