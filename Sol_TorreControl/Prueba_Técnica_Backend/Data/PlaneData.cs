using System.Data.SqlClient;
using System.Globalization;

namespace Prueba_Técnica_Backend.Data
{
    public class PlaneData
    {
        
        private static DateTime parsedData;

        public static List<Plane> vuelos(int vuelo)
        {
            List<Plane> oDatosVuelo = new List<Plane>();
            using (SqlConnection oConexion = new SqlConnection(Conexion.connectionPath))
            {
                SqlCommand cmd = new SqlCommand("sp_show_flight", oConexion);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", vuelo);

                //try{
                oConexion.Open();

                    using(SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                        oDatosVuelo.Add(new Plane()
                            {
                                id_plane = Convert.ToInt32(dr["id_plane"]),
                                arrived_time = Convert.ToDateTime(dr["arrived_time"]),
                                departure_time = Convert.ToDateTime(dr["departure_time"]),
                                arrived_aiport_id = Convert.ToInt32(dr["arrived_airport_id"]),
                                departure_airport_id = Convert.ToInt32(dr["departure_airport_id"]),
                                flight_status = dr["flight_status"].ToString(),
                                max_weight = Convert.ToDecimal(dr["max_weight"]),
                                plane_weight = Plane.getWeight(dr["plane_weight"].ToString(),dr["max_weight"].ToString()),
                                max_passenger = dr["max_passengers"].ToString(),
                                quantity_passenger = Plane.getPassengers(dr["quantity_passengers"].ToString(), dr["max_passengers"].ToString())

                        });
                            
                        }
                        dr.Close();

                    }

                    return oDatosVuelo;
                //}catch(Exception ex)
                //{
                    //return oDatosVuelo;
                //}
            }
        }
    }
}
