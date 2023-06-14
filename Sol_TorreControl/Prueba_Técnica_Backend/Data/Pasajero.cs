using System.Net.NetworkInformation;

namespace Prueba_Técnica_Backend.Data
{
    public class Pasajero
    {
        public DateTime arr_time { get; set; }
        public DateTime dep_time { get; set; }
        public string? arr_air_name { get; set; }
        public string? dep_air_name { get; set; }
        public  string f_name { get; set; }
        public decimal baggage_weight { get; set; }
        public int flight_code { get; set; }
    }
}
