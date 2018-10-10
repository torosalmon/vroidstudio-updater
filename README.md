# VRoid Studio アップデーター

pixivのVRoid Studioを一発アップデートしてくれるマン

## 動作要件
Windows PowerShell 5.0以上

## 使い方

1. 【初回のみ】config.iniにVRoid Studioのインストール先フォルダを指定し保存します
2. VRoidStudioUpdate.batを立ち上げます

## 処理

1. 公式サイトのHTMLから「-win.zip」のリンク一覧を抜き出します
2. 既に最新版をダウンロード済みの場合はアップデーターを終了します
3. リンク一覧の一番上のzipを最新版と見なしてダウンロードします
4. インストール済の旧verを削除して最新版を展開しなおします。（旧フォルダを一度削除しているので注意）

### 注意

* とりあえずの突貫仕様です。自己責任でお願いします。
* 公式サイトのHTMLマークアップとzipファイルの構造に依存している処理があるため、pixiv側の仕様変更があると不具合が起こる可能性があります。

---

###### Changelog

* 2018.10.10 実行ポリシーをRemoteSignedからBypassへ変更
* 2018.10.10 公開

---

[連絡先@Twitter](https://twitter.com/trs_torosalmon)
