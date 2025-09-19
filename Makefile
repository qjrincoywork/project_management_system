# Project Management System - Makefile
# This Makefile provides convenient commands for development

.PHONY: help install up down build logs shell migrate seed test clean restart status

# Default target
help: ## Show this help message
	@echo "Project Management System - Available Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Quick Start: make install"

# Development setup
install: ## Complete development environment setup
	@chmod +x docker-dev.sh
	@./docker-dev.sh

# Container management
up: ## Start all services
	@echo "🔨 Starting all services..."
	@docker-compose up -d

down: ## Stop all services
	@echo "🛑 Stopping all services..."
	@docker-compose down

restart: ## Restart all services
	@echo "🔄 Restarting all services..."
	@docker-compose restart

build: ## Build and start containers
	@echo "🔨 Building and starting containers..."
	@docker-compose up -d --build

# Development commands
shell: ## Access the app container shell
	@echo "🐚 Accessing app container shell..."
	@docker-compose exec app bash

logs: ## View application logs
	@echo "📋 Viewing application logs..."
	@docker-compose logs -f app

logs-all: ## View all service logs
	@echo "📋 Viewing all service logs..."
	@docker-compose logs -f

# Laravel commands
migrate: ## Run database migrations
	@echo "🗄️ Running database migrations..."
	@docker-compose exec app php artisan migrate

migrate-fresh: ## Fresh migration with seeding
	@echo "🗄️ Running fresh migrations with seeding..."
	@docker-compose exec app php artisan migrate:fresh --seed

seed: ## Run database seeders
	@echo "🌱 Running database seeders..."
	@docker-compose exec app php artisan db:seed

key: ## Generate application key
	@echo "🔑 Generating application key..."
	@docker-compose exec app php artisan key:generate

cache-clear: ## Clear application cache
	@echo "🧹 Clearing application cache..."
	@docker-compose exec app php artisan cache:clear
	@docker-compose exec app php artisan config:clear
	@docker-compose exec app php artisan route:clear
	@docker-compose exec app php artisan view:clear

# Queue commands
queue-work: ## Start queue worker
	@echo "⚡ Starting queue worker..."
	@docker-compose exec app php artisan queue:work

queue-failed: ## View failed jobs
	@echo "❌ Viewing failed jobs..."
	@docker-compose exec app php artisan queue:failed

queue-retry: ## Retry failed jobs
	@echo "🔄 Retrying failed jobs..."
	@docker-compose exec app php artisan queue:retry all

# Testing
test: ## Run PHPUnit tests
	@echo "🧪 Running tests..."
	@docker-compose exec app php artisan test

test-coverage: ## Run tests with coverage
	@echo "🧪 Running tests with coverage..."
	@docker-compose exec app php artisan test --coverage

# Asset management
npm-install: ## Install NPM dependencies
	@echo "📦 Installing NPM dependencies..."
	@docker-compose exec app npm install

npm-dev: ## Build assets for development
	@echo "🎨 Building assets for development..."
	@docker-compose exec app npm run dev

npm-build: ## Build assets for production
	@echo "🎨 Building assets for production..."
	@docker-compose exec app npm run build

npm-watch: ## Watch for asset changes
	@echo "👀 Watching for asset changes..."
	@docker-compose exec app npm run watch

# Database commands
db-reset: ## Reset database (drop, migrate, seed)
	@echo "🗄️ Resetting database..."
	@docker-compose exec app php artisan migrate:fresh --seed

db-backup: ## Create database backup
	@echo "💾 Creating database backup..."
	@docker-compose exec db mysqldump -u laravel -plaravel_password project_management > backup_$(shell date +%Y%m%d_%H%M%S).sql

# Maintenance
clean: ## Clean up containers and volumes
	@echo "🧹 Cleaning up containers and volumes..."
	@docker-compose down -v
	@docker system prune -f

clean-all: ## Clean up everything including images
	@echo "🧹 Cleaning up everything..."
	@docker-compose down -v --rmi all
	@docker system prune -af

# Status and info
status: ## Show status of all services
	@echo "📊 Service Status:"
	@docker-compose ps

info: ## Show service information
	@echo "ℹ️  Service Information:"
	@echo "🌐 Application: http://localhost:8080"
	@echo "📧 MailHog: http://localhost:8025"
	@echo "🗄️ Database: localhost:3306"
	@echo "🔴 Redis: localhost:6379"
	@echo ""
	@echo "📝 Useful Commands:"
	@echo "  make up          # Start all services"
	@echo "  make down        # Stop all services"
	@echo "  make shell       # Access app container"
	@echo "  make logs        # View app logs"
	@echo "  make migrate     # Run migrations"
	@echo "  make test        # Run tests"

# Quick development workflow
dev: up npm-install migrate key cache-clear ## Quick development setup
	@echo "✅ Development environment ready!"
	@echo "🌐 Application: http://localhost:8080"

# Production build
prod: build npm-build migrate key cache-clear ## Production build
	@echo "✅ Production build ready!"

# Default target when no argument is provided
.DEFAULT_GOAL := help
