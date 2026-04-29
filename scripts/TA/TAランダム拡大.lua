--track0:拡大(小),0,800,120
--track1:拡大(大),0,800,500
--track2:閾値(小),0,100,50,1
--track3:閾値(大),0,100,90,1
--dialog:切替時間[s],kt=0.01;
t = math.floor(obj.time / kt)
l = rand(0, 100, 0, t)
if l > obj.track3 then
	obj.zoom = obj.zoom * obj.rand(100, obj.track1, 1, t) / 100
elseif l > obj.track2 then
	obj.zoom = obj.zoom * obj.rand(100, obj.track0, 2, t) / 100
end
