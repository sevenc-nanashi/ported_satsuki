--track0:Xスケール,0,1000,100
--track1:Yスケール,0,1000,100
xscale = obj.track0
yscale = obj.track1
obj.zoom = math.max(xscale, yscale) / 100
if xscale > yscale then
	--アスペクト比をマイナス方向にしてやる必要がある
	obj.aspect = yscale / xscale - 1
else
	--アスペクト比をプラス方向にしてやる必要がある
	obj.aspect = 1 - xscale / yscale
end
