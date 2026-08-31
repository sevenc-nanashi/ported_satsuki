---$script_tips:透明度を明滅させて登場又は退場します。
--label:${ROOT_CATEGORY}\切り替え効果
---$tips:明滅する時間をフレーム数で指定します。
---$track:登場[f]
---min=0
---max=150
---step=1
local fade_in_frames = 4
---$tips:明滅する時間をフレーム数で指定します。
---$track:退場[f]
---min=0
---max=150
---step=1
local fade_out_frames = 4

if fade_in_frames > 0 and obj.frame <= fade_in_frames and obj.frame % 2 == 1 then
    obj.alpha = 0
end

if fade_out_frames > 0 and obj.totalframe - obj.frame <= fade_out_frames and obj.frame % 2 == 0 then
    obj.alpha = 0
end
