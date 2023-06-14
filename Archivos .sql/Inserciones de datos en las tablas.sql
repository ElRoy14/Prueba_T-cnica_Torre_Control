USE ControlTower

-- Insertar registros en la tabla "airport"
INSERT INTO airport (airport_name, planes_quantity, max_planes_departuring, max_planes_arriving)
VALUES ('Airport A', 40, 8, 12);

INSERT INTO airport (airport_name, planes_quantity, max_planes_departuring, max_planes_arriving)
VALUES ('Airport B', 45, 10, 15);

INSERT INTO airport (airport_name, planes_quantity, max_planes_departuring, max_planes_arriving)
VALUES ('Airport C', 35, 6, 10);

INSERT INTO airport (airport_name, planes_quantity, max_planes_departuring, max_planes_arriving)
VALUES ('Airport D', 50, 12, 18);

INSERT INTO airport (airport_name, planes_quantity, max_planes_departuring, max_planes_arriving)
VALUES ('Airport E', 30, 5, 8);

-- Insertar registros en la tabla "plane"
-- Avión 1
INSERT INTO plane (arrived_time, departure_time, arrived_airport_id, departure_airport_id, flight_status, max_weight, plane_weight, max_passengers, quantity_passengers)
VALUES ('2023-06-12 09:00:00', '2023-06-12 10:30:00', 1, 2, 'Departed', 15.00, 13.50, 100, 85);

-- Avión 2
INSERT INTO plane (arrived_time, departure_time, arrived_airport_id, departure_airport_id, flight_status, max_weight, plane_weight, max_passengers, quantity_passengers)
VALUES ('2023-06-12 09:30:00', '2023-06-12 11:00:00', 2, 1, 'Arrived', 15.00, 14.20, 100, 90);

-- Avión 3
INSERT INTO plane (arrived_time, departure_time, arrived_airport_id, departure_airport_id, flight_status, max_weight, plane_weight, max_passengers, quantity_passengers)
VALUES ('2023-06-12 10:00:00', '2023-06-12 11:45:00', 3, 4, 'Departed', 15.00, 13.00, 100, 80);

-- Avión 4
INSERT INTO plane (arrived_time, departure_time, arrived_airport_id, departure_airport_id, flight_status, max_weight, plane_weight, max_passengers, quantity_passengers)
VALUES ('2023-06-12 10:30:00', '2023-06-12 12:15:00', 4, 3, 'Arrived', 15.00, 14.70, 100, 95);

-- Avión 5
INSERT INTO plane (arrived_time, departure_time, arrived_airport_id, departure_airport_id, flight_status, max_weight, plane_weight, max_passengers, quantity_passengers)
VALUES ('2023-06-12 11:00:00', '2023-06-12 12:45:00', 5, 2, 'Departed', 15.00, 13.90, 100, 75);

-- Insertar registros en la tabla "passenger"
-- Pasajero 1
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES ('John Smith', 25.5, 1);

-- Pasajero 2
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES ('Jane Doe', 20.1, 1);

-- Pasajero 3
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES ('Michael Johnson', 18.7, 2);

-- Pasajero 4
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES ('Emily Wilson', 23.9, 2);

-- Pasajero 5
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES ('Sarah Thompson', 19.8, 3);

-- Inserción 6
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES ('John Smith', 20.5, 1);

-- Inserción 7
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES ('Emily Johnson', 15.2, 1);

-- Inserción 8
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES ('David Williams', 18.7, 2);

-- Inserción 9
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES ('Sophia Davis', 12.3, 2);

-- Inserción 10
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES ('James Anderson', 22.1, 3);

-- Inserción 11
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES ('Olivia Thompson', 19.8, 3);

-- Inserción 12
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES ('Benjamin Wilson', 16.5, 3);

