---$track:ぼかし
---min=0
---max=200
local track0 = 100
obj.setoption("blend", 5)
obj.load("figure", "背景", 0xffffff, 100)
obj.effect("ノイズ", "速度X", 0.9, "速度Y", 0.1, "周期X", 16, "周期Y", 0.01, "しきい値", 60.6)
obj.effect("ぼかし", "範囲", track0, "縦横比", -100)
obj.effect("極座標変換")
obj.effect("発光", "強さ", 69.7, "拡散", 554, "しきい値", 44)
