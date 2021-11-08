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
    public class PadresController : ControllerBase
    {
        private readonly SistemaGestionEducativaContext _context;
        public PadresController(SistemaGestionEducativaContext context)
        {
            _context = context;
        }
        // GET: api/<PadresController>
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var listPadres = await _context.Padres.ToListAsync();
                return Ok(listPadres);
            }
            catch (Exception ex)
            {

                return BadRequest(ex.Message);
            }
        }


        // GET api/<PadresController>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<PadresController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<PadresController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<PadresController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
