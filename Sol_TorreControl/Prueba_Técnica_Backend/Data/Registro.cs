namespace Prueba_Técnica_Backend.Data
{
    public class Registro
    {
        public DateTime arrived_time { get; set; }
        public DateTime departure_time { get; set; }
        public string? arrived_airport_name { get; set; }
        public string? departure_airport_name { get; set; }
        public string? flight_status { get; set; }
        public decimal max_weight { get; set; }
        public int max_passenger { get; set; }
    }
}
