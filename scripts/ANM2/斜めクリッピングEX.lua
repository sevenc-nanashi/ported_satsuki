--label:${ROOT_CATEGORY}\クリッピング
---$track:個数
---min=1
---max=100
---step=1
local num = 3
---$track:幅
---min=0
---max=2000
---step=1
local width = 20
---$track:増加範囲
---min=0
---max=300
local width_random = 0
---$track:乱数
---min=0
---max=100
---step=1
local f = 0
if width >= 1 then
    for i = 0, num - 1 do
        local haba = width * obj.rand(100, width_random + 100, i, f + 3) / 100
        local r = obj.rand(0, 180, i, f)
        local cx = obj.rand(-obj.w, obj.w, i, f + 1) / 2
        local cy = obj.rand(-obj.h, obj.h, i, f + 2) / 2
        obj.effect("斜めクリッピング", "中心X", cx, "中心Y", cy, "角度", r, "幅", -haba)
    end
end
