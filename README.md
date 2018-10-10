# VRoid Studio アップデーター

pixivのVRoid Studioを一発アップデートしてくれるマン

## 動作要件
Windows PowerShell 5.0以上

## 起動方法

1. config.iniにVRoid Studioのインストール先フォルダを指定し保存します。（初回のみ）
2. VRoidStudioUpdate.batを立ち上げます。

## 処理

1. サイトから最新のWindows版zipをダウンロードします。（-win.zipファイルリンクの一覧から一番上のものを最新版と見なしてダウンロードします）
2. インストール済の旧verを削除して最新版を展開しなおします。（旧フォルダを一度削除するので注意）

### 注意

* とりあえずの突貫仕様です。自己責任でお願いします。
* 公式サイトのマークアップとzipファイルの構造に依存している処理があるため、pixiv側の仕様変更があると不具合が起こる可能性があります。

---

###### Changelog

* 2018.10.10 実行ポリシーをRemoteSignedからBypassへ変更
* 2018.10.10 公開

---

[連絡先@Twitter](https://twitter.com/trs_torosalmon)
