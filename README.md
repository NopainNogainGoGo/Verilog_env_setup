# Verilog Project Template 

這是一個用於數位邏輯與 IC 設計的 Verilog 專案基礎模板（Template）。
內建標準的資料夾架構、自動化編譯與模擬的 `Makefile`，以及快速提交至 GitHub 的自動化腳本，適合用於快速啟動新的硬體描述語言專案。

## 📂 Directory Structure

```text
.
├── src/                # 存放所有硬體設計的 RTL 原始碼 (e.g., top.v, alu.v)
├── tb/                 # 存放所有 Testbench 測試檔 (e.g., tb_top.v)
├── Makefile            # 自動化編譯與模擬腳本 (vcs)
|── github_upload.sh    # Git 自動上傳到 github 用 git 管理
