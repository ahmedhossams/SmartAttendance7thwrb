
using SmartAttendance.Data;
using SmartAttendance.Models;
using SmartAttendance.DTOs;
using Microsoft.EntityFrameworkCore;

namespace SmartAttendance.Services
{
    public class StudentService
    {
        private readonly AppDbContext _context;

        public StudentService(AppDbContext context)
        {
            _context = context;
        }

        public List<StudentDto> GetAll()
        {
            return _context.Students
                .Include(s => s.User)
                .AsNoTracking()
                .Select(s => new StudentDto
                {
                    Id = s.Id,
                    Name = s.User.Name,
                    Email = s.User.Email
                })
                .ToList();
        }

        public StudentDetailDto? GetById(int id)
        {
            var student = _context.Students
                .Include(s => s.User)
                .AsNoTracking()
                .FirstOrDefault(s => s.Id == id);

            if (student == null) return null;

            var enrollments = _context.Enrollments
                .Include(e => e.Course)
                .Where(e => e.StudentId == id)
                .Select(e => e.Course.Name)
                .ToList();

            return new StudentDetailDto
            {
                Id = student.Id,
                Name = student.User.Name,
                Email = student.User.Email,
                EnrolledCourses = enrollments
            };
        }

        public bool EnrollInCourse(int studentId, int courseId)
        {
            var student = _context.Students.Find(studentId);
            var course = _context.Courses.Find(courseId);

            if (student == null || course == null) return false;

            var existingEnrollment = _context.Enrollments
                .FirstOrDefault(e => e.StudentId == studentId && e.CourseId == courseId);

            if (existingEnrollment != null) return false;

            var enrollment = new Enrollment { StudentId = studentId, CourseId = courseId };
            _context.Enrollments.Add(enrollment);
            _context.SaveChanges();
            return true;
        }

        public List<EnrollmentDto>? GetStudentEnrollments(int studentId)
        {
            var student = _context.Students.Find(studentId);
            if (student == null) return null;

            return _context.Enrollments
                .Include(e => e.Course)
                .Include(e => e.Course)
                .AsNoTracking()
                .Where(e => e.StudentId == studentId)
                .Select(e => new EnrollmentDto
                {
                    StudentId = e.StudentId,
                    StudentName = _context.Students.Include(s => s.User).FirstOrDefault(s => s.Id == e.StudentId).User.Name,
                    CourseId = e.CourseId,
                    CourseName = e.Course.Name
                })
                .ToList();
        }
    }
}
