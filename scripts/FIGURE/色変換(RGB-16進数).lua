--label:${ROOT_CATEGORY}\色調整
---$track:サイズ
---min=1
---max=256
---step=1
local track0 = 34
---$track:タイプ
---min=0
---max=4
---step=1
local track1 = 3
---$color:色
local color = 0xffffff

r = math.floor(color / 16 ^ 4)
g = math.floor((color - r * 16 ^ 4) / 256)
b = color - r * 16 ^ 4 - g * 16 ^ 2

function ST(n)
    if n < 10 then
        st = n
    elseif n == 10 then
        st = "a"
    elseif n == 11 then
        st = "b"
    elseif n == 12 then
        st = "c"
    elseif n == 13 then
        st = "d"
    elseif n == 14 then
        st = "e"
    elseif n == 15 then
        st = "f"
    end
    return st
end

rr = ST(math.floor(r / 16)) .. ST(r - math.floor(r / 16) * 16)
gg = ST(math.floor(g / 16)) .. ST(g - math.floor(g / 16) * 16)
bb = ST(math.floor(b / 16)) .. ST(b - math.floor(b / 16) * 16)
obj.setfont("MS UI Cothic", track0, track1, 0xffffff, 0x000000)
col = "0x" .. rr .. gg .. bb
obj.load("text", col)
