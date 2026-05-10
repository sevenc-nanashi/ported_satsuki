--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:分割数
---min=2
---max=1024
---step=1
local n = 51
---$track:ライン幅
---min=1
---max=100
local track1 = 3
---$track:横幅
---min=1
---max=2000
local W = 640
---$track:閾値
---min=1
---max=2000
---step=1
local track3 = 500
---$value:高さ[%]
local H = 150

---$color:色
local color = 0x00ff00

---$check:尖鋭化
local kaku = 1

---$check:閾値を減算
local sist = 1

l = track1 / 2
siki = track3 * 10
w = W / (n - 1)
bun = math.floor(1024 / n)
buf = {}
obj.getaudio(buf, "audiobuffer", "pcm", 1024)
obj.setoption("dst", "tmp", W, W)

--ラインの描画
-- obj.setoption("blend", "alpha_mix")
obj.load("figure", "四角形", color, 1)
y0 = 0
y1 = 0
for i = 1, n - 1 do
    x0 = (i - 1) * w - W / 2
    x1 = i * w - W / 2
    if math.abs(buf[bun * (i + 1)]) > siki then
        if buf[bun * (i + 1)] > 0 then
            y1 = -(buf[bun * (i + 1)] - siki * sist) / 200 * H / 100
        else
            y1 = -(buf[bun * (i + 1)] + siki * sist) / 200 * H / 100
        end
    end
    if kaku == 1 then
        if i % 2 == 1 then
            y0 = 0
        else
            y1 = 0
        end
    end
    r = math.atan2(y0 - y1, x1 - x0)
    dx = math.sin(r) * l
    dy = math.cos(r) * l
    obj.drawpoly(x0 - dx, y0 - dy, 0, x1 - dx, y1 - dy, 0, x1 + dx, y1 + dy, 0, x0 + dx, y0 + dy, 0)
    y0 = y1
end

--頂点の描画
obj.load("figure", "円", color, l * 8)
for i = 1, n - 1 do
    x0 = (i - 1) * w - W / 2
    y0 = 0
    if math.abs(buf[bun * i]) > siki then
        if buf[bun * i] > 0 then
            y0 = -(buf[bun * i] - siki * sist) / 200 * H / 100
        else
            y0 = -(buf[bun * i] + siki * sist) / 200 * H / 100
        end
    end
    if kaku == 1 and i % 2 == 1 then
        y0 = 0
    end
    obj.drawpoly(x0 - l, y0 - l, 0, x0 + l, y0 - l, 0, x0 + l, y0 + l, 0, x0 - l, y0 + l, 0)
end

obj.load("tempbuffer")
