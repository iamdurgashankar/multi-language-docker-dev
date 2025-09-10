# Multi-Language Docker Development Environment

A comprehensive Docker development environment supporting Python, Node.js, Java, Go, and .NET with development containers, Docker Compose orchestration, and best practices.

## 🚀 Quick Start

### Prerequisites
- [Docker](https://www.docker.com/get-started) and Docker Compose
- [VS Code](https://code.visualstudio.com/) with [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Option 1: GitHub Codespaces (Recommended)
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/iamdurgashankar/multi-language-docker-dev)

1. Click "Use this template" or fork this repository
2. Click the green "Code" button → "Codespaces" → "Create codespace"
3. Wait for the environment to set up automatically
4. Run `start-dev` in the terminal to launch all services

📖 **Detailed Codespaces Setup**: See [CODESPACES_SETUP.md](./CODESPACES_SETUP.md)

### Option 2: Local Development with Dev Containers
```bash
# Clone the repository
git clone https://github.com/iamdurgashankar/multi-language-docker-dev.git
cd multi-language-docker-dev

# Open in VS Code and select "Reopen in Container"
# Or use command palette: "Dev Containers: Reopen in Container"
```

### Option 3: Local Development with Docker Compose
```bash
# Start all services in development mode
docker-compose -f docker-compose.dev.yml up --build

# Or start production services
docker-compose up --build
```

## 📁 Project Structure

```
multi-language-docker-dev/
├── .devcontainer/           # VS Code Dev Container configuration
├── .github/                 # GitHub workflows and instructions
├── docker/                  # Docker configuration files
│   └── nginx.conf          # Nginx load balancer config
├── python/                  # Python Flask API
│   ├── Dockerfile          # Production Dockerfile
│   ├── Dockerfile.dev      # Development Dockerfile
│   ├── app.py             # Flask application
│   └── requirements.txt   # Python dependencies
├── nodejs/                  # Node.js Express API
│   ├── Dockerfile          # Production Dockerfile
│   ├── Dockerfile.dev      # Development Dockerfile
│   ├── app.js             # Express application
│   └── package.json       # Node.js dependencies
├── java/                    # Java Spring Boot API
│   ├── Dockerfile          # Production Dockerfile
│   ├── Dockerfile.dev      # Development Dockerfile
│   ├── pom.xml            # Maven configuration
│   └── src/               # Java source code
├── golang/                  # Go Gin API
│   ├── Dockerfile          # Production Dockerfile
│   ├── Dockerfile.dev      # Development Dockerfile
│   ├── go.mod             # Go modules
│   ├── main.go            # Go application
│   └── .air.toml          # Air hot reload config
├── dotnet/                  # .NET 8 ASP.NET Core API
│   ├── Dockerfile          # Production Dockerfile
│   ├── Dockerfile.dev      # Development Dockerfile
│   ├── Program.cs          # .NET application
│   ├── DotnetDockerApi.csproj
│   └── Controllers/        # API controllers
├── docker-compose.yml       # Production compose file
├── docker-compose.dev.yml   # Development compose file
└── README.md               # This file
```

## 🛠️ Services Overview

### API Services
| Service | Language | Framework | Port | Endpoint |
|---------|----------|-----------|------|-----------|
| Python API | Python 3.11 | Flask | 5000 | http://localhost:5000 |
| Node.js API | JavaScript | Express | 3000 | http://localhost:3000 |
| Java API | Java 17 | Spring Boot | 8080 | http://localhost:8080 |
| Go API | Go 1.21 | Gin | 8090 | http://localhost:8090 |
| .NET API | C# | ASP.NET Core 8 | 7000 | http://localhost:7000 |

### Infrastructure Services
- **PostgreSQL**: Database server on port 5432
- **Redis**: Cache server on port 6379
- **Nginx**: Load balancer and reverse proxy on port 80

## 🔧 Development Commands

### Using Docker Compose

#### Development Mode (with hot reload)
```bash
# Start all services in development mode
docker-compose -f docker-compose.dev.yml up --build

# Start specific service
docker-compose -f docker-compose.dev.yml up python-dev

# View logs
docker-compose -f docker-compose.dev.yml logs -f python-dev

# Stop services
docker-compose -f docker-compose.dev.yml down
```

#### Production Mode
```bash
# Start all services in production mode
docker-compose up --build

# Start with specific services
docker-compose up postgres redis nginx python-api

# Scale services
docker-compose up --scale python-api=3

# Stop and remove everything
docker-compose down -v
```

## 🌐 API Endpoints

### Common Endpoints (All Services)
- `GET /` - Hello message with service info
- `GET /health` - Health check with database and Redis status

### Service-Specific Endpoints

#### Python API (Port 5000)
- `GET /api/users` - Get users list
- `POST /api/users` - Create new user
- `GET /api/cache/{key}` - Get cached value
- `POST /api/cache/{key}/{value}` - Set cached value

#### Node.js API (Port 3000)
- `GET /api/products` - Get products list
- `POST /api/products` - Create new product
- `GET /api/cache/{key}` - Get cached value
- `POST /api/cache/{key}/{value}` - Set cached value

#### Java API (Port 8080)
- `GET /api/orders` - Get orders list
- `POST /api/orders` - Create new order
- `GET /api/cache/{key}` - Get cached value
- `POST /api/cache/{key}/{value}` - Set cached value

#### Go API (Port 8090)
- `GET /api/inventory` - Get inventory list
- `POST /api/inventory` - Create new inventory item
- `GET /api/cache/{key}` - Get cached value
- `POST /api/cache/{key}/{value}` - Set cached value

#### .NET API (Port 7000)
- `GET /api/customers` - Get customers list
- `POST /api/customers` - Create new customer
- `GET /api/cache/{key}` - Get cached value
- `POST /api/cache/{key}/{value}` - Set cached value

### Load Balancer (Nginx - Port 80)
- `GET /api/python/` - Routes to Python API
- `GET /api/nodejs/` - Routes to Node.js API
- `GET /api/java/` - Routes to Java API
- `GET /api/go/` - Routes to Go API
- `GET /api/dotnet/` - Routes to .NET API

## 🔍 Testing the Setup

### Health Checks
```bash
# Check all services are running
curl http://localhost:5000/health  # Python
curl http://localhost:3000/health  # Node.js
curl http://localhost:8080/health  # Java
curl http://localhost:8090/health  # Go
curl http://localhost:7000/health  # .NET

# Test through load balancer
curl http://localhost/api/python/health
curl http://localhost/api/nodejs/health
curl http://localhost/api/java/health
curl http://localhost/api/go/health
curl http://localhost/api/dotnet/health
```

## 🚀 Getting Started in Codespaces

1. **Create Codespace**: Click the green "Code" button → "Codespaces" → "Create codespace"
2. **Wait for Setup**: The environment will automatically configure (2-3 minutes)
3. **Start Services**: Run `start-dev` in the terminal
4. **Access APIs**: Use the forwarded port URLs provided by Codespaces

## 📚 Documentation

- [Detailed Codespaces Setup](./CODESPACES_SETUP.md)
- [Development Container Configuration](./.devcontainer/README.md)
- [CI/CD Pipeline](./.github/workflows/ci-cd.yml)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test in Codespaces or locally
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

---

**Happy Coding! 🎉**

For questions or issues, please create an issue in the repository.