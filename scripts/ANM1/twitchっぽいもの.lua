--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:閾値
---min=0
---max=100
local siki = 50
---$track:強さ
---min=0
---max=100
local t = 25
---$track:発光閾値
---min=0
---max=100
local h = 50
---$track:振動周期
---min=0
---max=100
local syu = 10
---$track:X振動
---min=-1000
---max=1000
---step=1
local x = 50

---$track:Y振動
---min=-1000
---max=1000
---step=1
local y = 50

---$track:Z振動
---min=-1000
---max=1000
---step=1
local z = 50

---$track:揺れ幅倍率
---min=0
---max=10
---step=0.1
local haba = 3

---$track:色ずれ幅
---min=0
---max=1000
---step=1
local irozure = 100

---$select:色ずれ種類
---赤緑A=0
---赤青A=1
---緑青A=2
---赤緑B=3
---赤青B=4
---緑青B=5
local ty = 0

obj.effect(
  "振動",
  "X",
  x,
  "Y",
  y,
  "Z",
  z,
  "周期",
  syu,
  "ランダムに強さを変える",
  1,
  "複雑に振動",
  1
)
obj.effect(
  "振動",
  "X",
  -haba * x,
  "Y",
  -haba * y,
  "Z",
  -haba * z,
  "周期",
  haba * syu,
  "ランダムに強さを変える",
  1,
  "複雑に振動",
  1
)
local s = rand(0, 100)
if s > siki then
  local dx = obj.rand(-obj.screen_w / 2, obj.screen_w / 2)
  local dy = obj.rand(-obj.screen_h / 2, obj.screen_h / 2)
  local a = obj.rand(0, t)
  obj.effect("放射ブラー", "範囲", a, "X", dx, "Y", dy, "サイズ固定", 1)
  obj.effect("発光", "強さ", 100 + a * 4, "拡散", 800, "しきい値", h, "サイズ固定", 1)
  obj.effect("色ずれ", "ずれ幅", a / 2 * irozure / 100, "角度", obj.rand(0, 360), "色ずれの種類", ty)
  obj.zoom = obj.zoom + a / 50
end
