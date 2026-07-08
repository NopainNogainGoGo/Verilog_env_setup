#!/usr/bin/env bash
# ==============================================================================
# GitHub 快速上傳與自動化設定腳本
#
# 使用方式：
#   chmod +x github_upload.sh
#   bash github_upload.sh
# ==============================================================================

set -e

unset SSH_ASKPASS
unset GIT_ASKPASS

echo "✅ 使用純文字終端機 Git 認證。"

# ------------------------------------------------------------------------------
# 檢查 Git 身分
# ------------------------------------------------------------------------------
GIT_USER=$(git config --global user.name || true)
GIT_EMAIL=$(git config --global user.email || true)

if [ -z "$GIT_USER" ] || [ -z "$GIT_EMAIL" ]; then
    echo "📊 [身分設定] 偵測到尚未設定 Git 身分..."

    read -r -p "👉 請輸入您的 GitHub 帳號名稱: " input_user
    read -r -p "👉 請輸入您的 GitHub 電子信箱: " input_email

    git config --global user.name "$input_user"
    git config --global user.email "$input_email"

    echo "✅ Git 身分設定完成。"
else
    echo "✅ 已偵測到 Git 身分：$GIT_USER <$GIT_EMAIL>"
fi

# ------------------------------------------------------------------------------
# 啟用 Git 憑證記憶
# ------------------------------------------------------------------------------
git config --global credential.helper store
echo "✅ [已啟用] Git 憑證記憶功能。"

# ------------------------------------------------------------------------------
# 自動建立 IC Design 專用 .gitignore
# ------------------------------------------------------------------------------
if [ ! -f .gitignore ]; then
    echo "📝 [配置] 正在建立 .gitignore..."

    cat > .gitignore <<'EOT'
# Simulation outputs
simv
simv.daidir/
csrc/
*.log
*.key
*.fsdb
*.vcd
*.vpd
nWaveLog/

# EDA tool folders
INCA_libs/
work/
build/

# Temporary files
*.bak
*.tmp
*~
EOT

    echo "✅ .gitignore 建立完成。"
else
    echo "✅ 已存在 .gitignore，略過建立。"
fi

# ------------------------------------------------------------------------------
# 初始化 Git
# ------------------------------------------------------------------------------
if [ ! -d .git ]; then
    git init
    echo "✅ Git repository 初始化完成。"
fi

# ------------------------------------------------------------------------------
# 加入檔案並 Commit
# ------------------------------------------------------------------------------
git add -A

if [ -z "$(git status --porcelain)" ]; then
    echo "ℹ️ 沒有偵測到任何新變更。"
else
    read -r -p "💬 請輸入 Commit 訊息 [預設: Initial commit]: " commit_msg

    if [ -z "$commit_msg" ]; then
        commit_msg="Initial commit"
    fi

    git commit -m "$commit_msg"
    echo "✅ Commit 完成。"
fi

# ------------------------------------------------------------------------------
# 設定 GitHub 遠端
# ------------------------------------------------------------------------------
REMOTE_URL=$(git remote get-url origin 2>/dev/null || true)

if [ -z "$REMOTE_URL" ]; then
    echo "GitHub 遠端網址格式範例："
    echo "https://github.com/你的帳號/MIPS_SingleCycle_CPU.git"
    read -r -p "👉 請貼上 GitHub 遠端網址: " input_url

    git branch -M main
    git remote add origin "$input_url"

    echo "✅ 已加入 GitHub 遠端：$input_url"
else
    echo "✅ 已存在 GitHub 遠端：$REMOTE_URL"
fi

# ------------------------------------------------------------------------------
# Push 到 GitHub
# ------------------------------------------------------------------------------
echo "========================================================"
echo "📢 準備執行 git push"
echo "第一次 push 時："
echo "Username 請輸入 GitHub 帳號"
echo "Password 請輸入 GitHub Personal Access Token"
echo "========================================================"

git branch -M main
git push -u origin main

echo "🎉 上傳完成！"