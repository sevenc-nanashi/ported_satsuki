--label:${ROOT_CATEGORY}\図形
---$track:サイズ
---min=1
---max=2000
---step=1
local size = 100
---$track:ライン幅
---min=1
---max=1000
---step=1
local haba = 20
---$track:頭サイズ
---min=0
---max=1000
---step=1
local hds = 50
---$track:角度
---min=0
---max=360
local r = 260
---$color:色
local col = 0xffff00

---$figure:図形
local fig = "三角形"

---$check:上下反転
local jgh = 0

---$check:左右反転
local syh = 0

---$track:中心角
---min=0
---max=180
---step=0.1
local cc = 0

---$check:終点あり
local siri = false

--仮想バッファに描画
local kaso = math.max(size - haba + hds, size)
-- obj.setoption("blend", "alpha_add")

--本体
obj.load("figure", "円", col, size, haba)
obj.effect("斜めクリッピング", "角度", 180 - r / 2, "ぼかし", 0)
obj.effect("ミラー", "境目調整", -size / 2)
obj.setoption("drawtarget", "tempbuffer", kaso, kaso)
obj.draw(0, 0, 0, 1, 1, 0, 0, -90 + r / 2 * (1 - cc / 180))

--頭
obj.load("figure", fig, col, hds)
local l = size / 2 - haba / 2
local rr = math.rad(r - r * cc / 360)
local cl
if fig == "三角形" then
    cl = hds * math.sin(math.rad(30)) / 2 - 1
else
    cl = 0
end
local x = math.sin(rr) * l + math.cos(rr) * cl
local y = -math.cos(rr) * l + math.sin(rr) * cl
obj.draw(x, y, 0, 1, 1, 0, 0, 90 + r * (1 - cc / 360))

--終点図形
if siri then
    local rr2 = math.rad(-r * cc / 360)
    if fig == "三角形" then
        cl = hds * math.sin(math.rad(30)) / 2 - 1
    else
        cl = 0
    end
    x = math.sin(rr2) * l - math.cos(rr2) * cl
    y = -math.cos(rr2) * l - math.sin(rr2) * cl
    obj.draw(x, y, 0, 1, 1, 0, 0, -90 - r * cc / 360)
end

--仮想バッファから読み込み
obj.load("tempbuffer")

obj.effect("反転", "上下反転", jgh, "左右反転", syh)
