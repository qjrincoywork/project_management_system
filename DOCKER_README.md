# Project Management System - Docker Setup

This Laravel project management system is now containerized with Docker for easy development and deployment.

## Quick Start

### Option 1: Makefile Commands (Recommended)
Use the convenient Makefile commands:

```bash
# Complete setup
make install

# Quick development setup
make dev

# Show all available commands
make help
```

### Option 2: Automated Setup Scripts
Run the setup script for your platform:

**Windows:**
```bash
docker-dev.bat
```

**Linux/macOS:**
```bash
./docker-dev.sh
```

### Option 2: Manual Setup

1. **Create environment file:**
   ```bash
   cp .env.example .env
   ```

2. **Build and start containers:**
   ```bash
   docker-compose up -d --build
   ```

3. **Install dependencies:**
   ```bash
   docker-compose exec app composer install
   docker-compose exec app npm install
   ```

4. **Generate application key:**
   ```bash
   docker-compose exec app php artisan key:generate
   ```

5. **Run migrations:**
   ```bash
   docker-compose exec app php artisan migrate
   ```

6. **Build assets:**
   ```bash
   docker-compose exec app npm run build
   ```

## Services

- **Application**: http://localhost:8080
- **MailHog (Email testing)**: http://localhost:8025
- **Database**: localhost:3306
- **Redis**: localhost:6379

## Useful Commands

### Makefile Commands (Recommended)
```bash
# Setup and Development
make install          # Complete development environment setup
make dev             # Quick development setup
make help            # Show all available commands

# Container Management
make up              # Start all services
make down            # Stop all services
make restart         # Restart all services
make build           # Build and start containers
make status          # Show status of all services

# Development
make shell           # Access app container shell
make logs            # View application logs
make logs-all        # View all service logs

# Laravel Commands
make migrate         # Run database migrations
make migrate-fresh   # Fresh migration with seeding
make seed            # Run database seeders
make key             # Generate application key
make cache-clear     # Clear application cache

# Queue Management
make queue-work      # Start queue worker
make queue-failed    # View failed jobs
make queue-retry     # Retry failed jobs

# Testing
make test            # Run PHPUnit tests
make test-coverage   # Run tests with coverage

# Asset Management
make npm-install     # Install NPM dependencies
make npm-dev         # Build assets for development
make npm-build       # Build assets for production
make npm-watch       # Watch for asset changes

# Database
make db-reset        # Reset database (drop, migrate, seed)
make db-backup       # Create database backup

# Maintenance
make clean           # Clean up containers and volumes
make clean-all       # Clean up everything including images
```

### Direct Docker Compose Commands
```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs -f app

# Access app container
docker-compose exec app bash
```

### Laravel Commands
```bash
# Run migrations
docker-compose exec app php artisan migrate

# Run seeders
docker-compose exec app php artisan db:seed

# Clear cache
docker-compose exec app php artisan cache:clear

# Start queue worker
docker-compose exec app php artisan queue:work

# Run tests
docker-compose exec app php artisan test
```

### Asset Management
```bash
# Install NPM dependencies
docker-compose exec app npm install

# Build assets for production
docker-compose exec app npm run build

# Watch for changes (development)
docker-compose exec app npm run dev
```

## Troubleshooting

### Fix the Original Composer Issue
The original error was caused by missing Composer dependencies. This is now fixed with Docker, but if you want to run locally:

1. **Install Composer dependencies:**
   ```bash
   composer install
   ```

2. **Generate application key:**
   ```bash
   php artisan key:generate
   ```

3. **Run the development server:**
   ```bash
   composer run dev
   ```

### Common Docker Issues

1. **Port already in use:**
   - Change ports in `docker-compose.yml`
   - Or stop conflicting services

2. **Permission issues:**
   ```bash
   docker-compose exec app chown -R www-data:www-data /var/www/html
   ```

3. **Database connection issues:**
   - Ensure database container is running
   - Check `.env` file configuration

## Development Workflow

### Using Makefile (Recommended)
1. **Complete setup:**
   ```bash
   make install
   ```

2. **Start development:**
   ```bash
   make dev
   ```

3. **Make your changes** in the code

4. **View changes** at http://localhost:8080

5. **Common development tasks:**
   ```bash
   make logs          # View logs
   make shell         # Access container
   make migrate       # Run migrations
   make test          # Run tests
   ```

6. **Stop when done:**
   ```bash
   make down
   ```

### Using Docker Compose Directly
1. **Start development environment:**
   ```bash
   docker-compose up -d
   ```

2. **Make your changes** in the code

3. **View changes** at http://localhost:8080

4. **Stop when done:**
   ```bash
   docker-compose down
   ```

## Production Deployment

For production deployment, modify the Dockerfile to:
- Use `composer install --no-dev --optimize-autoloader`
- Use `npm run build` instead of `npm run dev`
- Set appropriate environment variables
- Use a production web server configuration

## File Structure

```
project_management_system/
├── docker/
│   ├── nginx/
│   │   └── default.conf
│   ├── php/
│   │   └── local.ini
│   └── supervisord.conf
├── Dockerfile
├── docker-compose.yml
├── Makefile
├── docker-dev.sh
├── docker-dev.bat
└── DOCKER_README.md
```
