# 🚀 Running Multi-Language Docker Environment in GitHub Codespaces

This guide explains how to set up and run the multi-language Docker development environment in GitHub Codespaces.

## 📋 Prerequisites

- GitHub account with Codespaces access
- Basic knowledge of Docker and development containers

## 🏗️ Setting Up in GitHub Codespaces

### Method 1: Use This Repository (Recommended)

1. **Create Codespace directly**:
   - Go to [this repository](https://github.com/iamdurgashankar/multi-language-docker-dev)
   - Click the green "Code" button
   - Select "Codespaces" tab
   - Click "Create codespace on main"

2. **Wait for automatic setup** (2-3 minutes)
3. **Start development**: Run `start-dev` in the terminal

### Method 2: Fork This Repository

1. **Fork this repository** using the "Fork" button
2. **Launch Codespace** from your fork
3. **Customize** as needed for your project

### Method 3: Add to Existing Project

1. **Copy configuration files** to your existing repository:
   ```bash
   # Copy these files to your project root:
   .devcontainer/devcontainer.json
   .devcontainer/post-create.sh
   
   # Copy the entire project structure:
   docker-compose.yml
   docker-compose.dev.yml
   python/
   nodejs/
   java/
   golang/
   dotnet/
   docker/
   ```

2. **Commit and push** the changes
3. **Create Codespace** from your repository

## 🔧 Configuration Details

### Codespace Features

The `.devcontainer/devcontainer.json` configures:

- **Base Image**: Ubuntu with development tools
- **Languages**: Python 3.11, Node.js 18, Java 17, Go 1.21, .NET 8
- **Tools**: Docker, Docker Compose, Git, curl, vim, etc.
- **Extensions**: All necessary VS Code extensions
- **Port Forwarding**: Automatic forwarding for all services

### Port Forwarding

| Service | Port | Description |
|---------|------|-------------|
| Python API | 5000 | Flask development server |
| Node.js API | 3000 | Express development server |
| Java API | 8080 | Spring Boot application |
| Go API | 8090 | Gin web server |
| .NET API | 7000 | ASP.NET Core application |
| PostgreSQL | 5432 | Database server |
| Redis | 6379 | Cache server |
| Nginx | 80 | Load balancer |

## 🚀 Quick Start

### After Codespace Creation

1. **Open terminal** in VS Code
2. **Start all services**:
   ```bash
   start-dev
   ```
3. **Test the setup**:
   ```bash
   test-all
   ```

### Access Your Services

Codespaces provides secure URLs for each service:
- Python API: Click the port 5000 notification or use Ports tab
- Node.js API: Click the port 3000 notification or use Ports tab
- Java API: Click the port 8080 notification or use Ports tab
- Go API: Click the port 8090 notification or use Ports tab
- .NET API: Click the port 7000 notification or use Ports tab

## 🔥 Helpful Commands

The setup script creates these aliases:

```bash
# Start/Stop Services
start-dev     # Start development environment
start-prod    # Start production environment
stop-all      # Stop all services
logs-all      # View all service logs

# Testing
test-python   # Test Python API health
test-nodejs   # Test Node.js API health
test-java     # Test Java API health
test-go       # Test Go API health
test-dotnet   # Test .NET API health
test-all      # Test all APIs

# Docker shortcuts
dc            # docker-compose
dcd           # docker-compose -f docker-compose.dev.yml
```

## 🛠️ Development Features

### Hot Reload

All services support live reloading:
- **Python**: Flask debug mode
- **Node.js**: nodemon for automatic restarts
- **Java**: Spring Boot DevTools
- **Go**: Air for live reloading
- **.NET**: dotnet watch

### VS Code Extensions

Automatically installed:
- Docker support
- Language-specific extensions for all 5 languages
- GitHub Copilot (if available)
- Development tools and debuggers

### Database & Cache

- **PostgreSQL**: Available at `postgres:5432`
- **Redis**: Available at `redis:6379`
- Both services are accessible from all APIs

## 🔍 Testing Your Setup

### Quick Health Check
```bash
# Test all services at once
test-all

# Or test individually
curl $CODESPACE_NAME-5000.githubpreview.dev/health
curl $CODESPACE_NAME-3000.githubpreview.dev/health
curl $CODESPACE_NAME-8080.githubpreview.dev/health
curl $CODESPACE_NAME-8090.githubpreview.dev/health
curl $CODESPACE_NAME-7000.githubpreview.dev/health
```

### API Examples
```bash
# Get users from Python API
curl $CODESPACE_NAME-5000.githubpreview.dev/api/users

# Get products from Node.js API
curl $CODESPACE_NAME-3000.githubpreview.dev/api/products

# Test cache functionality
curl -X POST $CODESPACE_NAME-5000.githubpreview.dev/api/cache/test/hello
curl $CODESPACE_NAME-3000.githubpreview.dev/api/cache/test
```

## 🚀 Benefits of This Setup

1. **Zero Configuration**: Everything works immediately
2. **Consistent Environment**: Same setup for all developers
3. **Powerful Hardware**: GitHub's cloud infrastructure
4. **Automatic HTTPS**: Secure public URLs for testing
5. **Full IDE**: Complete VS Code experience in browser
6. **Cost Effective**: Pay only for usage time

## 🔧 Customization

### Adding New Services

1. Create new service directory
2. Add Dockerfile and Dockerfile.dev
3. Update docker-compose.yml files
4. Update .devcontainer/devcontainer.json for port forwarding
5. Commit and rebuild Codespace

### Environment Variables

Create `.env` file in the workspace root:
```env
# Database
DB_HOST=postgres
DB_NAME=multiapp
DB_USER=dev
DB_PASSWORD=your-secure-password

# Redis
REDIS_HOST=redis
REDIS_PORT=6379

# Application settings
NODE_ENV=development
FLASK_ENV=development
ASPNETCORE_ENVIRONMENT=Development
```

## 🐛 Troubleshooting

### Common Issues

#### Services not starting
```bash
# Check Docker status
docker --version
sudo service docker restart

# Rebuild containers
docker-compose down
docker-compose -f docker-compose.dev.yml up --build
```

#### Port access issues
```bash
# Check forwarded ports in VS Code "Ports" tab
# Make sure ports are set to "Public" visibility
```

#### Permission errors
```bash
# Fix file permissions
sudo chown -R vscode:vscode /workspace
```

## 📚 Next Steps

1. **Start building** your applications
2. **Share URLs** with your team for testing
3. **Deploy to production** using the production Docker configs
4. **Set up CI/CD** with GitHub Actions

---

**Happy coding in the cloud! ☁️🚀**

For issues or questions, please create an issue in the repository.