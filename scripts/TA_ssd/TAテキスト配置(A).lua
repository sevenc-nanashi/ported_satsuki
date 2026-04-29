---$track:基準サイズ
---min=0
---max=512
---step=1
local s = 50
---$track:Zランダム
---min=0
---max=500
---step=1
local track1 = 0
---$track:回転ランダム
---min=0
---max=500
local track2 = 0
---$track:移動速度
---min=0
---max=100
local track3 = 0
--dialog:英数字/chk,es=0;テキスト,text="さんぷる";(XY座標),pos={};

ranz = track1 / 100
ranrz = track2 / 100
v = obj.time * track3
leng = string.len(text) / (2 - es)
obj.setanchor("pos", leng, "line")
