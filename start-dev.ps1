# Multi-Language Docker Development Environment Startup Script
# Run this script to start all services in development mode

Write-Host "🚀 Starting Multi-Language Docker Development Environment" -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Blue

# Check if Docker Desktop is running
Write-Host "🐳 Checking Docker Desktop..." -ForegroundColor Yellow
$dockerProcess = Get-Process "Docker Desktop" -ErrorAction SilentlyContinue
if (!$dockerProcess) {
    Write-Host "❌ Docker Desktop is not running. Please start Docker Desktop first!" -ForegroundColor Red
    Write-Host "   Download from: https://www.docker.com/products/docker-desktop/" -ForegroundColor Cyan
    Read-Host "Press Enter after starting Docker Desktop"
}

# Check if docker command is available
try {
    docker --version | Out-Null
    Write-Host "✅ Docker is available" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker command not found. Please ensure Docker Desktop is properly installed." -ForegroundColor Red
    exit 1
}

# Start development environment
Write-Host "`n🏗️  Building and starting all services..." -ForegroundColor Yellow
docker-compose -f docker-compose.dev.yml up --build -d

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ All services started successfully!" -ForegroundColor Green
    Write-Host "`n🌐 Available Services:" -ForegroundColor Blue
    Write-Host "   • Python Flask API:    http://localhost:5000" -ForegroundColor Cyan
    Write-Host "   • Node.js Express API: http://localhost:3000" -ForegroundColor Cyan
    Write-Host "   • Java Spring Boot:    http://localhost:8080" -ForegroundColor Cyan
    Write-Host "   • Go Gin API:          http://localhost:8081" -ForegroundColor Cyan
    Write-Host "   • .NET API:            http://localhost:5001" -ForegroundColor Cyan
    Write-Host "   • Nginx Load Balancer: http://localhost:80" -ForegroundColor Cyan
    Write-Host "   • PostgreSQL:          localhost:5432" -ForegroundColor Cyan
    Write-Host "   • Redis:               localhost:6379" -ForegroundColor Cyan
    
    Write-Host "`n📊 Useful Commands:" -ForegroundColor Blue
    Write-Host "   • View logs:    docker-compose -f docker-compose.dev.yml logs -f" -ForegroundColor White
    Write-Host "   • Stop all:     docker-compose -f docker-compose.dev.yml down" -ForegroundColor White
    Write-Host "   • Restart:      docker-compose -f docker-compose.dev.yml restart" -ForegroundColor White
    Write-Host "   • Check status: docker-compose -f docker-compose.dev.yml ps" -ForegroundColor White
    
    Write-Host "`n🚀 Quick Test:" -ForegroundColor Blue
    Write-Host "   Invoke-RestMethod -Uri http://localhost:5000/health" -ForegroundColor White
    
} else {
    Write-Host "`n❌ Failed to start services. Check the logs above." -ForegroundColor Red
}

Write-Host "`nPress any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")