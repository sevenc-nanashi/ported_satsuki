---$track:個数
---min=0
---max=300
---step=1
local n = 10
---$track:回転差分
---min=-360
---max=360
local drot = 10
---$track:座標差分
---min=-1000
---max=1000
local dpos = 10
---$track:回転
---min=-3600
---max=3600
local rot = 0
---$value:軸[0-2]
local rasen_jiku = 2

---$value:向き[0-2]
local rasen_dir = 1

---$value:初期半径
local rasen_r = 100

---$value:半径差分
local rasen_dr = 0

---$value:大きさ
local zoom = 0

---$value:透明度
local alpha = 0

---$check:回転に同期移動
local douki = 0

--
--※GH螺旋配置(sm13806316参照)を改変したものです。
--
-- ●軸
--    0:X軸
--    1:Y軸
--    2:Z軸
--
-- ●向き
--    0:回転なし(手前向き固定)
--    1:面を円の外側に向ける（軸がZの場合は上側を円の外側に向ける）
--    2:面を円の内側に向ける（軸がZの場合は上側を円の内側に向ける）
--
