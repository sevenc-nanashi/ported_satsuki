--track0:モノクロ,0,100,0
--track1:強さ,0,100,100
--track2:合成,0,9,0,1
--color:0xffffff
obj.effect("単色化", "強さ", obj.track0)
obj.effect("グラデーション", "強さ", obj.track1, "color", color, "color2", color, "blend", obj.track2)
