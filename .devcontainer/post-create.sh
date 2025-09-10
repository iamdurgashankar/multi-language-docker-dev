#!/bin/bash

echo "🚀 Setting up Multi-Language Docker Development Environment..."

# Update package lists
sudo apt-get update

# Install additional development tools
sudo apt-get install -y \
    curl \
    wget \
    git \
    vim \
    nano \
    tree \
    htop \
    jq \
    httpie

# Install Docker Compose (latest version)
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Node.js dependencies for each project
echo "📦 Installing Node.js dependencies..."
cd /workspace/nodejs && npm install

# Install Python dependencies
echo "🐍 Installing Python dependencies..."
cd /workspace/python && pip install -r requirements.txt

# Install Go dependencies
echo "🐹 Installing Go dependencies..."
cd /workspace/golang && go mod tidy

# Install Java dependencies (Maven)
echo "☕ Installing Java dependencies..."
cd /workspace/java && mvn dependency:resolve

# Restore .NET dependencies
echo "🔷 Installing .NET dependencies..."
cd /workspace/dotnet && dotnet restore

# Create helpful aliases
echo "🔧 Setting up helpful aliases..."
cat >> /home/vscode/.zshrc << 'EOF'

# Docker aliases
alias dc='docker-compose'
alias dcd='docker-compose -f docker-compose.dev.yml'
alias dcup='docker-compose up --build'
alias dcdown='docker-compose down'
alias dclogs='docker-compose logs -f'

# Development shortcuts
alias start-dev='docker-compose -f docker-compose.dev.yml up --build'
alias start-prod='docker-compose up --build'
alias stop-all='docker-compose down'
alias logs-all='docker-compose logs -f'

# API testing shortcuts
alias test-python='curl http://localhost:5000/health'
alias test-nodejs='curl http://localhost:3000/health'
alias test-java='curl http://localhost:8080/health'
alias test-go='curl http://localhost:8090/health'
alias test-dotnet='curl http://localhost:7000/health'
alias test-all='test-python && test-nodejs && test-java && test-go && test-dotnet'

# Quick navigation
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

echo "🎉 Multi-Language Docker Environment Ready!"
echo "Use 'start-dev' to start development services"
echo "Use 'test-all' to test all API health endpoints"
EOF

# Make scripts executable
chmod +x /workspace/.devcontainer/post-create.sh

# Set proper permissions
sudo chown -R vscode:vscode /workspace

echo "✅ Setup complete! You can now:"
echo "  - Run 'start-dev' to start all development services"
echo "  - Run 'test-all' to test all API endpoints"
echo "  - Use VS Code extensions for each language"
echo "  - Access services on forwarded ports"

# Return to workspace root
cd /workspace