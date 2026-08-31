--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$script_tips:テキストが一定の範囲で、一文字毎にバラバラに配置されます。
---$tips:テキストの移動や回転の速度を指定します。
---$track:速さ
---min=0
---max=1000
---step=1
local speed = 200

---$tips:テキストがバラバラになる座標の範囲を指定します。
---$track:座標範囲
---min=0
---max=800
---step=1
local position_range = 50

---$tips:テキストのランダムな拡大率の範囲を指定します。
---$track:拡大範囲[+%]
---min=0
---max=800
---step=1
local zoom_range = 50

---$tips:テキストの回転角度の範囲を指定します。
---$track:回転範囲
---min=0
---max=180
---step=1
local rotation_range = 30

---$tips:チェックすると初期位置がバラバラの状態になります。
---$check:初期位置
local starts_scattered = true

---$tips:チェックするとZ軸方向にも移動するようになります。
---$check:Z軸方向
local moves_z_axis = false

---$tips:ランダムに設定された結果を、別のランダム結果に変更します。
---:数値は適当な整数を入力すればよいので、好みのランダム結果が表示されるようにいろいろ試すとよいかもしれません。
---$track:乱数
---min=0
---max=1000
---step=1
local random_seed = 0

local initial_offset = starts_scattered and 1 or 0
local z_axis_factor = moves_z_axis and 1 or 0
local progress = initial_offset + obj.time * speed / 1000

obj.ox = obj.ox + progress * obj.rand(-obj.w, obj.w, obj.index, random_seed) * position_range / 200
obj.oy = obj.oy + progress * obj.rand(-obj.h, obj.h, obj.index, random_seed + 1) * position_range / 100
obj.oz = obj.oz + progress * obj.rand(-obj.h, obj.h, obj.index, random_seed + 2) * position_range / 100 * z_axis_factor
obj.zoom = math.max(0, obj.zoom + progress * obj.rand(-1, 1, obj.index, random_seed + 3) * zoom_range / 200)
obj.rz = obj.rz + progress * obj.rand(-rotation_range, rotation_range, obj.index, random_seed + 4) / 2
