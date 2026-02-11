#!/bin/bash
# auto-git.sh (Ubuntu Native Version)

# スクリプトの場所からリポジトリのルートへ移動
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT" || { echo "Failed to enter $REPO_ROOT"; exit 1; }

# 現在のブランチ名を取得
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# 変更をすべて追加
git add .

# コミットメッセージの作成
MESSAGE="Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"

# 変更がある場合のみ実行
if ! git diff-index --quiet HEAD --; then
    git commit -m "$MESSAGE"
    
    # Push実行 (SSH設定が済んでいればパスワードなしで飛びます)
    if git push origin "$BRANCH"; then
        echo "[auto-git] Successfully pushed to $BRANCH"
    else
        echo "[auto-git] Push failed. Check your network or SSH key."
    fi
else
    echo "[auto-git] No changes detected."
fi