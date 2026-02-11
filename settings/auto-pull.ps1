# ========================================================
# auto-pull.ps1（最終安定版）
# - index.lock 対策
# - 未コミット変更があっても安全
# ========================================================

$ErrorActionPreference = 'Stop'

$RepoPath = "C:\Users\ibuki\OneDrive\ドキュメント\GitHub\first-program"

Write-Output "========================================"
Write-Output "Running auto-pull.ps1 at $(Get-Date)"
Write-Output "Repository path: $RepoPath"

if (-Not (Test-Path $RepoPath)) {
    Write-Error "Repository path not found"
    exit 1
}

Set-Location $RepoPath

# index.lock 対策
$LockFile = ".git\index.lock"
if (Test-Path $LockFile) {
    Write-Warning "index.lock が存在します。削除します。"
    Remove-Item $LockFile -Force
}

# 未コミット変更があるか確認
$changes = git status --porcelain
if ($changes) {
    Write-Warning "未コミット変更あり → pull をスキップします"
    Write-Output "（保存時の auto-git.sh に任せます）"
    Write-Output "========================================"
    exit 0
}

# 安全に pull
try {
    Write-Output "git pull --rebase を実行します"
    git pull --rebase
    Write-Output "git pull 完了"
}
catch {
    Write-Warning "rebase 失敗 → 通常 pull を試行"
    git pull
}

Write-Output "auto-pull.ps1 finished successfully"
Write-Output "========================================"
