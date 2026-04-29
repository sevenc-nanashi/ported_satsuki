--track0:R,-100,100,0
--track1:G,-100,100,0
--track2:B,-100,100,0
function KG(s, col)
	if s >= 0 then
		obj.effect("グラデーション", "強さ", s, "color", col, "color2", col, "blend", 1)
	else
		obj.effect("グラデーション", "強さ", -s, "color", col, "color2", col, "blend", 2)
	end
end
KG(obj.track0, 0xff0000)
KG(obj.track1, 0x00ff00)
KG(obj.track2, 0x0000ff)
