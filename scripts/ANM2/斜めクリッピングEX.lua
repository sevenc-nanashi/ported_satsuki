--label:${ROOT_CATEGORY}\クリッピング
---$track:個数
---min=1
---max=100
---step=1
local n = 3
---$track:幅
---min=0
---max=2000
---step=1
local track1 = 20
---$track:増加範囲
---min=0
---max=300
local track2 = 0
---$track:乱数
---min=0
---max=100
---step=1
local f = 0
if track1 >= 1 then
    for i = 0, n - 1 do
        haba = track1 * obj.rand(100, track2 + 100, i, f + 3) / 100
        r = obj.rand(0, 180, i, f)
        cx = obj.rand(-obj.w, obj.w, i, f + 1) / 2
        cy = obj.rand(-obj.h, obj.h, i, f + 2) / 2
        obj.effect("斜めクリッピング", "中心X", cx, "中心Y", cy, "角度", r, "幅", -haba)
    end
end
