--label:${ROOT_CATEGORY}\抽出
---$track:しきい値
---min=0
---max=100
---step=1
local track0 = 50
---$track:間隔[s]
---min=0.01
---max=5
---step=0.01
local track1 = 0.01
---$value:フィルタ名
local name = "ぼかし"

---$value:項目1
local pa1 = "範囲"

---$value:値1
local va1 = 10

---$value:項目2
local pa2 = "未設定"

---$value:値2
local va2 = 0

---$value:項目3
local pa3 = "未設定"

---$value:値3
local va3 = 0

---$value:項目4
local pa4 = "未設定"

---$value:値4
local va4 = 0

---$value:項目5
local pa5 = "未設定"

---$value:値5
local va5 = 0

s = rand(0, 99, 0, math.floor(obj.time / track1))
if s >= track0 then
    obj.effect(name, pa1, va1, pa2, va2, pa3, va3, pa4, va4, pa5, va5)
end
