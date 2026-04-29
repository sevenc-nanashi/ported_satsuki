--track0:高さ,0,900,5
--track1:長さ,0,1600,800
--track2:モード,-1,1,0,1
--dialog:色1,col1=0x0000ff;色2,col2=0x00ffff;色3,col3=0x00ff00;色4,col4=0xffff00;色5,col5=0xff0000;
mcol = { col1, col2, col3, col4, col5, col5 }
i = math.floor(obj.time / obj.totaltime * 5) + 1
obj.load("figure", "四角形", mcol[i], 2)
h = obj.track0 / 2
w0 = -obj.track1 / 2 * (1 - obj.time / obj.totaltime * (1 + obj.track2))
w1 = obj.track1 / 2 * (1 - obj.time / obj.totaltime * (1 - obj.track2))
obj.setoption("dst", "tmp", obj.track1, obj.track0)
obj.drawpoly(w0, -h, 0, w1, -h, 0, w1, h, 0, w0, h, 0)
obj.load("tempbuffer")
