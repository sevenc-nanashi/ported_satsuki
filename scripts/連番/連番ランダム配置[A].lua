--label:${ROOT_CATEGORY}\画像ファイル
---$track:個数
---min=0
---max=1000
---step=1
local n = 5
---$track:範囲
---min=0
---max=1000
local track1 = 100
---$track:移動速度
---min=0
---max=1000
local track2 = 0
---$track:回転速度
---min=0
---max=1000
local track3 = 0
---$value:X軸範囲[%]
local wx = 100

---$value:Y軸範囲[%]
local wy = 100

---$value:Z軸範囲[%]
local wz = 0

---$check:X回転
local kx = 0

---$check:Y回転
local ky = 0

---$check:Z回転
local kz = 1

---$value:拡大最小[-%]
local s_min = 0

w = track1 / 100 --範囲
v = track2 / 100 --移動速度
r = track3 / 100 --回転速度
