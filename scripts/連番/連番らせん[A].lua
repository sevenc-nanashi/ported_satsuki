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
--dialog:軸[0-2],rasen_jiku=2;向き[0-2],rasen_dir=1;初期半径,rasen_r=100;半径差分,rasen_dr=0;大きさ,zoom=0;透明度,alpha=0;回転に同期移動/chk,douki=0;
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
