---$script_tips:X軸方向、Y軸方向それぞれ別個にサイズを変更し、縦横比を変えることが出来ます。
---:こちらの動画で配布されているものですが、非常に便利なのでここにも記載しています。
---:http://www.nicovideo.jp/watch/sm13546528
--label:${ROOT_CATEGORY}\変形
---$tips:各軸方向のサイズを指定します。
---$track:Xスケール
---min=0
---max=1000
local xscale = 100
---$tips:各軸方向のサイズを指定します。
---$track:Yスケール
---min=0
---max=1000
local yscale = 100

obj.sx = xscale * 0.01
obj.sy = yscale * 0.01
