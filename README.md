# SmartAttendance ULTIMATE

A comprehensive ASP.NET Core Web API for managing student attendance, courses, and academic administration.

## 🚀 Features

- **Student Management**: Register and manage student profiles
- **Course Management**: Create and manage courses with instructors
- **Attendance Tracking**: Record and monitor student attendance
- **Authentication & Authorization**: JWT-based secure authentication
- **Instructor Management**: Manage instructor profiles and assignments
- **Classroom Management**: Track classroom resources and assignments
- **Assignment Management**: Create and manage course assignments
- **RESTful API**: Complete REST API with Swagger documentation

## 🛠️ Technology Stack

This project leverages a modern, robust technology stack designed for scalability, security, and maintainability:

### Core Framework & Runtime
- **ASP.NET Core 6.0**: Cross-platform, high-performance framework for building modern web applications and APIs
- **.NET 6.0**: Runtime environment providing the execution context and standard libraries
- **C# 10.0**: Modern programming language with advanced features like nullable reference types and pattern matching

### Database & Data Access
- **Entity Framework Core 6.0**: Modern object-relational mapper (ORM) for .NET, providing LINQ queries and change tracking
- **SQL Server LocalDB**: Lightweight version of SQL Server Express for development and testing
- **Microsoft.EntityFrameworkCore.SqlServer**: SQL Server provider for EF Core
- **Microsoft.EntityFrameworkCore.Tools**: Command-line tools for EF Core migrations and database operations

### Authentication & Security
- **JWT Bearer Authentication**: JSON Web Tokens for stateless authentication
- **Microsoft.AspNetCore.Authentication.JwtBearer**: ASP.NET Core middleware for JWT token validation
- **BCrypt.Net-Next**: Secure password hashing algorithm for storing user credentials
- **Microsoft.IdentityModel.Tokens**: Token validation and cryptographic operations

### API Documentation & Development Tools
- **Swashbuckle.AspNetCore**: Swagger/OpenAPI implementation for ASP.NET Core
- **Swagger UI**: Interactive API documentation and testing interface
- **Microsoft.OpenApi.Models**: OpenAPI specification models and schemas

### Development & Build Tools
- **Microsoft.EntityFrameworkCore.InMemory**: In-memory database provider for testing
- **Dependency Injection**: Built-in ASP.NET Core DI container for service management
- **MVC Pattern**: Model-View-Controller architecture for API organization

## 🔒 HTTP-Only Cookies: Industry Standard for Authentication Security

HTTP-only cookies are widely adopted as an industry standard for authentication security due to several critical security advantages:

### Protection Against XSS Attacks
HTTP-only cookies cannot be accessed via JavaScript, preventing malicious scripts from stealing authentication tokens. This is crucial because Cross-Site Scripting (XSS) attacks, where attackers inject malicious scripts into web pages, are one of the most common web vulnerabilities.

### Automatic Transmission
HTTP-only cookies are automatically included in HTTP requests to the server, eliminating the need for manual token management in client-side code. This reduces the risk of accidental token exposure in browser storage or application code.

### Secure Storage
Unlike localStorage or sessionStorage (which are accessible via JavaScript), HTTP-only cookies provide a secure storage mechanism that browsers protect from client-side access. This prevents tokens from being compromised through browser extensions or malicious scripts.

### CSRF Protection Integration
When combined with CSRF tokens, HTTP-only cookies provide comprehensive protection against both XSS and Cross-Site Request Forgery (CSRF) attacks, creating a defense-in-depth security strategy.

### Industry Adoption
Major platforms like Google, Facebook, and enterprise applications universally use HTTP-only cookies for session management because they provide the strongest protection against client-side attacks while maintaining usability.

### Implementation Best Practices
- Always set the `HttpOnly` flag to `true` for authentication cookies
- Use the `Secure` flag in production to ensure HTTPS-only transmission
- Implement proper `SameSite` attributes to prevent CSRF attacks
- Set appropriate expiration times and implement secure token refresh mechanisms

## 📋 Prerequisites

Before running this project, make sure you have the following installed:

- [.NET 6.0 SDK](https://dotnet.microsoft.com/download/dotnet/6.0)
- [SQL Server LocalDB](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/sql-server-express-localdb) (automatically installed with Visual Studio)
- [Visual Studio 2022](https://visualstudio.microsoft.com/) or [VS Code](https://code.visualstudio.com/) with C# extension

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd SmartAttendanceULTIMATE
```

### 2. Restore Dependencies

```bash
dotnet restore
```

### 3. Database Setup

The application uses SQL Server LocalDB and Entity Framework Core. The database will be automatically created when you first run the application.

**Connection String** (configured in `appsettings.json`):
```
Server=(localdb)\\mssqllocaldb;Database=SmartAttendanceDB;Trusted_Connection=True;MultipleActiveResultSets=true
```

### 4. Run the Application

```bash
dotnet run
```

The application will start on:
- **HTTP**: http://localhost:5000
- **HTTPS**: https://localhost:5001

### 5. Access the API

Once the application is running, you can:

- **Swagger UI**: Visit https://localhost:5001/swagger to explore and test the API
- **API Documentation**: Interactive API documentation with try-it functionality

## 📚 API Endpoints

### Authentication
- `POST /api/Auth/login` - User login
- `POST /api/Auth/register` - User registration

### Students
- `GET /api/Student` - Get all students
- `GET /api/Student/{id}` - Get student by ID
- `POST /api/Student` - Create new student
- `PUT /api/Student/{id}` - Update student
- `DELETE /api/Student/{id}` - Delete student

### Courses
- `GET /api/Course` - Get all courses
- `GET /api/Course/{id}` - Get course by ID
- `POST /api/Course` - Create new course
- `PUT /api/Course/{id}` - Update course
- `DELETE /api/Course/{id}` - Delete course

### Attendance
- `GET /api/Attendance` - Get all attendance records
- `GET /api/Attendance/{id}` - Get attendance by ID
- `POST /api/Attendance` - Record attendance
- `PUT /api/Attendance/{id}` - Update attendance
- `DELETE /api/Attendance/{id}` - Delete attendance

### Instructors
- `GET /api/Instructor` - Get all instructors
- `GET /api/Instructor/{id}` - Get instructor by ID
- `POST /api/Instructor` - Create new instructor
- `PUT /api/Instructor/{id}` - Update instructor
- `DELETE /api/Instructor/{id}` - Delete instructor

### Classrooms
- `GET /api/Classroom` - Get all classrooms
- `GET /api/Classroom/{id}` - Get classroom by ID
- `POST /api/Classroom` - Create new classroom
- `PUT /api/Classroom/{id}` - Update classroom
- `DELETE /api/Classroom/{id}` - Delete classroom

### Assignments
- `GET /api/Assignment` - Get all assignments
- `GET /api/Assignment/{id}` - Get assignment by ID
- `POST /api/Assignment` - Create new assignment
- `PUT /api/Assignment/{id}` - Update assignment
- `DELETE /api/Assignment/{id}` - Delete assignment

## 🔐 Authentication

The API uses JWT (JSON Web Tokens) for authentication. Include the JWT token in the Authorization header:

```
Authorization: Bearer <your-jwt-token>
```

### User Roles
- **Student**: Can view their own attendance and course information
- **Instructor**: Can manage courses, attendance, and assignments
- **Admin**: Full system access

## 🗄️ Database Schema

The application uses the following main entities:

- **Users**: Base user accounts with authentication
- **Students**: Student profiles linked to users
- **Instructors**: Instructor profiles linked to users
- **Courses**: Course information with instructor assignments
- **Enrollments**: Many-to-many relationship between students and courses
- **Attendances**: Attendance records for students in courses
- **Classrooms**: Physical classroom information
- **Assignments**: Course assignments with due dates

## 🧪 Testing the API

A PowerShell test script is included (`test-api.ps1`) to help you test the API endpoints. You can also use the Swagger UI for interactive testing.

### Example API Call

```bash
# Register a new user
curl -X POST "https://localhost:5001/api/Auth/register" \
     -H "Content-Type: application/json" \
     -d '{
       "name": "John Doe",
       "email": "john@example.com",
       "password": "password123",
       "role": "Student"
     }'
```

## 🔧 Development

### Project Structure

```
SmartAttendanceULTIMATE/
├── Controllers/          # API controllers
├── Models/              # Entity models
├── DTOs/                # Data transfer objects
├── Services/            # Business logic services
├── Data/                # Database context and configurations
├── Migrations/          # EF Core database migrations
├── appsettings.json     # Application configuration
├── Program.cs           # Application entry point
└── Program.csproj       # Project file
```

### Building for Production

```bash
dotnet publish -c Release -o ./publish
```

### Running Tests

```bash
dotnet test
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Troubleshooting

### Database Connection Issues
- Ensure SQL Server LocalDB is installed and running
- Check that the connection string in `appsettings.json` is correct
- Verify that the database file has proper permissions

### Port Already in Use
- Change the ports in `Program.cs` or `launchSettings.json`
- Kill any processes using ports 5000/5001

### Migration Issues
- Delete the `Migrations` folder and recreate migrations if needed
- Ensure EF Core tools are installed: `dotnet tool install --global dotnet-ef`

## 📞 Support

For support and questions:
- Create an issue in the repository
- Check the Swagger documentation for API details
- Review the code comments for implementation details

---

**Happy Coding! 🎓**