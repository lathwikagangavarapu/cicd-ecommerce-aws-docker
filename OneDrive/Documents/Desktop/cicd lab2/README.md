# Ecommerce Travel Booking Platform

A full-stack travel booking application with Spring Boot backend, React frontend, and MySQL database.

## Architecture

- **Backend**: Spring Boot (Java 21) with Spring Security, JWT authentication
- **Frontend**: React with Vite, served by Tomcat
- **Database**: MySQL 8.0
- **Deployment**: Docker Compose / Kubernetes

## Features

- User registration and authentication
- Flight, car, and hotel booking
- Admin dashboard for managing inventory
- JWT-based security
- Responsive UI

## Quick Start with Docker Compose

### Prerequisites
- Docker and Docker Compose installed
- At least 4GB RAM available

### Deployment

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd ecommerce-platform
   ```

2. **Start the application**
   ```bash
   docker-compose up -d
   ```

3. **Access the application**
   - Frontend: http://localhost:30082
   - Backend API: http://localhost:8080/back1/api/

### Stop the application
```bash
docker-compose down
```

## Kubernetes Deployment

### Prerequisites
- Kubernetes cluster (Docker Desktop, Minikube, etc.)
- Helm installed

### Deployment

1. **Navigate to Helm chart**
   ```bash
   cd ecommerce-chart
   ```

2. **Install the application**
   ```bash
   helm install ecommerce-deploy .
   ```

3. **Access the application**
   - Frontend: http://localhost:30082
   - Backend: http://localhost:30085/back1/api/

### Cleanup
```bash
helm uninstall ecommerce-deploy
```

## API Endpoints

### Authentication
- `POST /api/user/register` - User registration
- `POST /api/user/login` - User login

### Admin Endpoints (Require ADMIN role)
- `GET /api/admin/flight` - Get all flights
- `POST /api/admin/flight` - Add new flight
- `GET /api/admin/car` - Get all cars
- `POST /api/admin/car` - Add new car
- `GET /api/admin/stay` - Get all stays
- `POST /api/admin/stay` - Add new stay

### User Endpoints (Require authentication)
- `GET /api/flight` - Get available flights
- `GET /api/car` - Get available cars
- `GET /api/stay` - Get available stays
- `POST /api/booking` - Create booking
- `GET /api/booking` - Get user bookings

## Development

### Backend
```bash
cd TRAVEL_BOOKING_PLATFORM-main/TravelSathi
mvn spring-boot:run
```

### Frontend
```bash
cd TRAVEL_BOOKING_PLATFORM-main/travelsathi-frontend
npm install
npm run dev
```

## Environment Variables

### Backend
- `SPRING_DATASOURCE_URL` - Database URL
- `SPRING_DATASOURCE_USERNAME` - Database username
- `SPRING_DATASOURCE_PASSWORD` - Database password

### Frontend
- `REACT_APP_BACKEND_URL` - Backend API URL

## Database Schema

The application uses MySQL with the following main tables:
- `user` - User accounts
- `flight` - Flight inventory
- `car` - Car rental inventory
- `stay` - Hotel/accommodation inventory
- `booking` - User bookings

## Security

- JWT token-based authentication
- Password encryption with BCrypt
- CORS configuration for cross-origin requests
- Role-based access control (USER/ADMIN)

## Monitoring

- Health checks configured for all services
- Horizontal Pod Autoscaling in Kubernetes
- Persistent storage for database

## Troubleshooting

### Common Issues

1. **Port conflicts**: Ensure ports 30082, 8080, 3306 are available
2. **Memory issues**: Ensure Docker has enough memory allocated
3. **Database connection**: Wait for MySQL to fully initialize

### Logs

```bash
# Docker Compose logs
docker-compose logs -f

# Kubernetes logs
kubectl logs -l app=backend
kubectl logs -l app=frontend
kubectl logs -l app=mysql
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.