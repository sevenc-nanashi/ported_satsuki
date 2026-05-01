--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:半径調整
---min=0
---max=150
local fl = 100
tr = obj.index * 90 - r
obj.ox = math.sin(tr * math.pi / 180) * s * 7 / 8 / 2 * fl / 100
obj.oy = -math.cos(tr * math.pi / 180) * s * 7 / 8 / 2 * fl / 100
obj.rz = tr
obj.zoom = 1 + tc
obj.alpha = ac * (1 - tc)
obj.effect("放射ブラー", "範囲", blur * tc)
