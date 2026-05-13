--label:${ROOT_CATEGORY}\パーティクル出力
---$track:頻度
---min=0.1
---max=500
local track0 = 10
---$track:距離
---min=1
---max=10000
local l = 500
---$track:速度
---min=1
---max=2000
local track2 = 400
---$track:方向
---min=-360
---max=360
local track3 = 0
---$value:ランダム方向[度]
local dir_ran = 30

---$value:透過速度[%]
local av = 100

---$value:拡大速度[%]
local sv = 0

---$value:ランダム速度[-%]
local v_ran = 0

---$value:ランダム拡大[-%]
local s_ran = 0

---$value:ランダムZ角度[度]
local rz_ran = 0

---$value:X軸ランダム
local x_ran = 0

---$value:Y軸ランダム
local y_ran = 0

---$value:Z軸ランダム
local z_ran = 0

---$value:回転速度[度]
local rv_ran = 0

---$check:XY回転あり
local rxy_ran = 0

---$value:Z軸ランダム方向
local zi_ran = 0

b = 1 / track0 --出力間隔(秒)
v = l / track2 --距離を進むのにかかる時間
dir = -track3 + 90 --出力方向
