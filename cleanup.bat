@echo off
setlocal enabledelayedexpansion

:: === Config ===
set APP_NAME=mywebapi
set NAMESPACE=dotnet-app

echo 🧹 Cleaning up...

kubectl delete service --namespace=%NAMESPACE% %APP_NAME%-service
kubectl delete deployment --namespace=%NAMESPACE% %APP_NAME%-deployment
kubectl delete namespace %NAMESPACE%

echo ✅ Clean-up done.

pause
