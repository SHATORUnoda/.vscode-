#!/bin/bash
# auto-pull.sh (Ubuntu Native Version)

# スクリプトの場所からリポジトリのルートへ移動
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT" || { echo "Failed to enter $REPO_ROOT"; exit 1; }

echo "[auto-pull] Checking for updates at $(date)"

# リモート(GitHub)の最新情報を取得
git fetch origin main

# ローカルの未保存分を捨てて、リモートの状態に強制一致させる
# 他のデバイスで書いたコードを確実に反映させるための設定です
git reset --hard origin/main

echo "[auto-pull] Sync completed at $REPO_ROOT"