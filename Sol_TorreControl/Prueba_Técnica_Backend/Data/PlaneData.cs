using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Reflection.PortableExecutable;

namespace Prueba_Técnica_Backend.Data
{
    public class PlaneData
    {
        #region "Variables"
        public static DateTime departure_time;
        public static string? arr_airport_name;
        public static string? dep_airport_name;
        public static int id_flight;
        #endregion

        public static List<Plane> DatosVuelo(int code)
        {
            List<Plane> oDatosVuelo = new List<Plane>();
            using (SqlConnection oConexion = new SqlConnection(Conexion.connectionPath))
            {
                SqlCommand cmd = new SqlCommand("sp_show_flight", oConexion);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", code);

                try{
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
                                quantity_passenger = Plane.getPassengers(dr["quantity_passengers"].ToString(), dr["max_passengers"].ToString()),
                                arrived_airport_name = dr["arrived_airport_name"].ToString(),
                                departure_airport_name = dr["departure_airport_name"].ToString()

                        });
                            
                        }
                        dr.Close();
                    }
                    return oDatosVuelo;
                }catch(Exception ex)
                {
                    return oDatosVuelo;
                }
            }
        }

        public static bool Registrar(Registro oRegist)
        {
            using (SqlConnection oConexion = new SqlConnection(Conexion.connectionPath))
            {
                SqlCommand cmd = new SqlCommand("sp_register", oConexion);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@arr_time", oRegist.arrived_time);
                cmd.Parameters.AddWithValue("@dep_time", oRegist.departure_time);
                cmd.Parameters.AddWithValue("@arr_air_name", oRegist.arrived_airport_name);
                cmd.Parameters.AddWithValue("@dep_air_name", oRegist.departure_airport_name);
                cmd.Parameters.AddWithValue("@fly_sts", oRegist.flight_status);
                cmd.Parameters.AddWithValue("@max_weight", oRegist.max_weight);
                cmd.Parameters.AddWithValue("@max_pass", oRegist.max_passenger);

                try
                {
                    oConexion.Open();
                    cmd.ExecuteNonQuery();
                    return true;
                }
                catch(Exception ex)
                {
                    return false;
                }
            }
        }
        public static bool Cancelar(int code)
        {
            using (SqlConnection oConexion = new SqlConnection(Conexion.connectionPath))
            {
                SqlCommand cmd = new SqlCommand("sp_cancel", oConexion);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", code);

                try
                {
                    oConexion.Open();
                    cmd.ExecuteNonQuery();
                    return true;
                }
                catch
                {
                    return false;
                }
            }
        }
        public static List<Plane> BuscarVuelos(Pasajero oPasajero)
        {
            List<Plane> oTicket = new List<Plane>();
            using (SqlConnection oConexion = new SqlConnection(Conexion.connectionPath))
            {
                SqlCommand cmd = new SqlCommand("sp_search_flight", oConexion);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@arrived_time", oPasajero.arr_time);
                cmd.Parameters.AddWithValue("@arrived_airport_name", oPasajero.arr_air_name);
                cmd.Parameters.AddWithValue("@departure_airport_name", oPasajero.dep_air_name);

                try
                {
                    oConexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            // Verificar si el campo tiene datos antes de leerlo
                            if (!dr.IsDBNull(0) && dr.HasRows) // Aquí, 0 representa el índice de la columna que deseas leer
                            {
                                departure_time = Convert.ToDateTime(dr["arrived_time"]);
                                arr_airport_name = dr["arrived_airport_name"].ToString();
                                dep_airport_name = dr["departure_airport_name"].ToString();
                                id_flight = Convert.ToInt32(dr["id_plane"]);
                            }
                        }
                        if(!dr.HasRows)
                        {
                            oTicket.Add(new Plane()
                            {
                                id_plane = 0,
                                arrived_time = null,
                                departure_time = null,
                                arrived_aiport_id = 0,
                                departure_airport_id = 0,
                                flight_status = "No Exists",
                                max_weight = 00.00M,
                                plane_weight = "00Ton/00Ton",
                                max_passenger = "00Ton",
                                quantity_passenger = "00/00",
                                arrived_airport_name = "No Airport",
                                departure_airport_name = "No Airport"

                            });
                        }
                    }
                    SqlCommand cmd1 = new SqlCommand("sp_show_flight", oConexion);
                    cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd1.Parameters.AddWithValue("@id", id_flight);

                    using (SqlDataReader dtr = cmd1.ExecuteReader())
                    {
                        while (dtr.Read())
                        {
                            if (!dtr.IsDBNull(3)) // Aquí, 3 representa el índice de la columna que deseas leer
                            {
                            if (departure_time == Convert.ToDateTime(dtr["arrived_time"]) 
                                    && arr_airport_name == dtr["arrived_airport_name"].ToString() 
                                    && dep_airport_name == dtr["departure_airport_name"].ToString())
                                {
                                    oTicket.Add(new Plane()
                                    {
                                        id_plane = Convert.ToInt32(dtr["id_plane"]),
                                        arrived_time = Convert.ToDateTime(dtr["arrived_time"]),
                                        departure_time = Convert.ToDateTime(dtr["departure_time"]),
                                        arrived_aiport_id = Convert.ToInt32(dtr["arrived_airport_id"]),
                                        departure_airport_id = Convert.ToInt32(dtr["departure_airport_id"]),
                                        flight_status = dtr["flight_status"].ToString(),
                                        max_weight = Convert.ToDecimal(dtr["max_weight"]),
                                        plane_weight = Plane.getWeight(dtr["plane_weight"].ToString(), dtr["max_weight"].ToString()),
                                        max_passenger = dtr["max_passengers"].ToString(),
                                        quantity_passenger = Plane.getPassengers(dtr["quantity_passengers"].ToString(), dtr["max_passengers"].ToString()),
                                        arrived_airport_name = dtr["arrived_airport_name"].ToString(),
                                        departure_airport_name = dtr["departure_airport_name"].ToString()
                                    });
                                }
                            }
                        }
                    }

                    return oTicket;
                }
                catch
                {
                    return oTicket;
                }

            }
        }
        public static bool ComprarVuelo(Pasajero oPasajero)
        {
            using (SqlConnection oConexion = new SqlConnection(Conexion.connectionPath))
            {
                SqlCommand cmd = new SqlCommand("sp_buy_flight", oConexion);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@arrived_time", oPasajero.arr_time);
                cmd.Parameters.AddWithValue("@departure_time", oPasajero.dep_time);
                cmd.Parameters.AddWithValue("@arrived_airport_name", oPasajero.arr_air_name);
                cmd.Parameters.AddWithValue("@departure_airport_name", oPasajero.dep_air_name);
                cmd.Parameters.AddWithValue("@full_name", oPasajero.f_name);
                cmd.Parameters.AddWithValue("@baggage_weight", oPasajero.baggage_weight);
                cmd.Parameters.AddWithValue("@flight_id", oPasajero.flight_code);

                try
                {
                oConexion.Open();
                    cmd.ExecuteNonQuery();
                    return true;
                }
                catch (Exception ex)
                {
                    return false;
                }
            }
        }
        public static string CrearAeropuerto(Airport oAirport)
        {
            using (SqlConnection oConexion = new SqlConnection(Conexion.connectionPath))
            {
                SqlCommand cmd = new SqlCommand("sp_create_airport", oConexion);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@airport_name", oAirport.airport_name);
                cmd.Parameters.AddWithValue("@max_planes", oAirport.max_planes);
                cmd.Parameters.AddWithValue("@max_planes_dep", oAirport.max_planes_departuring);
                cmd.Parameters.AddWithValue("@max_planes_arr", oAirport.max_planes_arriving);

                try
                {
                    oConexion.Open();
                    cmd.ExecuteNonQuery();
                    return "¡Aeropuerto Creado Exitosamente!";
                }
                catch (Exception ex)
                {
                    return ex.ToString();
                }

            }
        }
    }
}
