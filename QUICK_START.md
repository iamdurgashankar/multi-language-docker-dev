# 🚀 Multi-Language Docker Development Environment - Quick Start

This project provides a complete development environment with **5 programming languages** running in Docker containers with database and caching support.

## 🏗️ Architecture

- **Python Flask API** (Port 5000) - User management
- **Node.js Express API** (Port 3000) - Product management  
- **Java Spring Boot API** (Port 8080) - Order management
- **Go Gin API** (Port 8081) - Task management
- **ASP.NET Core API** (Port 5001) - Event management
- **PostgreSQL Database** (Port 5432)
- **Redis Cache** (Port 6379)
- **Nginx Load Balancer** (Port 80)

## 🚀 Quick Start (Windows)

1. **Prerequisites**
   - Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)
   - Start Docker Desktop
   - Clone this repository

2. **Start Development Environment**
   ```powershell
   # Run the PowerShell startup script
   .\start-dev.ps1
   ```

3. **Stop Environment**
   ```powershell
   # Stop all services
   .\stop-dev.ps1
   ```

## 🧪 API Testing

Test each service:

```powershell
# Python API - Users
Invoke-RestMethod -Uri http://localhost:5000/health
Invoke-RestMethod -Uri http://localhost:5000/api/users

# Node.js API - Products  
Invoke-RestMethod -Uri http://localhost:3000/health
Invoke-RestMethod -Uri http://localhost:3000/api/products

# Java API - Orders
Invoke-RestMethod -Uri http://localhost:8080/api/health
Invoke-RestMethod -Uri http://localhost:8080/api/orders

# Go API - Tasks
Invoke-RestMethod -Uri http://localhost:8081/health
Invoke-RestMethod -Uri http://localhost:8081/api/tasks

# .NET API - Events
Invoke-RestMethod -Uri http://localhost:5001/health
Invoke-RestMethod -Uri http://localhost:5001/api/events
```

## 🛠️ Manual Commands

```powershell
# Build and start all services
docker-compose -f docker-compose.dev.yml up --build -d

# View logs
docker-compose -f docker-compose.dev.yml logs -f

# Stop all services
docker-compose -f docker-compose.dev.yml down

# Check service status
docker-compose -f docker-compose.dev.yml ps
```

## 🔧 Development Tips

- **Hot Reload**: All services support hot reload in development mode
- **Database**: PostgreSQL data persists in Docker volumes
- **Cache**: Redis for session and API caching
- **Load Balancer**: Nginx distributes traffic across services
- **Health Checks**: All services have `/health` endpoints

## 📁 Project Structure

```
├── python/          # Flask API (Users)
├── nodejs/          # Express API (Products)  
├── java/            # Spring Boot API (Orders)
├── golang/          # Gin API (Tasks)
├── dotnet/          # ASP.NET Core API (Events)
├── docker/          # Nginx configuration
├── .devcontainer/   # GitHub Codespaces config
├── start-dev.ps1    # Windows startup script
└── stop-dev.ps1     # Windows stop script
```

## 🌐 GitHub Codespaces

This project is configured for GitHub Codespaces. Simply:
1. Open in Codespaces
2. Wait for automatic setup
3. All services will be running and ready!

---

Made with ❤️ for multi-language development