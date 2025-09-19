@echo off
echo 🚀 Setting up Project Management System Development Environment

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not running. Please start Docker and try again.
    pause
    exit /b 1
)

echo ✅ Docker is running

REM Create .env file if it doesn't exist
if not exist .env (
    echo 📝 Creating .env file...
    echo APP_NAME="Project Management System" > .env
    echo APP_ENV=local >> .env
    echo APP_KEY= >> .env
    echo APP_DEBUG=true >> .env
    echo APP_URL=http://localhost:8080 >> .env
    echo. >> .env
    echo LOG_CHANNEL=stack >> .env
    echo LOG_LEVEL=debug >> .env
    echo. >> .env
    echo DB_CONNECTION=mysql >> .env
    echo DB_HOST=db >> .env
    echo DB_PORT=3306 >> .env
    echo DB_DATABASE=project_management >> .env
    echo DB_USERNAME=laravel >> .env
    echo DB_PASSWORD=laravel_password >> .env
    echo. >> .env
    echo CACHE_DRIVER=file >> .env
    echo QUEUE_CONNECTION=sync >> .env
    echo SESSION_DRIVER=file >> .env
    echo. >> .env
    echo MAIL_MAILER=log >> .env
    echo MAIL_FROM_ADDRESS="hello@example.com" >> .env
    echo MAIL_FROM_NAME="${APP_NAME}" >> .env
    echo ✅ .env file created
) else (
    echo ✅ .env file already exists
)

REM Build and start containers
echo 🔨 Building and starting containers...
docker-compose up -d --build

REM Wait for database to be ready
echo ⏳ Waiting for database to be ready...
timeout /t 15 /nobreak >nul

REM Install Composer dependencies
echo 📦 Installing Composer dependencies...
docker-compose exec app composer install

REM Generate application key
echo 🔑 Generating application key...
docker-compose exec app php artisan key:generate

REM Run migrations
echo 🗄️ Running database migrations...
docker-compose exec app php artisan migrate

REM Install NPM dependencies
echo 📦 Installing NPM dependencies...
docker-compose exec app npm install

REM Build assets
echo 🎨 Building assets...
docker-compose exec app npm run build

echo ✅ Development environment is ready!
echo.
echo 🌐 Application: http://localhost:8080
echo 🗄️ Database: localhost:3306
echo.
echo 📝 Useful commands:
echo   docker-compose up -d          # Start all services
echo   docker-compose down           # Stop all services
echo   docker-compose exec app bash  # Access app container
echo   docker-compose logs -f app    # View app logs
echo   docker-compose exec app php artisan migrate  # Run migrations

pause
