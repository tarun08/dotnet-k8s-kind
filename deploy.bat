@echo off
setlocal enabledelayedexpansion

:: === Config ===
set APP_NAME=mywebapi
set NAMESPACE=dotnet-app

echo 🔧 Building Docker image...
docker build -t %APP_NAME%:local .

echo 📦 Loading image into kind cluster...
kind load docker-image %APP_NAME%:local

echo 🚀 Applying Kubernetes manifests...
kubectl apply -f k8s\namespace.yml
kubectl apply -f k8s\deployment\
kubectl apply -f k8s\service\

echo ⏳ Waiting for deployment to become ready...
kubectl rollout status deployment/%APP_NAME%-deployment -n %NAMESPACE%

echo ✅ Done! Access the app at: http://localhost:8080/weatherforecast

pause
