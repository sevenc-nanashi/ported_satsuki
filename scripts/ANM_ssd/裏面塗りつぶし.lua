---$track:強さ
---min=0
---max=100
local track0 = 100
--dialog:色/col,coln=0xffffff;輝度保持/chk,kid=0;
obj.setoption("culling", 1)
obj.effect()
obj.draw()
obj.effect("反転", "左右反転", 1)
obj.effect("単色化", "強さ", track0, "輝度を保持する", kid, "color", coln)
obj.draw(0, 0, 0, 1, 1, 0, 180)
