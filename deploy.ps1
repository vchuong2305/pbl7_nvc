Write-Host "🚀 Bắt đầu deploy Weather Forecasting App lên Railway" -ForegroundColor Green

# Check if Railway CLI is installed
if (!(Get-Command railway -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Railway CLI chưa được cài đặt. Vui lòng cài đặt:" -ForegroundColor Red
    Write-Host "npm install -g @railway/cli"
    Write-Host "railway login"
    exit 1
}

# Deploy Backend
Write-Host "📦 Deploy Backend..." -ForegroundColor Yellow
Set-Location backend
railway init --name "weather-backend" --source .
railway up

$BACKEND_URL = railway domain

Write-Host "✅ Backend deployed at: $BACKEND_URL" -ForegroundColor Green

# Deploy Frontend
Write-Host "🌐 Deploy Frontend..." -ForegroundColor Yellow
Set-Location ../weather-forecast
railway init --name "weather-frontend" --source .

# Set environment variables for frontend
railway variables set NEXT_PUBLIC_API_URL=$BACKEND_URL
railway variables set NEXT_PUBLIC_BACKEND_URL=$BACKEND_URL

railway up

Write-Host "✅ Frontend deployed!" -ForegroundColor Green
Write-Host ""
Write-Host "🎉 Deployment hoàn thành!" -ForegroundColor Cyan
Write-Host "Backend URL: $BACKEND_URL"
Write-Host "Frontend sẽ có URL riêng được Railway cung cấp"
Write-Host ""
Write-Host "📝 Đừng quên cấu hình các biến môi trường trong Railway dashboard:" -ForegroundColor Yellow
Write-Host "- OPENWEATHER_API_KEY: API key từ OpenWeatherMap"
