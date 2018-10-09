# ******************************************************************************
# VRoid Studio アップデーター
# ******************************************************************************

# ==============================================================================
# VRoid Studioをアップデートします
#
# ・動作要件
#   PowerShell 5.0以降（Invoke-WebRequestとExpand-Archiveが動作する環境）
#
# ・これ作った人
#   Site: https://trs.mn/portfolio/
#   Twitter: https://twitter.com/trs_torosalmon
#
# ・VRoid Studio (c) pixiv
#   https://vroid.pixiv.net/
# ==============================================================================

# 設定ファイル
$ini_file = ".\config.ini"

# ダウンロード表示がオーバーレイでかぶさってしまうから仕方ないのね
write-host("")
write-host("")
write-host("")
write-host("")
write-host("")
write-host("")

# ===================
# iniファイル読み込み
# ===================
# http://capm-network.com/?tag=PowerShell%E8%A8%AD%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E8%AA%AD%E3%81%BF%E8%BE%BC%E3%81%BF

function load_ini($file) {
  $lines = get-content $file
  foreach($line in $lines) {

    # コメントと空行を除去
    if($line -match "^$") {
      continue
    }
    if($line -match "^\s*;") {
      continue
    }

    $param = $line.split("=", 2)
    # write-host("key : " + $param[0])
    # write-host("val : " + $param[1])
    $ini[$param[0]] = $param[1]
  }
}

$ini = @{}
load_ini $ini_file

# ============================================================
# インストールフォルダが空だったらアラートを出して処理を止める
# ============================================================

if(!($ini["install_dir"])) {
  Read-Host "【VRoid Studio アップデーター】 config.iniにVRoid Studioのインストールフォルダが設定されていません。Enterキーを押してスクリプトを終了します。"
  exit
}

# ==================
# ウェブページを解析
# ==================
# https://qiita.com/hiron2225/items/eb5cbf18fed27b96a622

# ページへアクセス
$response = Invoke-WebRequest -Uri ($ini["site"] + $ini["download_page"]) -UseBasicParsing
write-host("【VRoid Studio アップデーター】 " + "ダウンロードページへアクセス")

# ページから[*-win.zip]のリンクを抽出する
# 配列[0]を最新verリンクとみなす
$links = $response.Links | Where-Object {$_.href -like "*-win.zip"} | Select-Object -ExpandProperty href

# ファイル名の抽出
$dl_file = Split-Path $links[0] -Leaf

# ==========================
# ダウンロードの必要性を判定
# ==========================

# スクリプト実行フォルダ
$script_path = $MyInvocation.MyCommand.Path
$script_dir = Split-Path $script_path -Parent

# スクリプト実行フォルダ内にサイトの最新verファイルが存在しなければダウンロードを開始する
if(!(Test-Path $dl_file)) {

  # 現在インストールされているverを削除する
  if(Test-Path $ini["install_dir"]) {
    Remove-Item -path $ini["install_dir"] -recurse -force
  }

  # ==================
  # ダウンロードの開始
  # ==================

  # ダウンロードファイルのフルパスを構築
  $dl_uri = $ini["site"] + $links[0]

  # ダウンロードして同名ファイルで保存
  write-host("【VRoid Studio アップデーター】 " + $dl_file + " ダウンロード中")
  Invoke-WebRequest -Uri $dl_uri -OutFile $dl_file

  # =========
  # zipを解凍
  # =========
  # https://cheshire-wara.com/powershell/ps-cmdlets/item-file/expand-archive/

  # インストール先フォルダを分割する
  # ※配布されているzipのフォルダ構造に合わせて解凍先を調整する処理
  # 親フォルダ
  $install_dir_parent = Split-Path $ini["install_dir"] -Parent
  # 末端フォルダ
  $install_dir_leaf = Split-Path $ini["install_dir"] -Leaf

  # インストール先親フォルダへzip解凍
  write-host("【VRoid Studio アップデーター】 " + $dl_file + "を解凍しています。")
  Expand-Archive -Path $dl_file -DestinationPath $install_dir_parent -Force

  # 本来のフォルダ名へリネーム
  $expand_app = Get-ChildItem $install_dir_parent -Directory
  $expand_app = $install_dir_parent + "\" + $expand_app
  Rename-Item $expand_app $install_dir_leaf

  Read-Host "【VRoid Studio アップデーター】 アップデートが完了しました。Enterキーを押してスクリプトを終了します。"
} else {
  Read-Host "【VRoid Studio アップデーター】 最新版にアップデート済です。Enterキーを押してスクリプトを終了します。"
}
