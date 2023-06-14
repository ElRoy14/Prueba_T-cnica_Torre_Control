USE ControlTower

DROP PROCEDURE sp_show_flight

--Obtener todos los datos del vuelo
CREATE PROCEDURE sp_show_flight(
@id INT)
AS
BEGIN
	DECLARE @arr_air_id INT,
			@dep_air_id INT,
			@arr_air_name VARCHAR(40),
			@dep_air_name VARCHAR(40);

	SELECT * 
	FROM plane
	WHERE id_plane = @id;

	SET @arr_air_id = (SELECT arrived_airport_id
						FROM plane
						WHERE id_plane = @id);
	SET @dep_air_id = (SELECT departure_airport_id
						FROM plane
						WHERE id_plane = @id);

	SET @arr_air_name = (SELECT airport_name
						FROM airport
						WHERE id_airport = @arr_air_id);

	SET @dep_air_name = (SELECT airport_name
						FROM airport
						WHERE id_airport = @dep_air_id);
	UPDATE plane
	SET arrived_airport_name = @arr_air_name, departure_airport_name = @dep_air_name
	WHERE id_plane = @id;

END;

SELECT * FROM airport

exec sp_show_flight 1;

EXEC sp_show_flight 2;

--Crear procedimiento para obtener solo los nombres de los aeropuertos
DROP PROCEDURE sp_show_air_name

CREATE PROCEDURE sp_show_air_name(
@id INT)
AS
BEGIN
	SELECT arrived_airport_name
	FROM plane
	WHERE id_plane = @id;
END;

EXEC sp_show_air_name 4

--Crear procedure para registrar un vuelo nuevo

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
			@q_pass INT;

	SET @a_airport_id = (SELECT id_airport 
						FROM airport
						WHERE airport_name = @arr_air_name);

	SET @d_airport_id = (SELECT id_airport 
						FROM airport
						WHERE airport_name = @dep_air_name);


	INSERT INTO plane (arrived_time, departure_time, arrived_airport_name, arrived_airport_id, departure_airport_name, departure_airport_id, flight_status, max_weight, max_passengers)
						VALUES (@arr_time, @dep_time, @arr_air_name, @d_airport_id, @dep_air_name, @d_airport_id, @fly_sts, @max_weight, @max_pass);

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

CREATE PROCEDURE sp_cancel(
@id INT)
AS
BEGIN

	DELETE FROM passenger
	WHERE flight_id = @id;

	DELETE FROM plane
	WHERE id_plane = @id;
END;
drop procedure sp_cancel

EXEC sp_cancel 6

EXEC sp_register '2023-06-12 12:00:00', '2023-06-12 12:30:00', 'Airport A', 'Airport B', 'Flying', 20.00, 200

--Crear procedure para buscar los vuelos disponibles en base a la fecha deseada

CREATE PROCEDURE sp_search_flight(
@arrived_time DATETIME,
@arrived_airport_name VARCHAR(40),
@departure_airport_name VARCHAR(40))
AS
BEGIN
	DECLARE @arr_time VARCHAR(30),
			@dep_time VARCHAR(30),
			@arr_air_name VARCHAR(20),
			@dep_air_name VARCHAR(20);

	SELECT arrived_time, id_plane, arrived_airport_name, departure_airport_name FROM plane
	Where arrived_time = @arrived_time;
END;

EXEC sp_search_flight '2023-12-06T09:00:00.000Z', 'Airport A', 'Airport B'

DROP procedure sp_search_flight

--Crear procedure para comprar un vuelo especifico

CREATE PROCEDURE sp_buy_flight(
@arrived_time DATETIME,
@departure_time DATETIME,
@arrived_airport_name VARCHAR(40),
@departure_airport_name VARCHAR(40),
@full_name VARCHAR(60),
@baggage_weight DECIMAL(4,2),
@flight_id INT)
AS
BEGIN
	DECLARE @arr_time DATETIME,
			@dep_time DATETIME,
			@arr_air_name VARCHAR(40),
			@dep_air_name VARCHAR(40),
			@f_name VARCHAR(60),
			@bag_weight DECIMAL(4,2),
			@flight_code INT;

	SET @flight_code = (SELECT id_plane 
						FROM plane
						WHERE arrived_time = @arr_time);

	SET @arr_air_name = (SELECT arrived_airport_name
						FROM plane
						WHERE id_plane = @flight_id);

	SET @dep_air_name = (SELECT departure_airport_name 
						FROM plane
						WHERE id_plane = @flight_id);

	INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
							VALUES(@full_name,  @baggage_weight, @flight_id);

	IF ((SELECT plane_weight FROM plane WHERE id_plane = @flight_id) IS NULL)
	BEGIN
		UPDATE plane
		SET plane_weight = ISNULL(plane_weight, @bag_weight), quantity_passengers = ISNULL(quantity_passengers, 1)
		WHERE id_plane = @flight_id;
		print('null');
	END
	ELSE
	BEGIN 
		UPDATE plane
		SET plane_weight += @bag_weight, quantity_passengers += 1
		WHERE id_plane = @flight_id;
		print('No null');
	END;

END;

SELECT * FROM plane

/*IF ((SELECT plane_weight FROM plane WHERE id_plane = 6) IS NULL)
	BEGIN
		UPDATE plane
		SET plane_weight = ISNULL(plane_weight, 11.00), quantity_passengers = ISNULL(quantity_passengers, 1)
		WHERE id_plane = 6;
	END
	ELSE
	BEGIN 
		PRINT('NO NULL');
	END;*/

DROP PROCEDURE sp_buy_flight

EXEC sp_buy_flight '2023-12-06 12:00:00.000', '2023-12-06 12:30:00.000', 'Airport D', 'Airport C', 'Peter Languila', 22.60, 6