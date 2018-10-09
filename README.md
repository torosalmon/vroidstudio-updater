# vroidstudio-updater

pixivのVRoid Studioを一発アップデートしてくれるマン

## 動作要件
Windows PowerShell 5.0以上

## 起動方法

1. config.iniにVRoid Studioのインストール先フォルダを指定し保存します。（初回のみ）
2. VRoidStudioUpdate.batを立ち上げます。

# 処理

1. サイトから最新のWindows版zipをダウンロードします。
2. インストールされたzipはこのアップデータと同じフォルダに保存します。（次回起動以降のダウンロード済判定に利用しています）
3. インストール済の旧verを削除して最新版を展開しなおします。（旧フォルダを一度削除するので注意）

### 注意

* とりあえずの突貫仕様です。自己責任でお願いします。
* 公式サイトのマークアップとzipファイルの構造に依存している処理があるため、pixiv側の仕様変更があると不具合が起こる可能性があります。

---

[連絡先@Twitter](https://twitter.com/trs_torosalmon)
