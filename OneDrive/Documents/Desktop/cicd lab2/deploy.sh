#!/bin/bash

# Ecommerce Platform Deployment Script

set -e

echo "🚀 Starting Ecommerce Platform Deployment"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is running
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        print_error "Docker is not running. Please start Docker first."
        exit 1
    fi
    print_success "Docker is running"
}

# Check if Docker Compose is available
check_docker_compose() {
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed"
        exit 1
    fi
    print_success "Docker Compose is available"
}

# Build and start services
deploy_docker() {
    print_status "Building and starting services with Docker Compose..."

    # Stop any existing containers
    docker-compose down || true

    # Build and start services
    docker-compose up -d --build

    print_success "Services are starting up..."

    # Wait for services to be healthy
    print_status "Waiting for MySQL to be ready..."
    sleep 30

    print_status "Waiting for backend to be ready..."
    sleep 30

    print_status "Checking service health..."

    # Check if services are running
    if docker-compose ps | grep -q "Up"; then
        print_success "All services are running!"
        echo ""
        echo "🌐 Access URLs:"
        echo "   Frontend: http://localhost:30082"
        echo "   Backend API: http://localhost:8080/back1/api/"
        echo "   MySQL: localhost:3306"
        echo ""
        echo "📊 View logs: docker-compose logs -f"
        echo "🛑 Stop services: docker-compose down"
    else
        print_error "Some services failed to start"
        docker-compose logs
        exit 1
    fi
}

# Deploy to Kubernetes
deploy_k8s() {
    print_status "Deploying to Kubernetes..."

    # Check if kubectl is available
    if ! command -v kubectl &> /dev/null; then
        print_error "kubectl is not installed"
        exit 1
    fi

    # Check if helm is available
    if ! command -v helm &> /dev/null; then
        print_error "Helm is not installed"
        exit 1
    fi

    cd ecommerce-chart

    # Install/upgrade the release
    helm upgrade --install ecommerce-deploy .

    print_success "Kubernetes deployment completed!"

    # Wait for pods to be ready
    kubectl wait --for=condition=ready pod -l app=backend --timeout=300s
    kubectl wait --for=condition=ready pod -l app=frontend --timeout=300s

    echo ""
    echo "🌐 Kubernetes Access URLs:"
    echo "   Frontend: http://localhost:30082"
    echo "   Backend: http://localhost:30085/back1/api/"
    echo ""
    echo "📊 View pods: kubectl get pods"
    echo "📊 View logs: kubectl logs -l app=backend"
    echo "🛑 Cleanup: helm uninstall ecommerce-deploy"
}

# Main menu
show_menu() {
    echo "Select deployment method:"
    echo "1) Docker Compose (Local Development)"
    echo "2) Kubernetes (Production)"
    echo "3) Exit"
    read -p "Enter choice (1-3): " choice
}

# Main execution
main() {
    echo "🛍️  Ecommerce Travel Booking Platform"
    echo "====================================="
    echo ""

    check_docker
    check_docker_compose

    show_menu

    case $choice in
        1)
            deploy_docker
            ;;
        2)
            deploy_k8s
            ;;
        3)
            print_status "Goodbye!"
            exit 0
            ;;
        *)
            print_error "Invalid choice"
            exit 1
            ;;
    esac
}

# Run main function
main