--label:${ROOT_CATEGORY}\変形
---$track:Xスケール
---min=0
---max=1000
local xscale = 100
---$track:Yスケール
---min=0
---max=1000
local yscale = 100
obj.zoom = math.max(xscale, yscale) / 100
if xscale > yscale then
	--アスペクト比をマイナス方向にしてやる必要がある
	obj.aspect = yscale / xscale - 1
else
	--アスペクト比をプラス方向にしてやる必要がある
	obj.aspect = 1 - xscale / yscale
end
