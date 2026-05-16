--label:${ROOT_CATEGORY}
--param:2
local index, ratio = math.modf(obj.getpoint("index"))
local st = obj.getpoint(index)
local ed = obj.getpoint(index + 1)

if ratio <= 0.5 then
    kagen = st + (ed - st) * (2 * ratio) ^ obj.getpoint("param") / 2
else
    kagen = st + (ed - st) * ((1 - (1 - (ratio - 0.5) * 2) ^ obj.getpoint("param")) / 2 + 0.5)
end

return kagen
