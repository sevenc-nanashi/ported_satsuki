--label:${ROOT_CATEGORY}
--param:次数,2
local index, ratio = math.modf(obj.getpoint("index"))
local val_start = obj.getpoint(index)
local val_end = obj.getpoint(index + 1)
return val_start + (val_end - val_start) * ratio ^ obj.getpoint("param")
