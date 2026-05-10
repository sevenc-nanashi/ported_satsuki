--label:${ROOT_CATEGORY}\カスタムオブジェクト\削除済み
---$track:時間[s]
---min=0
---max=10
local duration = 2
---$track:間隔[s]
---min=0.1
---max=10
local interval = 1
---$track:サイズ
---min=0
---max=256
local size = 100
---$font:フォント
local font = "MS UI Cothic"

---$color:文字色
local col1 = 0xffffff

---$color:影・縁色
local col2 = 0x000000

---$select:装飾タイプ
---標準文字=0
---影付き文字=1
---影付き文字（薄）=2
---縁取り文字=3
---縁取り文字（細）=4
---縁取り文字（太）=5
---縁取り文字（角）=6
local type = 0

local word = {
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
}
local n = obj.totaltime / interval
for i = 0, n do
    obj.setfont(font, size, type, col1, col2)
    obj.load("text", word[obj.rand(1, #word, i, 0)])
    local t = (duration - obj.time + i * interval) / duration
    if t > 0 then
        if t > 1 then
            obj.alpha = 0
            t = 1
        end
    else
        t = 0
    end
    local x = rand(-obj.screen_w / 2, obj.screen_w / 2, i, 0)
    local y = rand(-obj.screen_h / 2, obj.screen_h / 2, i, 0)
    obj.draw(x, y, 0, 1 - t, t, 0, 0, obj.rand(0, 360, 0, i))
end
