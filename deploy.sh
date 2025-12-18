#!/bin/bash

echo "🚀 Bắt đầu deploy Weather Forecasting App lên Railway"

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI chưa được cài đặt. Vui lòng cài đặt:"
    echo "npm install -g @railway/cli"
    echo "railway login"
    exit 1
fi

# Deploy Backend
echo "📦 Deploy Backend..."
cd backend
railway init --name "weather-backend" --source .
railway up

BACKEND_URL=$(railway domain)

echo "✅ Backend deployed at: $BACKEND_URL"

# Deploy Frontend
echo "🌐 Deploy Frontend..."
cd ../weather-forecast
railway init --name "weather-frontend" --source .

# Set environment variables for frontend
railway variables set NEXT_PUBLIC_API_URL=$BACKEND_URL
railway variables set NEXT_PUBLIC_BACKEND_URL=$BACKEND_URL

railway up

echo "✅ Frontend deployed!"
echo ""
echo "🎉 Deployment hoàn thành!"
echo "Backend URL: $BACKEND_URL"
echo "Frontend sẽ có URL riêng được Railway cung cấp"
echo ""
echo "📝 Đừng quên cấu hình các biến môi trường trong Railway dashboard:"
echo "- OPENWEATHER_API_KEY: API key từ OpenWeatherMap"
