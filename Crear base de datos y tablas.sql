--Se crea la base de datos

CREATE DATABASE ControlTower

USE ControlTower

Drop database ControlTower

--Se crea la tabla "planes"



CREATE TABLE plane(
id_plane INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
arrived_time DATETIME,
departure_time DATETIME,
arrived_airport_id INT NOT NULL,
departure_airport_id INT NOT NULL, 
flight_status VARCHAR(20) NOT NULL,
max_weight DECIMAL(4,2) NOT NULL DEFAULT 150,
plane_weight DECIMAL(4,2), 
max_passengers INT NOT NULL DEFAULT 100,
quantity_passengers INT DEFAULT 100,
CONSTRAINT arrived_airport_FK FOREIGN KEY (arrived_airport_id) REFERENCES airport(id_airport),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
CONSTRAINT departure_airport_FK FOREIGN KEY (departure_airport_id) REFERENCES airport(id_airport)
);

--Se crea la tabla "passenger"

CREATE TABLE passenger(
id_passenger INT IDENTITY(0,1) PRIMARY KEY NOT NULL,
passenger_full_name NVARCHAR(60) NOT NULL,
baggage_weight DECIMAL(4,2),
flight_id INT NOT NULL,
CONSTRAINT flight_FK FOREIGN KEY (flight_id) REFERENCES plane(id_plane)
);

--Se crea tabla "airport"

CREATE TABLE airport(
id_airport INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
airport_name NVARCHAR(60) NOT NULL,
max_planes INT NOT NULL DEFAULT 50,
planes_quantity INT NOT NULL,
max_planes_departuring INT,
planes_departuring INT NOT NULL,
max_planes_arriving INT,
planes_arriving INT NOT NULL
);

DROP TABLE airport

SELECT * FROM plane
SELECT * FROM passenger

Delete from plane
where id_plane > 5

DBCC CHECKIDENT(plane, reseed, 5)

--PROCEDURES

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
						WHERE flight_id = 3);

	SET @q_pass = (SELECT  COUNT(*) AS tt_q_pass
					FROM passenger
					WHERE flight_id = 3);

	UPDATE plane
	SET plane_weight = @pln_weight, quantity_passengers = @q_pass
	WHERE id_plane = @lst_row;*/
END;

SELECT  COUNT(*) AS tt_q_pass
					FROM passenger
					WHERE flight_id = 3;

EXEC sp_register '2023-06-12 10:30:00', '2023-06-12 10:30:00', 'Airport A', 'Airport B', 'Flying', 20.00, 200

SELECT * FROM plane

