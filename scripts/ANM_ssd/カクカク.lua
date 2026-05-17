--label:${ROOT_CATEGORY}
--param:分割数,10
local index, ratio = math.modf(obj.getpoint("index"))
local val_start = obj.getpoint(index)
local val_end = obj.getpoint(index + 1)
return val_start + (val_end - val_start) * math.floor(ratio * obj.getpoint("param")) / obj.getpoint("param")
