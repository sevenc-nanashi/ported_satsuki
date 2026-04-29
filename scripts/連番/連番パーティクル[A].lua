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
--dialog:ランダム方向[度],dir_ran=30;透過速度[%],av=100;拡大速度[%],sv=0;ランダム速度[-%],v_ran=0;ランダム拡大[-%],s_ran=0;ランダムZ角度[度],rz_ran=0;X軸ランダム,x_ran=0;Y軸ランダム,y_ran=0;Z軸ランダム,z_ran=0;回転速度[度],rv_ran=0;XY回転あり/chk,rxy_ran=0;Z軸ランダム方向,zi_ran=0;
b = 1 / track0 --出力間隔(秒)
v = l / track2 --距離を進むのにかかる時間
dir = -track3 + 90 --出力方向
