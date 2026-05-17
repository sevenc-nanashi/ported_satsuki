--label:${ROOT_CATEGORY}\ツール
---$track:サイズ
---min=1
---max=256
---step=1
local size = 34
---$select:タイプ
---標準文字=0
---影付き文字=1
---影付き文字（薄）=2
---縁取り文字=3
---縁取り文字（細）=4
---縁取り文字（太）=5
---縁取り文字（角）=6
local text_type = 3
---$color:色
local color = 0xffffff

local r, g, b = RGB(color)

local function dec_to_hex(n)
    local st
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

local r_hex = dec_to_hex(math.floor(r / 16)) .. dec_to_hex(r - math.floor(r / 16) * 16)
local g_hex = dec_to_hex(math.floor(g / 16)) .. dec_to_hex(g - math.floor(g / 16) * 16)
local b_hex = dec_to_hex(math.floor(b / 16)) .. dec_to_hex(b - math.floor(b / 16) * 16)
obj.setfont("MS UI Cothic", size, text_type, 0xffffff, 0x000000)
local col = "0x" .. r_hex .. g_hex .. b_hex
obj.load("text", col)
