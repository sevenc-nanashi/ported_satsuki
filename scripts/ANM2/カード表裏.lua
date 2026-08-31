---$script_tips:X軸又はY軸回転した際に、カードの表裏の関係のように別画像を表示します。
---:拡張描画にし「裏面を表示しない」にチェックして使用して下さい。
--label:${ROOT_CATEGORY}\変形
---$tips:参照ボタンから裏面画像を読み込んでください。
---$file:ファイル
local file = ""
obj.effect()
obj.draw()
obj.setoption("culling", 1)
obj.load(file)
obj.effect()
obj.draw(0, 0, 0, 1, 1, 0, 180, -obj.getvalue("rz") * 2)
