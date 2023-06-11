namespace Prueba_Técnica_Backend.Data
{
    public class Plane
    {
        public int id_plane { get; set; }
        public DateTime arrived_time { get; set; }
        public DateTime departure_time { get; set; }
        public int flight_details_id { get; set; }

        public List<dynamic> flight_details;

        /*
         AA = airport A,
         DA = airport B,
         FS = "flying",
         MW = 200,
         MP = 300,
         QP = 150
          
         */
    }
}
