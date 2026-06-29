@echo off
REM ============================================================
REM  deploy.cmd - 一鍵把遊戲更新部署到 GitHub Pages
REM
REM  用法：
REM    deploy.cmd                直接部署（自動用時間當 commit 訊息）
REM    deploy.cmd 修好音樂問題    用自訂訊息部署
REM
REM  部署後 1~2 分鐘，網站會自動更新：
REM    https://skieslee.github.io/ai-playground/
REM ============================================================

setlocal
cd /d "%~dp0"

REM --- commit 訊息：用參數，沒給就用日期時間 ---
set "MSG=%*"
if "%MSG%"=="" set "MSG=Update game (%date% %time%)"

echo.
echo === 1/3 加入變更 ===
git add -A

REM --- 有變更才 commit（沒變更就跳過，避免出錯）---
git diff --cached --quiet
if errorlevel 1 (
  echo.
  echo === 2/3 建立 commit ===
  echo    訊息：%MSG%
  git commit -m "%MSG%"
) else (
  echo.
  echo === 2/3 沒有檔案變更，略過 commit ===
)

echo.
echo === 3/3 推送到 GitHub ===
git push
if errorlevel 1 (
  echo.
  echo [錯誤] 推送失敗。請確認網路與 GitHub 登入憑證後再試一次。
  pause
  exit /b 1
)

echo.
echo ============================================================
echo  完成！1~2 分鐘後到手機/瀏覽器重新整理即可看到更新：
echo    https://skieslee.github.io/ai-playground/
echo ============================================================
pause
