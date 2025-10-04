#!/bin/bash

# Script de build e deploy do Judge0 Custom
# Usage: ./build-and-deploy.sh

set -e

echo "========================================="
echo "Judge0 Custom - Build and Deploy Script"
echo "========================================="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Error: Docker is not installed${NC}"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Error: Docker Compose is not installed${NC}"
    exit 1
fi

# Step 1: Create directories
echo -e "${YELLOW}Step 1: Creating required directories...${NC}"
mkdir -p unity-libs
mkdir -p unreal-headers
echo -e "${GREEN}✓ Directories created${NC}"
echo ""

# Step 2: Build Docker image
echo -e "${YELLOW}Step 2: Building Docker image...${NC}"
docker-compose -f docker-compose.custom.yml build
echo -e "${GREEN}✓ Docker image built successfully${NC}"
echo ""

# Step 3: Start services
echo -e "${YELLOW}Step 3: Starting services...${NC}"
docker-compose -f docker-compose.custom.yml up -d
echo -e "${GREEN}✓ Services started${NC}"
echo ""

# Step 4: Wait for database
echo -e "${YELLOW}Step 4: Waiting for database to be ready...${NC}"
sleep 10
echo -e "${GREEN}✓ Database ready${NC}"
echo ""

# Step 5: Initialize database
echo -e "${YELLOW}Step 5: Initializing database...${NC}"
docker-compose -f docker-compose.custom.yml exec -T server rails db:create db:migrate db:seed
echo -e "${GREEN}✓ Database initialized${NC}"
echo ""

# Step 6: Check status
echo -e "${YELLOW}Step 6: Checking service status...${NC}"
docker-compose -f docker-compose.custom.yml ps
echo ""

# Step 7: Display access information
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}✓ Judge0 Custom deployed successfully!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo -e "API Endpoint: ${YELLOW}http://localhost:2358${NC}"
echo -e "Languages Endpoint: ${YELLOW}http://localhost:2358/languages${NC}"
echo ""
echo "To view logs, run:"
echo -e "${YELLOW}docker-compose -f docker-compose.custom.yml logs -f${NC}"
echo ""
echo "To stop services, run:"
echo -e "${YELLOW}docker-compose -f docker-compose.custom.yml down${NC}"
echo ""

# Test API
echo -e "${YELLOW}Testing API...${NC}"
sleep 5
RESPONSE=$(curl -s http://localhost:2358/languages | head -c 50)
if [ ! -z "$RESPONSE" ]; then
    echo -e "${GREEN}✓ API is responding${NC}"
else
    echo -e "${RED}⚠ API might not be ready yet, please wait a few seconds${NC}"
fi
echo ""

echo "Done! 🎉"
