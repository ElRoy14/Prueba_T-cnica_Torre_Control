USE ControlTower

--------------------------------------------------------------------------Crera procedure para obtener todos los datos del vuelo---------------------------------------------

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

--------------------------------------------------------Crear procedure para registrar un vuelo nuevo--------------------------------------------------------------------------

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
			@planes_q INT,
			@planes_dep INT,
			@planes_arr INT;

	SET @a_airport_id = (SELECT id_airport 
						FROM airport
						WHERE airport_name = @arr_air_name);

	SET @d_airport_id = (SELECT id_airport 
						FROM airport
						WHERE airport_name = @dep_air_name);

--------------------------recolectando cantidad de aviones en un aeropuerto para ver si esta lleno o no----------------------------------------

	SET @planes_arr = (SELECT COUNT(*) 
						FROM plane 
						WHERE arrived_airport_name = @arr_air_name);

	SET @planes_dep = (SELECT COUNT(*) 
						FROM plane
						WHERE departure_airport_name = @dep_air_name);

	SET @planes_q = (@planes_arr + @planes_dep);

---------------------------Condicionales por si los aeropuertos estan llenos----------------------------------------------------------

	IF (@planes_q >= (SELECT max_planes FROM airport WHERE airport_name = @arr_air_name))
	BEGIN
		RAISERROR('Aeropuerto lleno', 16, 1);
		RETURN;
	END;
	IF (@planes_q >= (SELECT max_planes FROM airport WHERE airport_name = @dep_air_name))
	BEGIN
		RAISERROR('Aeropuerto lleno', 16, 1);
		RETURN;
	END;

	UPDATE airport
	SET planes_quantity += 1
	WHERE airport_name = @arr_air_name;

	INSERT INTO plane (arrived_time, departure_time, arrived_airport_name, arrived_airport_id, departure_airport_name, departure_airport_id, flight_status, max_weight, max_passengers)
						VALUES (@arr_time, @dep_time, @arr_air_name, @d_airport_id, @dep_air_name, @d_airport_id, @fly_sts, @max_weight, @max_pass);

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

-----------------------------------------Crear procedure para buscar los vuelos disponibles en base a la fecha deseada---------------------------------------------------------------------

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

------------------------------------------------------------------------Crear procedure para comprar un vuelo especifico-------------------------------------------------------------------

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
		SET plane_weight = ISNULL(plane_weight, @baggage_weight), quantity_passengers = ISNULL(quantity_passengers, 1)
		WHERE id_plane = @flight_id;
		print('null');
	END
	ELSE
	BEGIN 
		UPDATE plane
		SET plane_weight += @baggage_weight, quantity_passengers += 1
		WHERE id_plane = @flight_id;
		print('No null');
	END;

END;

-----------------------------------------------------------Crear Procedure para crear Aeropuertos-------------------------------------------------------------

CREATE PROCEDURE sp_create_airport(
@airport_name VARCHAR(40),
@max_planes INT,
@max_planes_dep INT,
@max_planes_arr INT)
AS
BEGIN
	DECLARE @planes_q INT,
			@planes_dep INT,
			@planes_arr INT;

	IF EXISTS (SELECT airport_name FROM airport WHERE airport_name = @airport_name)
	BEGIN
		RAISERROR('El nombre de aeropuerto ya existe', 16, 1);
		RETURN;
	END;

	SET @planes_arr = (SELECT COUNT(*) 
					FROM plane 
					WHERE arrived_airport_name = @airport_name);

	SET @planes_dep = (SELECT COUNT(*) 
					FROM plane
					WHERE departure_airport_name = @airport_name);

	SET @planes_q = (@planes_arr + @planes_dep);


	INSERT INTO airport (airport_name, max_planes, planes_quantity, max_planes_departuring, max_planes_arriving)
					VALUES (@airport_name, @max_planes, @planes_q, @max_planes_dep, @max_planes_arr);
END;
