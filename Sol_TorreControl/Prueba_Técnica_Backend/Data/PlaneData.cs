using System.Data.SqlClient;

namespace Prueba_Técnica_Backend.Data
{
    public class PlaneData
    {

        /*public static bool Register(Plane oPlane, Airport oAirport)
        {
            using (SqlConnection oConexion = new SqlConnection(Conexion.connectionPath))
            {
                SqlCommand cmd = new SqlCommand("sp_register", oConexion);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("");
            }
        }*/

        public static List<Plane> vuelos()
        {
            List<Plane> oDatosVuelo = new List<Plane>();
            using (SqlConnection oConexion = new SqlConnection(Conexion.connectionPath))
            {
                SqlCommand cmd = new SqlCommand("sp_show_flight", oConexion);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                try
                {
                    oConexion.Open();

                    using(SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while(dr.Read())
                        {
                            oDatosVuelo.Add(new Plane()
                            {
                                arrived_time = Convert.ToDateTime(dr["arrived_time"]),
                                departure_time = Convert.ToDateTime(dr["departure_time"]),
                                flight_details_id = Convert.ToInt32(dr["flight_details_id"])
                            });
                        }
                    }
                    return oDatosVuelo;
                }catch(Exception ex)
                {
                    return oDatosVuelo;
                }
            }
        }


    }
}
