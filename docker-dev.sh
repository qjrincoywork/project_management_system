#!/bin/bash

# Project Management System - Docker Development Setup
# This script helps set up the development environment

echo "🚀 Setting up Project Management System Development Environment"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "❌ docker-compose is not installed. Please install it and try again."
    exit 1
fi

echo "✅ Docker is running"

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file..."
    cp .env.example .env 2>/dev/null || echo "APP_NAME=\"Project Management System\"
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost:8080

LOG_CHANNEL=stack
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=project_management
DB_USERNAME=laravel
DB_PASSWORD=laravel_password

CACHE_DRIVER=file
QUEUE_CONNECTION=sync
SESSION_DRIVER=file

MAIL_MAILER=log
MAIL_FROM_ADDRESS=\"hello@example.com\"
MAIL_FROM_NAME=\"\${APP_NAME}\"" > .env
    echo "✅ .env file created"
else
    echo "✅ .env file already exists"
fi

# Build and start containers
echo "🔨 Building and starting containers..."
docker-compose up -d --build

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
sleep 15

# Install Composer dependencies
echo "📦 Installing Composer dependencies..."
docker-compose exec app composer install

# Generate application key
echo "🔑 Generating application key..."
docker-compose exec app php artisan key:generate

# Run migrations
echo "🗄️ Running database migrations..."
docker-compose exec app php artisan migrate

# Check Node.js version
echo "🔍 Checking Node.js version..."
docker-compose exec app node --version

# Install NPM dependencies
echo "📦 Installing NPM dependencies..."
docker-compose exec app npm install

# Build assets
echo "🎨 Building assets..."
docker-compose exec app npm run build

echo "✅ Development environment is ready!"
echo ""
echo "🌐 Application: http://localhost:8080"
echo "🗄️ Database: localhost:3306"
echo ""
echo "📝 Useful commands:"
echo "  docker-compose up -d          # Start all services"
echo "  docker-compose down           # Stop all services"
echo "  docker-compose exec app bash  # Access app container"
echo "  docker-compose logs -f app    # View app logs"
echo "  docker-compose exec app php artisan migrate  # Run migrations"
