---$track:上
---min=0
---max=2000
local track0 = 0
---$track:下
---min=0
---max=2000
local track1 = 0
---$track:左
---min=0
---max=2000
local track2 = 0
---$track:右
---min=0
---max=2000
local track3 = 0
obj.effect("斜めクリッピング", "中心Y", -obj.h / 2 + track0 / 2, "角度", 180, "ぼかし", track0) --上
obj.effect("斜めクリッピング", "中心Y", obj.h / 2 - track1 / 2, "角度", 0, "ぼかし", track1) --下
obj.effect("斜めクリッピング", "中心X", -obj.w / 2 + track2 / 2, "角度", 90, "ぼかし", track2) --左
obj.effect("斜めクリッピング", "中心X", obj.w / 2 - track3 / 2, "角度", 270, "ぼかし", track3) --右
