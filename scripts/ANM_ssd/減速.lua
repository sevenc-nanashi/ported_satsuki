--label:${ROOT_CATEGORY}\アニメーション効果
--param:2
local index, ratio = math.modf(obj.getpoint("index"))
local st = obj.getpoint(index)
local ed = obj.getpoint(index + 1)
return st + (ed - st) * (1 - (1 - ratio) ^ obj.getpoint("param"))
