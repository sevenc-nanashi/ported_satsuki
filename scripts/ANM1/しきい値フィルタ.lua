--track0:しきい値,0,100,50,1
--track1:間隔[s],0.01,5,0.01,0.01
--dialog:フィルタ名,name="ぼかし";項目1,pa1="範囲";値1,va1=10;項目2,pa2="未設定";値2,va2=0;項目3,pa3="未設定";値3,va3=0;項目4,pa4="未設定";値4,va4=0;項目5,pa5="未設定";値5,va5=0;
s = rand(0, 99, 0, math.floor(obj.time / obj.track1))
if s >= obj.track0 then
	obj.effect(name, pa1, va1, pa2, va2, pa3, va3, pa4, va4, pa5, va5)
end
