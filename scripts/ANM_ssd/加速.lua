--label:${ROOT_CATEGORY}\アニメーション効果
--param:2
local index, ratio = math.modf(obj.getpoint("index"))
local st = obj.getpoint(index)
local ed = obj.getpoint(index + 1)
return st + (ed - st) * ratio ^ obj.getpoint("param")
