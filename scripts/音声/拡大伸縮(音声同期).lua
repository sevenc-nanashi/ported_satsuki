--label:${ROOT_CATEGORY}\変形
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
---$track:拡大率
---min=100
---max=800
local s = 200
---$track:減衰率
---min=0
---max=100
local track3 = 4
---$track:Xスケール[%]
---min=0
---max=1000
local xs = 100

---$track:Yスケール[%]
---min=0
---max=1000
local ys = 100

---$track:分割数
---min=1
---max=50
---step=1
local div = 5

---$check:補助線表示
local hojo = 1

---$track:補助線高さ[%]
---min=0
---max=200
---step=1
local hh = 100

obj.effect()
local i = math.min(track1, div)
local sd = track3 / 100
local buf = {}
local n = obj.getaudio(buf, "audiobuffer", "spectrum", div)
local zoom = 1
local xscale = 1
local yscale = 1
if buf[i] > siki then
    zoom = s / 100
    xscale = xs / 100
    yscale = ys / 100
end
if zoom > 1 then
    zoom = zoom - sd
end
if xscale > 1 then
    xscale = xscale - sd
end
if yscale > 1 then
    yscale = yscale - sd
end
local x = obj.w / 2 * zoom * xscale
local y = obj.h / 2 * zoom * yscale
obj.drawpoly(-x, -y, 0, x, -y, 0, x, y, 0, -x, y, 0)

if hojo == 1 then
    local h = obj.screen_h / 2
    local w = obj.screen_w / n
    --波形表示(縦棒)
    obj.load("figure", "四角形", 0x00ff00, 2)
    obj.alpha = 0.5
    for j = 1, n do
        x = j * w - obj.screen_w / 2 - w / 2
        y = -buf[j] / 10 * hh / 100 + obj.screen_h / 2
        obj.drawpoly(x - w / 2, y, 0, x + w / 2, y, 0, x + w / 2, h, 0, x - w / 2, h, 0)
    end

    --選択した音域表示(縦棒)
    obj.load("figure", "四角形", 0xff0000, 2)
    x = i * w - obj.screen_w / 2 - w / 2
    y = -buf[i] / 10 * hh / 100 + obj.screen_h / 2
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
