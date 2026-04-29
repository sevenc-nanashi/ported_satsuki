--track0:頻度,0.1,500,10
--track1:距離,1,10000,500
--track2:速度,1,2000,400
--track3:方向,-360,360,0
--dialog:ランダム方向[度],dir_ran=30;透過速度[%],av=100;拡大速度[%],sv=0;ランダム速度[-%],v_ran=0;ランダム拡大[-%],s_ran=0;ランダムZ角度[度],rz_ran=0;X軸ランダム,x_ran=0;Y軸ランダム,y_ran=0;Z軸ランダム,z_ran=0;回転速度[度],rv_ran=0;XY回転あり/chk,rxy_ran=0;Z軸ランダム方向,zi_ran=0;
b = 1 / obj.track0 --出力間隔(秒)
l = obj.track1 --距離
v = l / obj.track2 --距離を進むのにかかる時間
dir = -obj.track3 + 90 --出力方向
