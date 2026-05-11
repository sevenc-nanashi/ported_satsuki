--label:${ROOT_CATEGORY}\クリッピング
---$track:X
---min=-4000
---max=4000
local cx = 0
---$track:Y
---min=-4000
---max=4000
local cy = 0
---$track:サイズ
---min=0
---max=2000
---step=1
local track2 = 100
---$track:回転
---min=-720
---max=720
local track3 = 0
---$figure:マスクの種類
local fig = "円"

---$track:ライン幅
---min=0
---max=4000
---step=1
local line = 4000

---$track:Xスケール[%]
---min=-10000
---max=10000
---step=0.001
local asx = 100

---$track:Yスケール[%]
---min=-10000
---max=10000
---step=0.001
local asy = 100

---$track:透明度[%]
---min=0
---max=100
---step=0.01
local alp = 0

---$track:ぼかし
---min=0
---max=100
---step=1
local br = 0

obj.setanchor("cx,cy", 0)
obj.copybuffer("tempbuffer", "object")
obj.alpha = 0

obj.setoption("drawtarget", "tempbuffer")
obj.load("figure", fig, 0xffffff, track2, line)
obj.effect("ぼかし", "範囲", br)
obj.setoption("blend", "alpha_sub")
local w, h = obj.w / 2, obj.h / 2
local l = math.sqrt((w * asx / 100) ^ 2 + (h * asy / 100) ^ 2)
local r = math.rad(track3)
local x0 = cx + math.cos(math.atan2(-h * asy / 100, -w * asx / 100) + r) * l
local x1 = cx + math.cos(math.atan2(-h * asy / 100, w * asx / 100) + r) * l
local x2 = cx + math.cos(math.atan2(h * asy / 100, w * asx / 100) + r) * l
local x3 = cx + math.cos(math.atan2(h * asy / 100, -w * asx / 100) + r) * l
local y0 = cy + math.sin(math.atan2(-h * asy / 100, -w * asx / 100) + r) * l
local y1 = cy + math.sin(math.atan2(-h * asy / 100, w * asx / 100) + r) * l
local y2 = cy + math.sin(math.atan2(h * asy / 100, w * asx / 100) + r) * l
local y3 = cy + math.sin(math.atan2(h * asy / 100, -w * asx / 100) + r) * l
obj.drawpoly(x0, y0, 0, x1, y1, 0, x2, y2, 0, x3, y3, 0, 0, 0, w * 2, 0, w * 2, h * 2, 0, h * 2, 1 - alp / 100)

obj.load("tempbuffer")
