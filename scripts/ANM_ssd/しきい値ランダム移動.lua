--label:${ROOT_CATEGORY}
--twopoint
--param:しきい値,20
local index = math.modf(obj.getpoint("index"))
local val_start = obj.getpoint(index)
local val_end = obj.getpoint(index + 1)
local random = math.random(100)
local value
if random >= obj.getpoint("param") then
    value = val_start
else
    value = val_start + (val_end - val_start) * math.random(100) / 100
end
return value
