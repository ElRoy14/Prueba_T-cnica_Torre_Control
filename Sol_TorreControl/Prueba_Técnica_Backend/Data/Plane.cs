namespace Prueba_Técnica_Backend.Data
{
    public class Plane
    {
        public int id_plane { get; set; }
        public DateTime? arrived_time { get; set; }
        public DateTime? departure_time { get; set; }
        public int arrived_aiport_id { get; set; }
        public string? arrived_airport_name { get; set; }
        public string? departure_airport_name { get; set; }
        public int departure_airport_id { get; set; }
        public string? flight_status { get; set; }
        public decimal max_weight { get; set; }
        public string? plane_weight { get; set; }
        public string? max_passenger { get; set; }
        public string? quantity_passenger { get; set; }

        public static string getWeight(string weight, string max)
        {
            string peso = "";
            if (weight == null)
            {
                peso = "0";
            }else
            {
                peso = Convert.ToString("Peso: " + weight + "Ton/" + max + "Ton");
            }
            return peso;
        }

        public static string getPassengers(string passenger, string max_passenger)
        {
            string pasajeros = "";
            if (passenger == null)
            {
                pasajeros = "0";
            }
            else
            {
                pasajeros = Convert.ToString("Peso: " + passenger + "/" + max_passenger);
            }
            return pasajeros;
        }

    }
}
