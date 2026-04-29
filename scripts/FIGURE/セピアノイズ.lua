--track0:ゴミ閾値,0,100,90
--track1:ゴミサイズ,0,200,100
--track2:縦線閾値,0,100,90
--track3:輝度変化,0,100,90
--dialog:縁色/col,color=0x6b4a2b;ノイズ色/col,ncolor=0x000000;縁アス比/chk,as=0;縁あり/chk,ed=1;輝度反転/chk,ha=0;
gs = obj.track0
gb = obj.track1 / 100
ts = obj.track2
kh = obj.track3

--白背景
obj.load("figure", "背景", 0xffffff)
obj.effect("色調補正", "輝度", obj.rand(kh, 100))
obj.setoption("dst", "tmp", obj.screen_w, obj.screen_h)
obj.draw()

--色付き背景
obj.load("figure", "背景", color)
obj.setoption("dst", "tmp")
obj.draw(0, 0, 0, 1, 0.2)

--縁
if ed == 1 then
	ss = 50
	obj.load("figure", "四角形", color, ss * 2)
	obj.effect("マスク", "type", 1, "サイズ", ss, "マスクの反転", 1)
	obj.effect("ぼかし", "範囲", 10, "サイズ固定", 1)
	w = obj.screen_w / 2
	h = w
	if as == 1 then
		h = obj.screen_h / 2
	end
	obj.setoption("dst", "tmp")
	obj.drawpoly(
		-w,
		-h,
		0,
		w,
		-h,
		0,
		w,
		h,
		0,
		-w,
		h,
		0,
		ss / 2,
		ss / 2,
		ss * 3 / 2,
		ss / 2,
		ss * 3 / 2,
		ss * 3 / 2,
		ss / 2,
		ss * 3 / 2
	)
end

--ゴミノイズ
obj.load("figure", "四角形", ncolor, obj.screen_w)
obj.effect("ノイズ", "変化速度", 50, "周期X", 10 * gb, "周期Y", 10 * gb, "しきい値", gs)
x = rand(-obj.screen_w / 2, obj.screen_w / 2)
y = rand(-obj.screen_h / 2, obj.screen_h / 2)
obj.setoption("dst", "tmp")
obj.draw(x, y, 0, 2)

--縦線ノイズ
obj.load("figure", "四角形", ncolor, obj.screen_w)
obj.effect("ノイズ", "変化速度", 50, "周期X", 20, "周期Y", 0.01, "しきい値", ts)
obj.setoption("dst", "tmp")
obj.draw()

--描画
obj.load("tempbuffer")
obj.effect("反転", "輝度反転", ha)
