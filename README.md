# smlbf.sml

## これはなに?
* [暇を持て余した学生](https://sirasolra.github.io/ "sirasolra")が学習目的で制作した，難解プログラミング言語 [`Brainf*ck`](https://ja.wikipedia.org/wiki/Brainfuck "Brainf*ck (wikipedia)") のインタプリタです．
* `Standard ML` で記述しています．

## はいっているもの
* `README.md`: この説明書．
* `smlbf.sml`: 本体．`Standard ML` で書いた．
* `primesUnder100.bf`: 100以下の素数を計算する `Brainf*ck` のサンプルプログラム．
* `.gitignore`

## つかいかた
### `sml` コマンドで実行
```
sml smlbf.sml primesUnder100.bf
```
### `mlton` とかでコンパイルしてから実行
```
mlton smlbf.sml
./smlbf primesUnder100.bf
```
