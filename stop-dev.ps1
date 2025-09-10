# Multi-Language Docker Development Environment - Stop Script
# Run this script to stop all services

Write-Host "🛑 Stopping Multi-Language Docker Development Environment" -ForegroundColor Red
Write-Host "===============================================" -ForegroundColor Blue

Write-Host "🔄 Stopping all services..." -ForegroundColor Yellow
docker-compose -f docker-compose.dev.yml down

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ All services stopped successfully!" -ForegroundColor Green
} else {
    Write-Host "`n❌ Some services may still be running. Check manually with:" -ForegroundColor Red
    Write-Host "   docker ps" -ForegroundColor White
}

Write-Host "`n🧹 Optional cleanup commands:" -ForegroundColor Blue
Write-Host "   • Remove volumes:  docker-compose -f docker-compose.dev.yml down -v" -ForegroundColor White
Write-Host "   • Remove images:   docker-compose -f docker-compose.dev.yml down --rmi all" -ForegroundColor White
Write-Host "   • Full cleanup:    docker system prune -f" -ForegroundColor White

Write-Host "`nPress any key to exit..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")