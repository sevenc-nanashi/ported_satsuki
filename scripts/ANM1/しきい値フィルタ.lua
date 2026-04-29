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
--dialog:フィルタ名,name="ぼかし";項目1,pa1="範囲";値1,va1=10;項目2,pa2="未設定";値2,va2=0;項目3,pa3="未設定";値3,va3=0;項目4,pa4="未設定";値4,va4=0;項目5,pa5="未設定";値5,va5=0;
s = rand(0, 99, 0, math.floor(obj.time / track1))
if s >= track0 then
	obj.effect(name, pa1, va1, pa2, va2, pa3, va3, pa4, va4, pa5, va5)
end
