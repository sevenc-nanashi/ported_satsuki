--track0:回転1,-720,720,0
--track1:サイズ1,0,2000,100
--track2:縦横比1,-100,100,0
--track3:ぼかし1,0,200,0,1
--dialog:時間[s],ta=1;加減速[1-5],beki=2;減/加/S[0-2],mode=0;マスクの種類,ty=2;X,x=0;Y,y=0;回転2,r2=0;サイズ2,s2=0;縦横比2[%],as2=0;ぼかし2,bk2=0;反転/chk,ht=0;

--共通部分
if ta == 0 then
	return
elseif ta < 0 then
	t = (ta - obj.time + obj.totaltime) / ta
else
	t = (ta - obj.time) / ta
end
t = math.max(0, t)

if mode < 1 then
	t = t ^ beki
elseif mode < 2 then
	t = 1 - (1 - t) ^ beki
else
	if t <= 0.5 then
		t = (2 * t) ^ beki / 2
	else
		t = (1 - (1 - (t - 0.5) * 2) ^ beki) / 2 + 0.5
	end
end

--フィルタ効果
r = obj.track0 + r2 * t
s = obj.track1 + s2 * t
as = obj.track2 + as2 * t
bk = obj.track3 + bk2 * t
obj.effect(
	"マスク",
	"X",
	x,
	"Y",
	y,
	"回転",
	r,
	"サイズ",
	s,
	"縦横比",
	as,
	"ぼかし",
	bk,
	"マスクの反転",
	ht,
	"type",
	ty
)
