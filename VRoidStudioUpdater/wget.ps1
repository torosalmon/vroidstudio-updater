# ******************************************************************************
# VRoid Studio �A�b�v�f�[�^�[
# ******************************************************************************

# ==============================================================================
# VRoid Studio���A�b�v�f�[�g���܂�
#
# �E����v��
#   PowerShell 5.0�ȍ~�iInvoke-WebRequest��Expand-Archive�����삷����j
#
# �E���������l
#   Site: https://trs.mn/portfolio/
#   Twitter: https://twitter.com/trs_torosalmon
#
# �EVRoid Studio (c) pixiv
#   https://vroid.pixiv.net/
# ==============================================================================

# �ݒ�t�@�C��
$ini_file = ".\config.ini"

# �_�E�����[�h�\�����I�[�o�[���C�ł��Ԃ����Ă��܂�����d���Ȃ��̂�
write-host("")
write-host("")
write-host("")
write-host("")
write-host("")
write-host("")

# ===================
# ini�t�@�C���ǂݍ���
# ===================
# http://capm-network.com/?tag=PowerShell%E8%A8%AD%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E8%AA%AD%E3%81%BF%E8%BE%BC%E3%81%BF

function load_ini($file) {
  $lines = get-content $file
  foreach($line in $lines) {

    # �R�����g�Ƌ�s������
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
# �C���X�g�[���t�H���_���󂾂�����A���[�g���o���ď������~�߂�
# ============================================================

if(!($ini["install_dir"])) {
  Read-Host "�yVRoid Studio �A�b�v�f�[�^�[�z config.ini��VRoid Studio�̃C���X�g�[���t�H���_���ݒ肳��Ă��܂���BEnter�L�[�������ăX�N���v�g���I�����܂��B"
  exit
}

# ==================
# �E�F�u�y�[�W�����
# ==================
# https://qiita.com/hiron2225/items/eb5cbf18fed27b96a622

# �y�[�W�փA�N�Z�X
$response = Invoke-WebRequest -Uri ($ini["site"] + $ini["download_page"]) -UseBasicParsing
write-host("�yVRoid Studio �A�b�v�f�[�^�[�z " + "�_�E�����[�h�y�[�W�փA�N�Z�X")

# �y�[�W����[*-win.zip]�̃����N�𒊏o����
# �z��[0]���ŐVver�����N�Ƃ݂Ȃ�
$links = $response.Links | Where-Object {$_.href -like "*-win.zip"} | Select-Object -ExpandProperty href

# �t�@�C�����̒��o
$dl_file = Split-Path $links[0] -Leaf

# ==========================
# �_�E�����[�h�̕K�v���𔻒�
# ==========================

# �X�N���v�g���s�t�H���_
$script_path = $MyInvocation.MyCommand.Path
$script_dir = Split-Path $script_path -Parent

# �X�N���v�g���s�t�H���_���ɃT�C�g�̍ŐVver�t�@�C�������݂��Ȃ���΃_�E�����[�h���J�n����
if(!(Test-Path $dl_file)) {

  # ���݃C���X�g�[������Ă���ver���폜����
  if(Test-Path $ini["install_dir"]) {
    Remove-Item -path $ini["install_dir"] -recurse -force
  }

  # ==================
  # �_�E�����[�h�̊J�n
  # ==================

  # �_�E�����[�h�t�@�C���̃t���p�X���\�z
  $dl_uri = $ini["site"] + $links[0]

  # �_�E�����[�h���ē����t�@�C���ŕۑ�
  write-host("�yVRoid Studio �A�b�v�f�[�^�[�z " + $dl_file + " �_�E�����[�h��")
  Invoke-WebRequest -Uri $dl_uri -OutFile $dl_file

  # =========
  # zip����
  # =========
  # https://cheshire-wara.com/powershell/ps-cmdlets/item-file/expand-archive/

  # �C���X�g�[����t�H���_�𕪊�����
  # ���z�z����Ă���zip�̃t�H���_�\���ɍ��킹�ĉ𓀐�𒲐����鏈��
  # �e�t�H���_
  $install_dir_parent = Split-Path $ini["install_dir"] -Parent
  # ���[�t�H���_
  $install_dir_leaf = Split-Path $ini["install_dir"] -Leaf

  # �C���X�g�[����e�t�H���_��zip��
  write-host("�yVRoid Studio �A�b�v�f�[�^�[�z " + $dl_file + "���𓀂��Ă��܂��B")
  Expand-Archive -Path $dl_file -DestinationPath $install_dir_parent -Force

  # �{���̃t�H���_���փ��l�[��
  $expand_app = Get-ChildItem $install_dir_parent -Directory
  $expand_app = $install_dir_parent + "\" + $expand_app
  Rename-Item $expand_app $install_dir_leaf

  Read-Host "�yVRoid Studio �A�b�v�f�[�^�[�z �A�b�v�f�[�g���������܂����BEnter�L�[�������ăX�N���v�g���I�����܂��B"
} else {
  Read-Host "�yVRoid Studio �A�b�v�f�[�^�[�z �ŐV�łɃA�b�v�f�[�g�ςł��BEnter�L�[�������ăX�N���v�g���I�����܂��B"
}
