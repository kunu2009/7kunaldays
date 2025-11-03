# Build Script for Kunal's Evolution App
# PowerShell script to build the APK

Write-Host "🚀 Building Kunal's Evolution App..." -ForegroundColor Cyan

# Step 1: Clean previous builds
Write-Host "`n📦 Cleaning previous builds..." -ForegroundColor Yellow
flutter clean

# Step 2: Get dependencies
Write-Host "`n📥 Fetching dependencies..." -ForegroundColor Yellow
flutter pub get

# Step 3: Run build_runner (skip if already generated)
Write-Host "`n🔧 Generating Hive adapters..." -ForegroundColor Yellow
# Uncomment if you need to regenerate adapters:
# flutter pub run build_runner build --delete-conflicting-outputs

# Step 4: Build release APK
Write-Host "`n🏗️ Building release APK..." -ForegroundColor Yellow
flutter build apk --release

# Step 5: Show output location
Write-Host "`n✅ Build complete!" -ForegroundColor Green
Write-Host "📱 APK Location:" -ForegroundColor Cyan
Write-Host "   build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor White

# Step 6: Optional - Get APK size
$apkPath = "build\app\outputs\flutter-apk\app-release.apk"
if (Test-Path $apkPath) {
    $size = (Get-Item $apkPath).Length / 1MB
    Write-Host "`n📊 APK Size: $([math]::Round($size, 2)) MB" -ForegroundColor Cyan
}

Write-Host "`n🎯 Next Steps:" -ForegroundColor Yellow
Write-Host "   1. Transfer APK to your Android device" -ForegroundColor White
Write-Host "   2. Enable 'Install from Unknown Sources'" -ForegroundColor White
Write-Host "   3. Install and grant notification permissions" -ForegroundColor White
Write-Host "   4. Start your evolution journey! 🔥" -ForegroundColor White

Write-Host "`n'Focus. Consistency. Growth.'" -ForegroundColor Magenta
