--label:${ROOT_CATEGORY}\変形
---$script_tips:音声に同期して拡大率や縦横比が変化します。
---$tips:指定した音域の音量が、閾値を超えた時に拡大伸縮します。
---$track:閾値
---min=0
---max=5000
---step=1
local siki = 1200
---$tips:音域を指定します。
---:分割数より小さな値で設定して下さい。
---$track:音域
---min=1
---max=50
---step=1
local track1 = 1
---$tips:変化する拡大率を指定します。
---$track:拡大率
---min=100
---max=800
local s = 200
---$tips:音量が閾値を超えると画像が拡大伸縮し、その後、だんだんと元の大きさに戻ります。
---:その元の大きさに戻る速さを指定します。
---$track:減衰率
---min=0
---max=100
local track3 = 4
---$tips:変化するX軸方向のサイズを指定します。
---$track:Xスケール[%]
---min=0
---max=1000
local xs = 100

---$tips:変化するY軸方向のサイズを指定します。
---$track:Yスケール[%]
---min=0
---max=1000
local ys = 100

---$tips:音声データの分割数を指定します。
---$track:分割数
---min=1
---max=50
---step=1
local div = 5

---$tips:チェックすると、補助表示の音声波形が表示されます。
---:調整後は非表示にして使用して下さい。
---$check:補助線表示
local hojo = 1

---$tips:補助線の音声波形の高さを調整します。
---$track:補助線高さ[%]
---min=0
---max=200
---step=1
local hh = 100

--hide@hh:hojo==0

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
