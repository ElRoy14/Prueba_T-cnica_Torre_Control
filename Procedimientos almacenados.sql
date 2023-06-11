USE ControlTower

CREATE PROCEDURE sp_regist(
@arrived_time DATETIME,
@departure_time DATETIME,
@flight_d_id INT,
@flight_status VARCHAR(20),
@max_weight DECIMAL(4,2),
@max_passengers INT,
@quantity_passengers INT,
@arrived_airport_id INT,
@departure_airport_id INT,
@flight_status VARCHAR(20),
@quantity_passengers INT)
AS
BEGIN
	INSERT INTO plane VALUES (@arrived_time, @departure_time, @flight_d_id);

	INSERT INTO flight_details VALUES (@arrived_airport_id, @departure_airport_id, @flight_status, @quantity_passengers);
END;

DROP PROCEDURE sp_show

EXEC sp_show

CREATE PROCEDURE sp_show_flight
AS
BEGIN
	SELECT * FROM plane
END;

exec sp_show_flight