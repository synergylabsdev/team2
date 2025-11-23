# Script to fix permission_handler namespace issue
# Run this after 'flutter pub get' if you encounter namespace errors

$permissionHandlerPath = "$env:LOCALAPPDATA\Pub\Cache\hosted\pub.dev\permission_handler-7.2.0\android\build.gradle"

if (Test-Path $permissionHandlerPath) {
    $content = Get-Content $permissionHandlerPath -Raw
    
    if ($content -notmatch 'namespace\s*=') {
        # Add namespace after android { block
        $content = $content -replace '(android\s*\{)', "`$1`n    namespace = `"com.baseflow.permissionhandler`"`n"
        Set-Content -Path $permissionHandlerPath -Value $content
        Write-Host "✓ Fixed permission_handler namespace" -ForegroundColor Green
    } else {
        Write-Host "✓ Namespace already exists" -ForegroundColor Green
    }
} else {
    Write-Host "✗ Permission handler path not found: $permissionHandlerPath" -ForegroundColor Red
    Write-Host "Make sure you've run 'flutter pub get' first" -ForegroundColor Yellow
}

