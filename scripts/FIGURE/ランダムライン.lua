--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:本数
---min=1
---max=400
---step=1
local n = 10
---$track:幅
---min=0
---max=100
local dw0 = 2
---$track:幅[+%]
---min=0
---max=200
---step=1
local dwr = 50
---$track:斜閾値
---min=0
---max=300
---step=1
local k = 50
---$color:色
local col = 0xff8000

---$check:ランダム変化
local chk = 1

local w = obj.screen_w / 2
local h = obj.screen_h / 2
local L = math.sqrt(obj.screen_w ^ 2, obj.screen_h / 2 ^ 2) * 2
local ran = 0
if chk == 1 then
    ran = obj.rand(0, 100)
end

obj.setoption("dst", "tmp", w * 2 + 100, h * 2 + 100)
obj.load("figure", "四角形", col, 2)
local figure_w = obj.w
local figure_h = obj.h
local vertices = {}

for i = 0, n - 1 do
    local cx = obj.rand(-w, w, i, ran + 0)
    local cy = obj.rand(-h, h, i, ran + 1)
    local dw = dw0 * (1 + obj.rand(0, dwr, i, ran + 2) / 100)
    local r_jud = obj.rand(0, 200 + k, i, ran + 3)
    local r
    if r_jud <= 100 then
        r = 0
    elseif r_jud <= 200 then
        r = math.rad(90)
    else
        r = math.rad(obj.rand(0, 180, i, ran + 4))
    end

    local cos_r = math.cos(r)
    local sin_r = math.sin(r)
    local half_dw = dw / 2
    local half_L = L / 2
    local x0 = cx - half_dw * cos_r + half_L * sin_r
    local x1 = cx + half_dw * cos_r + half_L * sin_r
    local x2 = cx + half_dw * cos_r - half_L * sin_r
    local x3 = cx - half_dw * cos_r - half_L * sin_r
    local y0 = cy - half_dw * sin_r - half_L * cos_r
    local y1 = cy + half_dw * sin_r - half_L * cos_r
    local y2 = cy + half_dw * sin_r + half_L * cos_r
    local y3 = cy - half_dw * sin_r + half_L * cos_r

    vertices[#vertices + 1] = {
        x0,
        y0,
        0,
        x1,
        y1,
        0,
        x2,
        y2,
        0,
        x3,
        y3,
        0,
        0,
        0,
        figure_w,
        0,
        figure_w,
        figure_h,
        0,
        figure_h,
    }
end
obj.drawpoly(vertices)
obj.load("tempbuffer")
