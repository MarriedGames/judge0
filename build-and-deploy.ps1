# PowerShell Script de build e deploy do Judge0 Custom
# Usage: .\build-and-deploy.ps1

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Judge0 Custom - Build and Deploy Script" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is installed
try {
    docker --version | Out-Null
} catch {
    Write-Host "Error: Docker is not installed" -ForegroundColor Red
    exit 1
}

# Check if Docker Compose is installed
try {
    docker-compose --version | Out-Null
} catch {
    Write-Host "Error: Docker Compose is not installed" -ForegroundColor Red
    exit 1
}

# Step 1: Create directories
Write-Host "Step 1: Creating required directories..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "unity-libs" | Out-Null
New-Item -ItemType Directory -Force -Path "unreal-headers" | Out-Null
Write-Host "✓ Directories created" -ForegroundColor Green
Write-Host ""

# Step 2: Build Docker image
Write-Host "Step 2: Building Docker image..." -ForegroundColor Yellow
docker-compose -f docker-compose.custom.yml build
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Docker image built successfully" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to build Docker image" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 3: Start services
Write-Host "Step 3: Starting services..." -ForegroundColor Yellow
docker-compose -f docker-compose.custom.yml up -d
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Services started" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to start services" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 4: Wait for database
Write-Host "Step 4: Waiting for database to be ready..." -ForegroundColor Yellow
Start-Sleep -Seconds 10
Write-Host "✓ Database ready" -ForegroundColor Green
Write-Host ""

# Step 5: Initialize database
Write-Host "Step 5: Initializing database..." -ForegroundColor Yellow
docker-compose -f docker-compose.custom.yml exec -T server rails db:create db:migrate db:seed
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Database initialized" -ForegroundColor Green
} else {
    Write-Host "⚠ Database might already be initialized" -ForegroundColor Yellow
}
Write-Host ""

# Step 6: Check status
Write-Host "Step 6: Checking service status..." -ForegroundColor Yellow
docker-compose -f docker-compose.custom.yml ps
Write-Host ""

# Step 7: Display access information
Write-Host "=========================================" -ForegroundColor Green
Write-Host "✓ Judge0 Custom deployed successfully!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
Write-Host ""
Write-Host "API Endpoint: " -NoNewline
Write-Host "http://localhost:2358" -ForegroundColor Yellow
Write-Host "Languages Endpoint: " -NoNewline
Write-Host "http://localhost:2358/languages" -ForegroundColor Yellow
Write-Host ""
Write-Host "To view logs, run:"
Write-Host "docker-compose -f docker-compose.custom.yml logs -f" -ForegroundColor Yellow
Write-Host ""
Write-Host "To stop services, run:"
Write-Host "docker-compose -f docker-compose.custom.yml down" -ForegroundColor Yellow
Write-Host ""

# Test API
Write-Host "Testing API..." -ForegroundColor Yellow
Start-Sleep -Seconds 5
try {
    $response = Invoke-WebRequest -Uri "http://localhost:2358/languages" -UseBasicParsing -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        Write-Host "✓ API is responding" -ForegroundColor Green
    }
} catch {
    Write-Host "⚠ API might not be ready yet, please wait a few seconds" -ForegroundColor Yellow
}
Write-Host ""

Write-Host "Done! 🎉" -ForegroundColor Cyan
