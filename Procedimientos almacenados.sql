USE ControlTower

DROP PROCEDURE sp_show_flight

CREATE PROCEDURE sp_show_flight(
@id INT)
AS
BEGIN
	SELECT * 
	FROM plane
	WHERE id_plane = @id;
END;

SELECT * FROM plane

exec sp_show_flight 1;

EXEC sp_show_flight 2;

DROP PROCEDURE sp_register

CREATE PROCEDURE sp_register(
@arr_time DATETIME,
@dep_time DATETIME,
@arr_air_name VARCHAR(20),
@dep_air_name VARCHAR(20),
@fly_sts VARCHAR(20),
@max_weight DECIMAL(4,2),
@max_pass INT
)
AS
BEGIN 
	DECLARE @a_airport_id INT,
			@d_airport_id INT,
			@pln_weight DECIMAL,
			@q_pass INT,
			@lst_row INT;

	SET @a_airport_id = (SELECT id_airport 
						FROM airport
						WHERE airport_name = @arr_air_name);

	SET @d_airport_id = (SELECT id_airport 
						FROM airport
						WHERE airport_name = @dep_air_name);


	INSERT INTO plane (arrived_time, departure_time, arrived_airport_id, departure_airport_id, flight_status, max_weight, max_passengers)
						VALUES (@arr_time, @dep_time, @d_airport_id, @d_airport_id, @fly_sts, @max_weight, @max_pass);

	/*SET @lst_row = (SELECT TOP(1) SCOPE_IDENTITY()
					FROM plane);

	SET @pln_weight = (SELECT SUM(baggage_weight) AS tt_bg_weight
						FROM passenger
						WHERE flight_id = @lst_row);

	SET @q_pass = (SELECT  COUNT(*) AS tt_q_pass
					FROM passenger
					WHERE flight_id = @lst_row);

	UPDATE plane
	SET plane_weight = 42.60, quantity_passengers = @q_pass
	WHERE id_plane = @lst_row;*/
END;


EXEC sp_register '2023-06-12 10:30:00', '2023-06-12 10:30:00', 'Airport A', 'Airport B', 'Flying', 20.00, 200