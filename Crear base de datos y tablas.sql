--Se crea la base de datos

CREATE DATABASE ControlTower

USE ControlTower

Drop database ControlTower

--Se crea la tabla "planes"

CREATE TABLE plane(
id_plane INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
arrived_time DATETIME,
departure_time DATETIME,
arrived_airport_name VARCHAR(40),
arrived_airport_id INT NOT NULL,
departure_airport_name VARCHAR(40),
departure_airport_id INT NOT NULL, 
flight_status VARCHAR(20) NOT NULL,
max_weight DECIMAL(4,2) NOT NULL DEFAULT 150,
plane_weight DECIMAL(4,2), 
max_passengers INT NOT NULL DEFAULT 100,
quantity_passengers INT,
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

max_planes_arriving INT,
);

DROP TABLE airport

SELECT * FROM plane
SELECT * FROM passenger
SELECT * FROM airport

Delete from plane

DBCC CHECKIDENT(plane, reseed, 0)

Delete from passenger

DBCC CHECKIDENT(passenger, reseed, 0)

--PROCEDURES


