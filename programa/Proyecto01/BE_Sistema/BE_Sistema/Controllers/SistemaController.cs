using BE_Sistema.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace BE_Sistema.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SistemaController : ControllerBase
    {
        private readonly SistemaGestionEducativaContext _context;
        public SistemaController(SistemaGestionEducativaContext context)
        {
            _context = context;
        }

        // GET: api/<SistemaController>
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var listUsuarios = await _context.Usuarios.ToListAsync();
                return Ok(listUsuarios);
            }
            catch (Exception ex)
            {

                return BadRequest(ex.Message);
            }
        }

        // GET api/<SistemaController>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<SistemaController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<SistemaController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<SistemaController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
