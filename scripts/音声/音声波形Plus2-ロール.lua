--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:半径
---min=0
---max=1000
local radius = 100
---$track:高さ
---min=0
---max=800
local height = 100
---$track:横分割
---min=1
---max=1024
---step=1
local n_divs_h = 15
---$track:縦分割
---min=1
---max=100
---step=1
local n_divs_v = 25
---$track:縦隙間(%)
---min=0
---max=100
---step=0.01
local ch = 2

---$track:横隙間
---min=0
---max=100
---step=0.01
local cw = 2

obj.effect()
local hh = height / 100
local div = n_divs_h
local m = n_divs_v
local buf = {}
local n = obj.getaudio(buf, "audiobuffer", "spectrum", div)
local w = obj.w / n
local h = obj.h / m
local r = obj.w / math.pi / 2 * radius / 100
local polygons = {}
for i = 1, n do
    local l = buf[i] / 10 * hh
    l = math.min(l, obj.h)
    local x0 = r * math.sin(math.pi * 2 * i / n + ch / 100)
    local x1 = r * math.sin(math.pi * 2 * (i + 1) / n - ch / 100)
    local z0 = -r * math.cos(math.pi * 2 * i / n + ch / 100)
    local z1 = -r * math.cos(math.pi * 2 * (i + 1) / n - ch / 100)
    local u0, u1 = (i - 1) * w + cw, i * w - cw
    for j = 0, m - 1 do
        local y0, y2 = -obj.h / 2 + h * j + ch, -obj.h / 2 + h * (j + 1) - ch
        local v0, v2 = h * j + ch, h * (j + 1) - ch
        local alpha
        if l >= h * (m - j) then
            alpha = 1
        else
            alpha = 0
        end
        if alpha > 0 then
            table.insert(polygons, {
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
            })
        end
    end
end

obj.setoption("draw_state", true)
if #polygons > 0 then
    obj.drawpoly(polygons)
end
