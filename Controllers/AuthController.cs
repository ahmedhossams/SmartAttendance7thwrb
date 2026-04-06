
using Microsoft.AspNetCore.Mvc;
using SmartAttendance.Services;
using SmartAttendance.DTOs;

namespace SmartAttendance.Controllers
{
    [ApiController]
    [Route("api/auth")]
    public class AuthController : ControllerBase
    {
        private readonly AuthService _authService;

        public AuthController(AuthService authService)
        {
            _authService = authService;
        }

        [HttpPost("register")]
        public IActionResult Register([FromBody] RegisterDto dto)
        {
            if (dto == null) return BadRequest("Invalid request");
            
            var user = _authService.Register(dto);
            if (user == null) return BadRequest("User already exists");
            
            return CreatedAtAction(nameof(Register), user);
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginDto dto)
        {
            if (dto == null) return BadRequest("Invalid request");
            
            var response = _authService.Login(dto);
            if (response == null) return Unauthorized("Invalid email or password");
            
            return Ok(response);
        }
    }
}

