
--Se crea la base de datos "ControlTower"
CREATE DATABASE ControlTower

USE ControlTower

--Se crea la tabla "planes"

CREATE TABLE plane(
id_plane INT IDENTITY PRIMARY KEY NOT NULL,
arrived_time DATETIME,
departure_time DATETIME,
flight_details_id INT NOT NULL,
CONSTRAINT flight_details_FK FOREIGN KEY (flight_details_id) REFERENCES flight_details(id_flight_d)
);

--Se crea la tabla "flight_details"

CREATE TABLE flight_details(
id_flight_d INT IDENTITY PRIMARY KEY NOT NULL,
arrived_airport_id INT NOT NULL,
departure_airport_id INT NOT NULL, 
flight_status varchar(20) NOT NULL,
max_weight DECIMAL(4,2) NOT NULL DEFAULT 150 ,
max_passengers int NOT NULL DEFAULT 100,
quantity_passengers int NOT NULL DEFAULT 100,
CONSTRAINT arrived_airport_FK FOREIGN KEY (arrived_airport_id) REFERENCES airport(id_airport),
CONSTRAINT departure_airport_FK FOREIGN KEY (departure_airport_id) REFERENCES airport(id_airport)
);

--Se crea tabla "passenger"

CREATE TABLE passenger(
id_passenger INT IDENTITY PRIMARY KEY NOT NULL,
passenger_full_name NVARCHAR(60) NOT NULL,
baggage_weight DECIMAL(4,2),
flight_id INT NOT NULL,
CONSTRAINT flight_FK FOREIGN KEY (flight_id) REFERENCES plane(id_plane)
);

--Se crea tabla "airport"

CREATE TABLE airport(
id_airport INT IDENTITY PRIMARY KEY NOT NULL,
airport_name NVARCHAR(60) NOT NULL,
max_planes INT NOT NULL,
max_planes_departuring INT NOT NULL,
max_planes_arriving INT NOT NULL,
);

--Se crea tabla "plane_airport"

CREATE TABLE plane_airport(
plane_id INT PRIMARY KEY NOT NULL, 
plane_departuring_id INT NOT NULL, 
plane_arriving_id INT NOT NULL, 
CONSTRAINT plane_FK FOREIGN KEY (plane_id) REFERENCES plane(id_plane),
CONSTRAINT plane_departuring_FK FOREIGN KEY (plane_departuring_id) REFERENCES plane(id_plane),
CONSTRAINT plane_arriving_FK FOREIGN KEY (plane_arriving_id) REFERENCES plane(id_plane)
);
