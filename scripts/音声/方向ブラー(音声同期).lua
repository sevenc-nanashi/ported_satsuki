--label:${ROOT_CATEGORY}\ぼかし
---$track:閾値
---min=0
---max=5000
---step=1
local siki = 1200
---$track:音域
---min=1
---max=50
---step=1
local track1 = 1
---$track:範囲
---min=0
---max=200
local s = 10
---$track:角度
---min=-360
---max=360
local r = 90
---$track:分割数
---min=1
---max=50
---step=1
local div = 5

---$track:色ずれ幅[%]
---min=0
---max=200
---step=0.1
local iro = 0

---$select:色ずれ種類
---赤緑A=0
---赤青A=1
---緑青A=2
---赤緑B=3
---赤青B=4
---緑青B=5
local iro_ty = 0

---$check:補助線表示
local hojo = true

---$track:補助線高さ[%]
---min=0
---max=200
---step=1
local hh = 100

obj.effect()
local i = math.min(track1, div)
local buf = {}
local n = obj.getaudio(buf, "audiobuffer", "spectrum", div)
local l
if buf[i] > siki then
    l = s * buf[i] / 1000
else
    l = 0
end
obj.effect("色ずれ", "ずれ幅", l * iro / 100, "角度", r, "type", iro_ty)
obj.effect("方向ブラー", "範囲", l, "角度", r)
obj.draw()

if hojo then
    local h = obj.screen_h / 2
    local w = obj.screen_w / n
    --波形表示(縦棒)
    obj.load("figure", "四角形", 0x00ff00, 2)
    obj.alpha = 0.5
    local polygons = {}
    for j = 1, n do
        local x = j * w - obj.screen_w / 2 - w / 2
        local y = -buf[j] / 10 * hh / 100 + obj.screen_h / 2
        table.insert(polygons, {x - w / 2, y, 0})
        obj.drawpoly(x - w / 2, y, 0, x + w / 2, y, 0, x + w / 2, h, 0, x - w / 2, h, 0)
    end

    --選択した音域表示(縦棒)
    obj.load("figure", "四角形", 0xff0000, 2)
    local x = i * w - obj.screen_w / 2 - w / 2
    local y = -buf[i] / 10 * hh / 100 + obj.screen_h / 2
    obj.drawpoly(x - w / 2, y, 0, x + w / 2, y, 0, x + w / 2, h, 0, x - w / 2, h, 0)

    --閾値表示(横線)
    obj.load("figure", "四角形", 0xffffff, 2)
    local sw = obj.screen_w / 2
    local sy = -siki / 10 * hh / 100 + obj.screen_h / 2
    obj.drawpoly(-sw, sy - 1, 0, sw, sy - 1, 0, sw, sy + 1, 0, -sw, sy + 1, 0)

    --テキスト表示
    obj.setfont("MS UI Gothic", 34, 3, 0xffffff, 0x000000)
    obj.load("text", "音域[" .. i .. "]の音量=" .. string.format("%04d", buf[i]))
    obj.draw(-obj.screen_w / 2 + obj.w / 2, -obj.screen_h / 2 + obj.h / 2)
end
