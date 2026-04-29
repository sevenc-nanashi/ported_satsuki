--track0:閾値,0,5000,1200,1
--track1:音域,1,50,1,1
--track2:範囲,0,200,10
--track3:角度,-360,360,90
--dialog:分割数,div=5;色ずれ幅[%],iro=0;色ずれ種類[0-2],iro_ty=0;補助線表示/chk,hojo=1;補助線高さ[%],hh=100;
obj.effect()
siki = obj.track0
i = math.min(obj.track1, div)
s = obj.track2
r = obj.track3
buf = {}
n = obj.getaudio(buf, "audiobuffer", "spectrum", div)
if buf[i] > siki then
	l = s * buf[i] / 1000
else
	l = 0
end
obj.effect("色ずれ", "ずれ幅", l * iro / 100, "角度", r, "type", iro_ty)
obj.effect("方向ブラー", "範囲", l, "角度", r)
obj.draw()

if hojo == 1 then
	h = obj.screen_h / 2
	w = obj.screen_w / n
	--波形表示(縦棒)
	obj.load("figure", "四角形", 0x00ff00, 2)
	obj.alpha = 0.5
	for j = 1, n do
		x = j * w - obj.screen_w / 2 - w / 2
		y = -buf[j] / 10 * hh / 100 + obj.screen_h / 2
		obj.drawpoly(x - w / 2, y, 0, x + w / 2, y, 0, x + w / 2, h, 0, x - w / 2, h, 0)
	end

	--選択した音域表示(縦棒)
	obj.load("figure", "四角形", 0xff0000, 2)
	x = i * w - obj.screen_w / 2 - w / 2
	y = -buf[i] / 10 * hh / 100 + obj.screen_h / 2
	obj.drawpoly(x - w / 2, y, 0, x + w / 2, y, 0, x + w / 2, h, 0, x - w / 2, h, 0)

	--閾値表示(横線)
	obj.load("figure", "四角形", 0xffffff, 2)
	sw = obj.screen_w / 2
	sy = -siki / 10 * hh / 100 + obj.screen_h / 2
	obj.drawpoly(-sw, sy - 1, 0, sw, sy - 1, 0, sw, sy + 1, 0, -sw, sy + 1, 0)

	--テキスト表示
	obj.setfont("MS UI Gothic", 34, 3, 0xffffff, 0x000000)
	obj.load("text", "音域[" .. i .. "]の音量=" .. string.format("%04d", buf[i]))
	obj.draw(-obj.screen_w / 2 + obj.w / 2, -obj.screen_h / 2 + obj.h / 2)
end
