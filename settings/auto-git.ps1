# スクリプトの場所から見て「1つ上のディレクトリ」を作業ディレクトリに設定
$REPO_PATH = "$PSScriptRoot\.."

# ディレクトリへ移動
Set-Location $REPO_PATH

# 変更があるか確認
$status = git status --porcelain

if ($null -ne $status) {
    # 変更がある場合のみ実行
    git add -A
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    git commit -m "Auto commit at $timestamp"
    
    if ($LASTEXITCODE -ne 0) {
        Write-Output "コミットに失敗しました"
    }
} else {
    Write-Output "変更はありません。スキップします。"
}

# リモートへプッシュ
git push origin main

if ($LASTEXITCODE -ne 0) {
    Write-Output "プッシュに失敗しました"
}