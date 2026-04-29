--track0:時間[s],0,10,2
--track1:間隔[s],0.1,10,1
--track2:サイズ,0,256,100
--dialog:フォント,font="MS UI Cothic";文字色/col,col1=0xffffff;影・縁色/col,col2=0x000000;装飾タイプ[0-4],type=0;
word =
	{ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }
n = obj.totaltime / obj.track1
for i = 0, n do
	obj.setfont(font, obj.track2, type, col1, col2)
	obj.load("text", word[obj.rand(1, #word, i, 0)])
	t = (obj.track0 - obj.time + i * obj.track1) / obj.track0
	if t > 0 then
		if t > 1 then
			obj.alpha = 0
			t = 1
		end
	else
		t = 0
	end
	x = rand(-obj.screen_w / 2, obj.screen_w / 2, i, 0)
	y = rand(-obj.screen_h / 2, obj.screen_h / 2, i, 0)
	obj.draw(x, y, 0, 1 - t, t, 0, 0, obj.rand(0, 360, 0, i))
end
