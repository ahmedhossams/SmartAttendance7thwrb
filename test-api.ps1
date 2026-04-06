#!/usr/bin/env pwsh

# Color output functions
function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Error-Custom {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ $Message" -ForegroundColor Cyan
}

$baseUrl = "http://localhost:5000/api"

Write-Info "=== API Endpoint Testing ==="
Write-Info ""

# Test 1: Register a user
Write-Info "Test 1: Register a user (Student)"
try {
    $registerBody = @{
        Name = "John Doe"
        Email = "john@example.com"
        Password = "password123"
        Role = "Student"
    } | ConvertTo-Json
    
    $response = Invoke-WebRequest -Uri "$baseUrl/auth/register" -Method Post -ContentType "application/json" -Body $registerBody -UseBasicParsing -ErrorAction Stop
    $user = $response.Content | ConvertFrom-Json
    Write-Success "User registered successfully: $($user.name)"
} catch {
    Write-Error-Custom "Failed to register user: $($_.Exception.Message)"
}

Write-Info ""

# Test 2: Login
Write-Info "Test 2: Login with registered credentials"
try {
    $loginBody = @{
        Email = "john@example.com"
        Password = "password123"
    } | ConvertTo-Json
    
    $response = Invoke-WebRequest -Uri "$baseUrl/auth/login" -Method Post -ContentType "application/json" -Body $loginBody -UseBasicParsing -ErrorAction Stop
    $loginResponse = $response.Content | ConvertFrom-Json
    $token = $loginResponse.token
    Write-Success "Login successful. Token: $($token.Substring(0, 20))..."
    
    $authHeaders = @{
        "Authorization" = "Bearer $token"
    }
} catch {
    Write-Error-Custom "Failed to login: $($_.Exception.Message)"
    exit
}

Write-Info ""

# Test 3: Register Instructor
Write-Info "Test 3: Register an instructor"
try {
    $instructorBody = @{
        Name = "Dr. Smith"
        Email = "smith@example.com"
        Password = "instructor123"
        Role = "Instructor"
    } | ConvertTo-Json
    
    $response = Invoke-WebRequest -Uri "$baseUrl/auth/register" -Method Post -ContentType "application/json" -Body $instructorBody -UseBasicParsing -ErrorAction Stop
    $instructor = $response.Content | ConvertFrom-Json
    $instructorId = $instructor.id
    Write-Success "Instructor registered: $($instructor.name) (ID: $instructorId)"
} catch {
    Write-Error-Custom "Failed to register instructor: $($_.Exception.Message)"
}

Write-Info ""

# Test 4: Get all students
Write-Info "Test 4: Get all students (with authorization)"
try {
    $response = Invoke-WebRequest -Uri "$baseUrl/students" -Method Get -Headers $authHeaders -UseBasicParsing -ErrorAction Stop
    $students = $response.Content | ConvertFrom-Json
    Write-Success "Retrieved students: $($students.Count) found"
} catch {
    Write-Error-Custom "Failed to get students: $($_.Exception.Message)"
}

Write-Info ""

# Test 5: Create a course
Write-Info "Test 5: Create a course"
try {
    $courseBody = @{
        Name = "Introduction to Programming"
        InstructorId = $instructorId
    } | ConvertTo-Json
    
    $response = Invoke-WebRequest -Uri "$baseUrl/courses" -Method Post -ContentType "application/json" -Headers $authHeaders -Body $courseBody -UseBasicParsing -ErrorAction Stop
    $course = $response.Content | ConvertFrom-Json
    $courseId = $course.id
    Write-Success "Course created: $($course.name) (ID: $courseId)"
} catch {
    Write-Error-Custom "Failed to create course: $($_.Exception.Message)"
}

Write-Info ""

# Test 6: Create a classroom
Write-Info "Test 6: Create a classroom"
try {
    $classroomBody = @{
        Name = "Room 101"
        Location = "Building A"
        Capacity = 30
        InstructorId = $instructorId
    } | ConvertTo-Json
    
    $response = Invoke-WebRequest -Uri "$baseUrl/classrooms" -Method Post -ContentType "application/json" -Headers $authHeaders -Body $classroomBody -UseBasicParsing -ErrorAction Stop
    $classroom = $response.Content | ConvertFrom-Json
    Write-Success "Classroom created: $($classroom.name) (Location: $($classroom.location))"
} catch {
    Write-Error-Custom "Failed to create classroom: $($_.Exception.Message)"
}

Write-Info ""

# Test 7: Create an assignment
Write-Info "Test 7: Create an assignment"
try {
    $assignmentBody = @{
        CourseId = $courseId
        Title = "Assignment 1"
        Description = "Complete the programming exercises"
        DueDate = (Get-Date).AddDays(7).ToString("yyyy-MM-ddTHH:mm:ss")
    } | ConvertTo-Json
    
    $response = Invoke-WebRequest -Uri "$baseUrl/assignments" -Method Post -ContentType "application/json" -Headers $authHeaders -Body $assignmentBody -UseBasicParsing -ErrorAction Stop
    $assignment = $response.Content | ConvertFrom-Json
    Write-Success "Assignment created: $($assignment.title) (Due: $($assignment.dueDate))"
} catch {
    Write-Error-Custom "Failed to create assignment: $($_.Exception.Message)"
}

Write-Info ""

# Test 8: Get all courses
Write-Info "Test 8: Get all courses"
try {
    $response = Invoke-WebRequest -Uri "$baseUrl/courses" -Method Get -Headers $authHeaders -UseBasicParsing -ErrorAction Stop
    $courses = $response.Content | ConvertFrom-Json
    Write-Success "Retrieved courses: $($courses.Count) found"
    foreach ($c in $courses) {
        Write-Host "  - $($c.name) (Instructor: $($c.instructorName))"
    }
} catch {
    Write-Error-Custom "Failed to get courses: $($_.Exception.Message)"
}

Write-Info ""
Write-Success "=== All tests completed ==="
