--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:半径
---min=0
---max=1000
local track0 = 100
---$track:高さ
---min=0
---max=800
local track1 = 100
---$track:横分割
---min=1
---max=1024
---step=1
local track2 = 15
---$track:縦分割
---min=1
---max=100
---step=1
local track3 = 25
---$value:縦隙間(%)
local ch = 2

---$value:横隙間
local cw = 2

obj.effect()
hh = obj.track1 / 100
div = obj.track2
m = obj.track3
buf = {}
n = obj.getaudio(buf, "audiobuffer", "spectrum", div)
w = obj.w / n
h = obj.h / m
r = obj.w / math.pi / 2 * obj.track0 / 100
for i = 1, n do
    l = buf[i] / 10 * hh
    l = math.min(l, obj.h)
    x0 = r * math.sin(math.pi * 2 * i / n + ch / 100)
    x1 = r * math.sin(math.pi * 2 * (i + 1) / n - ch / 100)
    z0 = -r * math.cos(math.pi * 2 * i / n + ch / 100)
    z1 = -r * math.cos(math.pi * 2 * (i + 1) / n - ch / 100)
    u0, u1 = (i - 1) * w + cw, i * w - cw
    for j = 0, m - 1 do
        y0, y2 = -obj.h / 2 + h * j + ch, -obj.h / 2 + h * (j + 1) - ch
        v0, v2 = h * j + ch, h * (j + 1) - ch
        if l >= h * (m - j) then
            alpha = 1
        else
            alpha = 0
        end
        obj.drawpoly(
            x0,
            y0,
            z0,
            x1 + 1,
            y0,
            z1,
            x1 + 1,
            y2,
            z1,
            x0,
            y2,
            z0,
            u0,
            v0,
            u1 + 1,
            v0,
            u1 + 1,
            v2,
            u0,
            v2,
            alpha
        )
    end
end
