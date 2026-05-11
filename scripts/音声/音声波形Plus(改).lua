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

local zoom = obj.getvalue("zoom") / 100
local W = obj.w / zoom
local H = obj.h / zoom
local w = W / wdiv
local h = H / hdiv
local wsp0 = w * wsp / 100 / 2
local hsp0 = h * hsp / 100 / 2
local vol = track2 / 100
obj.setoption("drawtarget", "tempbuffer", W, H)
obj.setoption("blend", "alpha_add")

local polygons = {}
if mode < 2 then
    local buf = {}
    obj.getaudio(buf, "audiobuffer", "spectrum", wdiv)
    for i = 0, wdiv - 1 do
        local l = buf[i + 1] / 10 * vol
        l = math.min(l, H)
        local x0 = -W / 2 + w * i + wsp0
        local x1 = -W / 2 + w * (i + 1) - wsp0
        local u0 = w * i + wsp0
        local u1 = w * (i + 1) - wsp0
        for j = 0, hdiv - 1 do
            local y0 = -H / 2 + h * j + hsp0
            local y2 = -H / 2 + h * (j + 1) - hsp0
            local v0 = h * j + hsp0
            local v2 = h * (j + 1) - hsp0
            local alp
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
            if alp > 0 then
                table.insert(polygons, {x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, u0, v0, u1, v0, u1, v2, u0, v2})
            end
        end
    end
else
    local buf = {}
    obj.getaudio(buf, "audiobuffer", "spectrum", hdiv)
    for j = 0, hdiv - 1 do
        local l = buf[j + 1] / 10 * vol
        l = math.min(l, W)
        local y0 = -H / 2 + h * j + hsp0
        local y2 = -H / 2 + h * (j + 1) - hsp0
        local v0 = h * j + hsp0
        local v2 = h * (j + 1) - hsp0
        for i = 0, wdiv - 1 do
            local x0 = -W / 2 + w * i + wsp0
            local x1 = -W / 2 + w * (i + 1) - wsp0
            local u0 = w * i + wsp0
            local u1 = w * (i + 1) - wsp0
            local alp
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
            if alp > 0 then
                table.insert(polygons, {x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, u0, v0, u1, v0, u1, v2, u0, v2})
            end
        end
    end
end
obj.drawpoly(polygons)

obj.load("tempbuffer")
