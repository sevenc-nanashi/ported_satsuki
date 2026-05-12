--label:${ROOT_CATEGORY}\変形
---$track:伸度
---min=0
---max=800
local length = 0
---$track:幅[%]
---min=0.1
---max=100
local width = 10
---$track:基準[%]
---min=-100
---max=100
local basis = 0
---$track:中心[%]
---min=-100
---max=100
local center = 0
---$check:縦方向
local dir = 0

---$check:幅部分を表示
local alp = 0

obj.effect()
local w = obj.w / 2
local h = obj.h / 2
if dir < 1 then
    local natto = obj.w * length / 100
    local haba = obj.w * width / 100
    local c = (obj.w - haba) / 2 * basis / 100
    local t = natto * center / 100

    local c0 = c - haba / 2 - natto + t
    local c1 = c + haba / 2 + natto + t
    local x0 = -w - natto + t
    local x1 = w + natto + t
    local u0 = w + c - haba / 2
    local u1 = w + c + haba / 2
    obj.drawpoly(x0, -h, 0, c0 + 1, -h, 0, c0 + 1, h, 0, x0, h, 0, 0, 0, u0 + 1, 0, u0 + 1, h * 2, 0, h * 2)
    obj.drawpoly(c1 - 1, -h, 0, x1, -h, 0, x1, h, 0, c1 - 1, h, 0, u1 - 1, 0, w * 2, 0, w * 2, h * 2, u1 - 1, h * 2)
    obj.drawpoly(c0, -h, 0, c1, -h, 0, c1, h, 0, c0, h, 0, u0, 0, u1, 0, u1, h * 2, u0, h * 2, 1 - alp / 2)
else
    local natto = obj.h * length / 100
    local haba = obj.h * width / 100
    local c = (obj.h - haba) / 2 * basis / 100
    local t = natto * center / 100

    local c0 = c - haba / 2 - natto + t
    local c1 = c + haba / 2 + natto + t
    local y0 = -h - natto + t
    local y1 = h + natto + t
    local v0 = h + c - haba / 2
    local v1 = h + c + haba / 2
    obj.drawpoly(-w, y0, 0, w, y0, 0, w, c0 + 1, 0, -w, c0 + 1, 0, 0, 0, w * 2, 0, w * 2, v0 + 1, 0, v0 + 1)
    obj.drawpoly(-w, c1 - 1, 0, w, c1 - 1, 0, w, y1, 0, -w, y1, 0, 0, v1 - 1, w * 2, v1 - 1, w * 2, h * 2, 0, h * 2)
    obj.drawpoly(-w, c0, 0, w, c0, 0, w, c1, 0, -w, c1, 0, 0, v0, w * 2, v0, w * 2, v1, 0, v1, 1 - alp / 2)
end
