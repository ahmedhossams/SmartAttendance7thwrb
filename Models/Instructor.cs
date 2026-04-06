
namespace SmartAttendance.Models
{
    public class Instructor
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public User User { get; set; }
    }
}
