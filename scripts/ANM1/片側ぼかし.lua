--track0:上,0,2000,0
--track1:下,0,2000,0
--track2:左,0,2000,0
--track3:右,0,2000,0
obj.effect("斜めクリッピング", "中心Y", -obj.h / 2 + obj.track0 / 2, "角度", 180, "ぼかし", obj.track0) --上
obj.effect("斜めクリッピング", "中心Y", obj.h / 2 - obj.track1 / 2, "角度", 0, "ぼかし", obj.track1) --下
obj.effect("斜めクリッピング", "中心X", -obj.w / 2 + obj.track2 / 2, "角度", 90, "ぼかし", obj.track2) --左
obj.effect("斜めクリッピング", "中心X", obj.w / 2 - obj.track3 / 2, "角度", 270, "ぼかし", obj.track3) --右
