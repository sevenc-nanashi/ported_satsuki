--label:${ROOT_CATEGORY}\カスタムオブジェクト\図形
---$track:ぼかし
---min=0
---max=200
local blur = 100

-- TODO: だいぶ重い...
obj.setoption("blend", "overlay")
obj.load("figure", "四角形", 0xffffff, math.max(obj.screen_h, obj.screen_w))
obj.effect("ノイズ", "速度X", 0.9, "速度Y", 0.1, "周期X", 16, "周期Y", 0.01, "しきい値", 60.6)
obj.effect("ぼかし", "範囲", blur, "縦横比", -100, "サイズ固定", 1)
obj.effect("極座標変換")
obj.effect("発光", "強さ", 69.7, "拡散", 554, "しきい値", 44, "サイズ固定", 1)
