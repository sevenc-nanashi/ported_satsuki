--label:${ROOT_CATEGORY}\切り替え効果\TA
---$value:サイズ(基準:s)
local fonts = {}

---$value:基準フォント
local f = "MS UI Gothic"

---$value:フォント(基準:f)
local fontn = {}

---$color:基準色
local c = 0xffffff

---$value:色(基準:c)
local fontc = {}

---$value:Z座標
local zz = {}

---$value:Z回転
local rzz = {}

---$value:縦横比
local as = {}

for i = 0, leng - 1 do
    if fontn[i + 1] == null then
        fontn[i + 1] = f
    end
    if fonts[i + 1] == null then
        fonts[i + 1] = s
    end
    if fontc[i + 1] == null then
        fontc[i + 1] = c
    end
    if zz[i + 1] == null then
        zz[i + 1] = 0
    end
    if rzz[i + 1] == null then
        rzz[i + 1] = 0
    end
    if as[i + 1] == null then
        as[i + 1] = 0
    end
    ss = fonts[i + 1] * 2
    obj.setfont(fontn[i + 1], ss, 0, fontc[i + 1])

    obj.load("text", string.sub(text, i * (2 - es) + 1, i * (2 - es) + (2 - es)))
    obj.effect()
    x = pos[i * 2 + 1] + obj.rand(-100, 100, i, 0) / 100 * v
    y = pos[i * 2 + 2] + obj.rand(-100, 100, i, 1) / 100 * v
    z = zz[i + 1] + obj.rand(-100, 100, i, 3) / 100 * v + obj.rand(-100, 100, i, 4) * ranz
    rz = rzz[i + 1] + obj.rand(-180, 180, i, 6) * ranrz
    obj.aspect = as[i + 1] / 100
    obj.draw(x, y, z, 0.5, 1, 0, 0, rz)
end
