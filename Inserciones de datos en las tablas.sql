USE ControlTower

-- Inserción de registros en la tabla "plane"
INSERT INTO plane (arrived_time, departure_time, flight_details_id)
VALUES
    ('2023-06-10 08:00:00', '2023-06-10 10:00:00', 1),
    ('2023-06-10 10:30:00', '2023-06-10 12:00:00', 2),
    ('2023-06-10 12:30:00', '2023-06-10 14:30:00', 3),
    ('2023-06-10 15:00:00', '2023-06-10 17:15:00', 4),
    ('2023-06-10 17:30:00', '2023-06-10 19:00:00', 5);

-- Inserción de registros en la tabla "flight_details"
INSERT INTO flight_details (arrived_airport_id, departure_airport_id, flight_status, max_weight, max_passengers, quantity_passengers)
VALUES
    (1, 2, 'En ruta', 15.21, 100, 80),
    (2, 3, 'Programado', 15.21, 100, 0),
    (3, 4, 'En ruta', 15.21, 100, 50),
    (4, 5, 'Aterrizado', 15.21, 100, 100),
    (5, 1, 'Aterrizado', 15.21, 100, 95);

-- Inserción de registros en la tabla "passenger"
INSERT INTO passenger (passenger_full_name, baggage_weight, flight_id)
VALUES
    ('John Smith', 20.5, 1),
    ('Jane Doe', 15.2, 1),
    ('Michael Johnson', 18.7, 2),
    ('Emily Davis', 10.0, 3),
    ('Daniel Brown', 12.3, 3);

-- Inserción de registros en la tabla "airport"
INSERT INTO airport (airport_name, max_planes, max_planes_departuring, max_planes_arriving)
VALUES
    ('Airport A', 20, 1, 1),
    ('Airport B', 30, 1, 1),
    ('Airport C', 25, 1, 1),
    ('Airport D', 35, 1, 1),
    ('Airport E', 40, 1, 1);

-- Inserción de registros en la tabla "plane_airport"
INSERT INTO plane_airport (plane_id, plane_departuring_id, plane_arriving_id)
VALUES
    (1, 2, 3),
    (2, 3, 4),
    (3, 4, 5),
    (4, 5, 1),
    (5, 1, 2);
