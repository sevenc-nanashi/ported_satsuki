--label:${ROOT_CATEGORY}
--param:べき数,2
local index, ratio = math.modf(obj.getpoint("index"))
local val_start = obj.getpoint(index)
local val_end = obj.getpoint(index + 1)

local value
if ratio <= 0.5 then
    value = val_start + (val_end - val_start) * (2 * ratio) ^ obj.getpoint("param") / 2
else
    value = val_start + (val_end - val_start) * ((1 - (1 - (ratio - 0.5) * 2) ^ obj.getpoint("param")) / 2 + 0.5)
end

return value
