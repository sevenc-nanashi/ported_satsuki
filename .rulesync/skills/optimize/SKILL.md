---
name: optimize
description: "Optimize the code for better performance."
targets: ["*"]
---

# optimize

AviUtl1から2の更新点として、スクリプト内でのシェーダー記法の追加があります。
これにより、スクリプト内でシェーダーを直接記述できるようになったり、高速に描画できる関数が追加されたりしています。
これにより、パフォーマンスを向上させることができます。

## シェーダーによる高速化

このコードを、スクリプト内にシェーダー記法を使用して書き換えます。
シェーダーは以下のように使います：

```lua
--[[pixelshader@${shaderName}
---$include "./shaders/${shaderName}.hlsl"
]]
```

このように書くと、`./shaders/${shaderName}.hlsl`の内容がスクリプト内に展開されます。
また、シェーダーは以下のように書きます：

```hlsl
struct Constants {
  float param1;
  float param2;
  // ...
};

cbuffer constants : register(b0) { Constants constants; }

Texture2D srcTex : register(t0);
Texture2D srcTex2 : register(t1);
// ...

SamplerState srcSmp : register(s0);

float4 ${shaderName}(float4 pos : SV_Position, float2 uv : TEXCOORD0) : SV_TARGET {
  float4 rgba = srcTex.Sample(srcSmp, uv);

  // ...

  return float4(1.0, 0.5, 0.5, 1.0);
}
```

このシェーダー内で、元コードの処理を行うようにします。
シェーダーは以下のように呼び出します：

```lua
obj.pixelshader(
  "${shaderName}",
  destination_buffer,
  { source_buffer1, source_buffer2, ... },
  {
    value1, -- param1
    value2, -- param2
    ...
  }
)
```

このように書くと、`${shaderName}`という名前のシェーダーが呼び出されます。
シェーダー内で、元コードに相当する処理を行うようにします。
また、もしシェーダーと相性の悪いコードが存在する場合は、スクリプト内でシェーダーと通常のコードを組み合わせます。

```lua
local param1 = 0;
-- 条件分岐
if track_01 == 1 then
  param1 = 0.5;
end

obj.pixelshader(
  "${shaderName}",
  "object",
  { "object" },
  {
    param1,
    value2,
    ...
  }
)
```

### HLSL の注意点

- `pow(x, y)` の `x` が負値になり得る場合、`pow(max(x, 0.0), y)` のようにガードする
- `pow(rgb, 2.2)` のような記述は `error X3571` の原因になることがある
- αは元画像の値を維持することが多いので、明示的に `rgba.a` を返す

## drawpolyのバッチ描画

`obj.drawpoly`は、AviUtl1では1回の呼び出しで1つの四角形を描画するものでしたが、AviUtl2では複数の四角形を一度に描画できるようになりました。

これにより、複数のポリゴンを描画する際のパフォーマンスが向上します。

```lua
-- AviUtl1
obj.drawpoly(
  {
    x1, y1, z1,
    x2, y2, z2,
    x3, y3, z3,
    x4, y4, z4,
  }
)

-- AviUtl2
local vertices = {
  -- 四角形1
  {
    x1, y1, z1,
    x2, y2, z2,
    x3, y3, z3,
    x4, y4, z4,
    -- NOTE: uv座標も必要。(0, 0)が左上、現在の画像（最後にobj.loadした画像）の幅と高さが右下の座標になる（例: 画像の幅が100px、高さが50pxの場合、右下の座標は(100, 50)）
    -- 順に、左上、右上、右下、左下
    u1, v1,
    u2, v2,
    u3, v3,
    u4, v4,
  }
}
obj.drawpoly(vertices)
```

## 作業後の確認

1. Lua のフォルダ名は既存の実ディレクトリ名をそのまま使う
2. 対象 Lua に `stylua` を実行する
3. `TASKLIST.md` の `シェーダー化・最適化` 列を更新する

## その他

また、コンピュートシェーダーも存在します。詳細については <https://docs.aviutl2.jp/lua.md> を参照してください。
