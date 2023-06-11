namespace Prueba_Técnica_Backend.Data
{
    public class Flight_Details
    {
        public int id_flight { get; set; }
        public int arrived_aiport_id { get; set; }
        public int departure_airport_id { get; set; }
        public string? flight_status { get; set; }
        public decimal max_weight { get; set; }
        public int max_passenger { get; set; }
        public int quantity_passenger { get; set; }

        public static string getStatus(string status)
        {
            return "su estatus es" + status;
        }

    }
}
