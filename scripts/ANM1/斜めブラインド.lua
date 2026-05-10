--label:${ROOT_CATEGORY}\切り替え効果
---$track:割合
---min=0
---max=100
local track0 = 50
---$track:幅
---min=10
---max=800
local haba = 30
---$track:角度
---min=-360
---max=360
local track2 = 60
---$track:時間
---min=-5
---max=5
---step=0.01
local t = 0.50
---$check:時間指定で登場
local __rename_me_check0 = false

obj.copybuffer("tmp", "obj")

local d = 1 - track0 / 100
if __rename_me_check0 then
    if t == 0 then
        return
    elseif t < 0 then
        d = (t - obj.time + obj.totaltime) / t
    else
        d = (t - obj.time) / t
    end
    d = math.max(d, 0)
end
local ww, hh = obj.getpixel()
local r = math.rad(track2)
local w = math.sqrt(ww ^ 2 + hh ^ 2) / 2
local n = math.ceil(w / haba) + 2
local ls = math.sqrt(w ^ 2 + haba ^ 2)

obj.setoption("dst", "tmp")
obj.setoption("blend", "alpha_sub")
obj.load("figure", "四角形", 0xffffff, 2)
for i = -n, n - 1 do
    l = haba * i
    cx = math.sin(r) * l
    cy = -math.cos(r) * l
    x0 = cx + math.cos(math.atan2(0, -w) + r) * w
    x1 = cx + math.cos(math.atan2(0, w) + r) * w
    x2 = cx + math.cos(math.atan2(haba * d, w) + r) * ls
    x3 = cx + math.cos(math.atan2(haba * d, -w) + r) * ls
    y0 = cy + math.sin(math.atan2(0, -w) + r) * w
    y1 = cy + math.sin(math.atan2(0, w) + r) * w
    y2 = cy + math.sin(math.atan2(haba * d, w) + r) * ls
    y3 = cy + math.sin(math.atan2(haba * d, -w) + r) * ls
    obj.drawpoly(x0, y0, 0, x1, y1, 0, x2, y2, 0, x3, y3, 0)
end
obj.load("tempbuffer")
