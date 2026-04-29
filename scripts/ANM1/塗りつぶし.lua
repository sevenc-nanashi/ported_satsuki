---$track:モノクロ
---min=0
---max=100
local track0 = 0
---$track:強さ
---min=0
---max=100
local track1 = 100
---$track:合成
---min=0
---max=9
---step=1
local track2 = 0
--color:0xffffff
obj.effect("単色化", "強さ", track0)
obj.effect("グラデーション", "強さ", track1, "color", color, "color2", color, "blend", track2)
