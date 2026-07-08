# Verilog Project Template 
用於 IC 設計的 Verilog Template  
資料夾架構、自動化編譯與模擬的 `Makefile`，以及快速提交至 GitHub 的自動化腳本，用於新的專案。

## 📂 Directory Structure

```text
.
├── src/                # 存放所有硬體設計的 RTL 原始碼 (e.g., top.v, alu.v)
├── tb/                 # 存放所有 Testbench 測試檔 (e.g., tb_top.v)
├── Makefile            # 自動化編譯與模擬腳本 (vcs)
|── github_upload.sh    # Git 自動上傳到 github 用 git 管理
```
<img width="353" height="420" alt="image" src="https://github.com/user-attachments/assets/a2a2be98-a7c4-4b1a-bd3b-f8bfe17adbc4" />

## Downlaod from GitHub
Check first:  
git --version  
git clone https網址.git

## Upload to GitHub
use github_upload.sh 

## Run Simulation
use Makefile


