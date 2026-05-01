--label:${ROOT_CATEGORY}\抽出
---$track:しきい値
---min=0
---max=255
---step=1
local sikii = 128
---$track:周期XY
---min=0
---max=50
---step=0.01
local syk = 5
---$track:変化速度
---min=0
---max=50
local hks = 0
---$track:種類
---min=0
---max=5
---step=1
local nizs = 0
---$color:色
local col = 0xffffff

---$check:輝度保持
local kdhj = 0

--[[
ティム氏の色調補正セットにある「T_Color_Module.dll」が必要です。
http://www.nicovideo.jp/watch/sm21178949
からダウンロードし、当スクリプトファイルと同じフォルダに入れてください。
]]

obj.effect("単色化", "color", 0xffffff, "輝度を保持する", kdhj)
obj.effect("ノイズ", "変化速度", hks, "周期X", syk, "周期Y", syk, "mode", 1, "type", nizs)

require("T_Color_Module")
local userdata, w, h = obj.getpixeldata()
T_Color_Module.binarization(userdata, w, h, sikii, 1)
obj.putpixeldata(userdata)

obj.effect("カラーキー", "color_yc", 0, "status", 1)
obj.effect("単色化", "color", col, "輝度を保持する", 0)
