
namespace SmartAttendance.Models
{
    public class Attendance
    {
        public int Id { get; set; }
        public int StudentId { get; set; }
        public int CourseId { get; set; }
        public bool IsPresent { get; set; }
        public DateTime Date { get; set; }
        public Student Student { get; set; }
        public Course Course { get; set; }
    }
}
