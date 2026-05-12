--label:${ROOT_CATEGORY}\カスタムオブジェクト\削除済み
---$track:高さ
---min=0
---max=900
local h = 10
---$track:長さ
---min=0
---max=1600
local w = 400
---$track:縁
---min=0
---max=20
local f = 5
---$color:縁色
local wcolor = 0x555555

local a, bb
for i = 0, 2 do
    if i == 0 then
        obj.load("figure", "背景", wcolor, 100)
        a = (obj.screen_h - h) / 2
        bb = (obj.screen_w - w) / 2
        obj.effect("クリッピング", "上", a - f, "下", a - f, "右", bb - f, "左", bb - f)
        obj.effect("凸エッジ")
    elseif i == 1 then
        obj.load("figure", "背景", 0x000000, 100)
        obj.effect("クリッピング", "上", a, "下", a, "右", bb, "左", bb)
    elseif i == 2 then
        local color
        if obj.time < obj.totaltime / 5 then
            color = 0x00ff0
        elseif obj.time < obj.totaltime / 5 * 2 then
            color = 0x00ffff
        elseif obj.time < obj.totaltime / 5 * 3 then
            color = 0x00ff00
        elseif obj.time < obj.totaltime / 5 * 4 then
            color = 0xffff00
        else
            color = 0xff0000
        end
        obj.load("figure", "背景", color, 100)
        local b = (obj.screen_w - w + w / obj.totaltime * obj.time) / 2
        obj.effect("クリッピング", "上", a, "下", a, "右", b, "左", b)
    end
    obj.draw()
end
