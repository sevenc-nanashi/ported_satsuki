---$script_tips:上下左右の境界から透明度をぼかします。
--label:${ROOT_CATEGORY}\ぼかし
---$tips:各方向からの範囲(ピクセル)を指定します。
---$track:上
---min=0
---max=2000
local up_blur = 0
---$tips:各方向からの範囲(ピクセル)を指定します。
---$track:下
---min=0
---max=2000
local down_blur = 0
---$tips:各方向からの範囲(ピクセル)を指定します。
---$track:左
---min=0
---max=2000
local left_blur = 0
---$tips:各方向からの範囲(ピクセル)を指定します。
---$track:右
---min=0
---max=2000
local right_blur = 0
obj.effect("斜めクリッピング", "中心Y", -obj.h / 2 + up_blur / 2, "角度", 180, "ぼかし", up_blur) --上
obj.effect("斜めクリッピング", "中心Y", obj.h / 2 - down_blur / 2, "角度", 0, "ぼかし", down_blur) --下
obj.effect("斜めクリッピング", "中心X", -obj.w / 2 + left_blur / 2, "角度", 90, "ぼかし", left_blur) --左
obj.effect("斜めクリッピング", "中心X", obj.w / 2 - right_blur / 2, "角度", 270, "ぼかし", right_blur) --右
