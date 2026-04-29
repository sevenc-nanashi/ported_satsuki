--track0:基準サイズ,0,512,50,1
--track1:Zランダム,0,500,0,1
--track2:回転ランダム,0,500,0
--track3:移動速度,0,100,0
--dialog:英数字/chk,es=0;テキスト,text="さんぷる";(XY座標),pos={};

s = obj.track0
ranz = obj.track1 / 100
ranrz = obj.track2 / 100
v = obj.time * obj.track3
leng = string.len(text) / (2 - es)
obj.setanchor("pos", leng, "line")
