# RISC-V Development Environment Setup Guide

This guide will help you set up a RISC-V development environment using Docker.

## Prerequisites
- Docker Desktop installed
- Visual Studio Code installed
- Terminal access

## Directory Structure
```
~/riscv-dev/          # Main working directory
  ├── workspace/      # Shared directory between host and container
  ├── Dockerfile      # Docker configuration file
  └── README.md       # Usage guide
```

## Step 1: Prepare Working Directory
```bash
# Create main directory and workspace
mkdir -p ~/riscv-dev/workspace
cd ~/riscv-dev
```

## Step 2: Build Docker Image
```bash
# Build the image (you can change 'riscv-dev-env' to any name you prefer)
docker build -t riscv-dev-env .
```

## Step 3: Create and Run Container
```bash
# Run the container with a shared volume
docker run -it \
  --name riscv-container \
  -v "$HOME/riscv-dev/workspace:/home/fish/workspace" \
  riscv-dev-env \
  bash
```

## Step 4: Daily Usage

### Starting/Stopping Container
After the initial setup, you can:

1. Using Docker Desktop GUI:
   - Go to the Containers tab
   - Find 'riscv-container'
   - Click the play/stop button

2. Using Command Line:
```bash
# Start container
docker start -i riscv-container

# Stop container
docker stop riscv-container

# Check container status
docker ps -a
```

### Accessing Container

#### Method 1: Using VS Code (Recommended)
1. Install VS Code Extensions:
   - Open VS Code
   - Install "Remote Development" extension pack
   - Look for the extension ID: `ms-vscode-remote.vscode-remote-extensionpack`

2. Connect to Container:
   - Click the remote connection icon in the bottom-left corner
   - Select "Attach to Running Container"
   - Choose "riscv-container"
   - OR use command: `code --remote-container riscv-container`

3. Working with Files:
   - All files in `/home/fish/workspace` inside container
   - Are synced with `~/riscv-dev/workspace` on your host machine

#### Method 2: Using Terminal
```bash
# Access running container
docker exec -it riscv-container bash
```

## Common Operations

### Check Resource Usage
```bash
# Show container resource usage
docker stats riscv-container
```

### Container Management
```bash
# List all containers
docker ps -a

# Remove container (if needed)
docker rm riscv-container

# Remove image (if needed)
docker rmi riscv-dev-env
```

### File Access
- All files in `~/riscv-dev/workspace` are automatically synced with the container
- You can edit files either from:
  - Your host machine
  - Inside VS Code when connected to container
  - Inside the container using vim/nano


## Important Notes
- Keep important files in the workspace directory
- Container can be stopped when not in use to save resources
- Use VS Code Remote Development for the best development experience