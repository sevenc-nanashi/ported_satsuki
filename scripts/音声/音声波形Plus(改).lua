--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:横分割
---min=1
---max=1024
---step=1
local wdiv = 50
---$track:縦分割
---min=1
---max=1024
---step=1
local hdiv = 50
---$track:音量
---min=0
---max=800
local track2 = 100
---$track:種類
---min=0
---max=3
---step=1
local mode = 0
---$value:横スペース(%)
local wsp = 25

---$value:縦スペース(%)
local hsp = 25

zoom = obj.getvalue("zoom") / 100
W = obj.w / zoom
H = obj.h / zoom
w = W / wdiv
h = H / hdiv
wsp0 = w * wsp / 100 / 2
hsp0 = h * hsp / 100 / 2
vol = track2 / 100
obj.setoption("drawtarget", "tempbuffer", W, H)
obj.setoption("blend", "alpha_add")

if mode < 2 then
    buf = {}
    n = obj.getaudio(buf, "audiobuffer", "spectrum", wdiv)
    for i = 0, wdiv - 1 do
        l = buf[i + 1] / 10 * vol
        l = math.min(l, H)
        x0 = -W / 2 + w * i + wsp0
        x1 = -W / 2 + w * (i + 1) - wsp0
        u0 = w * i + wsp0
        u1 = w * (i + 1) - wsp0
        for j = 0, hdiv - 1 do
            y0 = -H / 2 + h * j + hsp0
            y2 = -H / 2 + h * (j + 1) - hsp0
            v0 = h * j + hsp0
            v2 = h * (j + 1) - hsp0
            if mode == 0 then
                if l >= h * (hdiv - j) then
                    alp = 1
                else
                    alp = 0
                end
            elseif mode == 1 then
                if l >= h * (j + 1) then
                    alp = 1
                else
                    alp = 0
                end
            end
            obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, u0, v0, u1, v0, u1, v2, u0, v2, alp)
        end
    end
else
    buf = {}
    n = obj.getaudio(buf, "audiobuffer", "spectrum", hdiv)
    for j = 0, hdiv - 1 do
        l = buf[j + 1] / 10 * vol
        l = math.min(l, W)
        y0 = -H / 2 + h * j + hsp0
        y2 = -H / 2 + h * (j + 1) - hsp0
        v0 = h * j + hsp0
        v2 = h * (j + 1) - hsp0
        for i = 0, wdiv - 1 do
            x0 = -W / 2 + w * i + wsp0
            x1 = -W / 2 + w * (i + 1) - wsp0
            u0 = w * i + wsp0
            u1 = w * (i + 1) - wsp0
            if mode == 2 then
                if l >= w * (wdiv - i) then
                    alp = 1
                else
                    alp = 0
                end
            elseif mode == 3 then
                if l >= w * (i + 1) then
                    alp = 1
                else
                    alp = 0
                end
            end
            obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, u0, v0, u1, v0, u1, v2, u0, v2, alp)
        end
    end
end

obj.load("tempbuffer")
