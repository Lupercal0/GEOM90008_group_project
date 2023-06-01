-- the valid (control the load weight) combincation of drone, sensor and battery
WITH load_weight_tb AS(
   SELECT (drone.self_weight+sensor.weight+battery.weight) AS load_weight, drone.id AS drone_id, sensor.id AS sensor_id, battery.id AS battery_id
   FROM group01.drone, group01.sensor, group01.battery)
SELECT load_weight, drone_id, sensor_id, battery_id
FROM load_weight_tb
WHERE load_weight < 250;

--create flight history dataset
DROP TABLE IF EXISTS group01.flight_history;
CREATE TABLE group01.flight_history
(flight_history_id serial,
 path_id serial,
 drone_id serial,
 sensor_id serial,
 battery_id serial,
 operator_id serial,
 max_elevation float(2),
 min_elevation float(2),
 flight_date date
);

-- path 1-7 are all in the campus area
INSERT INTO group01.flight_history VALUES (1, 1, 1, 35, 8, 4, 63, 33, '2023-05-23');
INSERT INTO group01.flight_history VALUES (2, 2, 1, 25, 12, 2, 77, 25, '2023-04-23');
INSERT INTO group01.flight_history VALUES (3, 3, 34, 43, 46, 5, 73, 34, '2023-03-13');
INSERT INTO group01.flight_history VALUES (4, 4, 19, 51, 75, 43, 88, 33, '2023-02-28');
INSERT INTO group01.flight_history VALUES (5, 5, 23, 62, 70, 24, 110, 46, '2023-05-21');
INSERT INTO group01.flight_history VALUES (6, 6, 10, 56, 70, 36, 74, 35, '2023-05-23');
INSERT INTO group01.flight_history VALUES (7, 7, 7, 47, 42, 23, 74, 36, '2023-05-15');


-- path 8-10 are all outside the campus area
INSERT INTO group01.flight_history VALUES (8, 8, 6, 62, 77, 3, 69, 36, '2023-02-13');
INSERT INTO group01.flight_history VALUES (9, 9, 24, 44, 28, 7, 86, 35, '2023-05-13');
INSERT INTO group01.flight_history VALUES (10, 10, 18, 58, 75, 31, 74, 35, '2023-05-13');



UPDATE group01.flight_history
SET(real_fly_time) = (
WITH flight_info AS (
	SELECT path_id, operator_id
	FROM group01.flight_history
	WHERE flight_history.flight_history_id = 1
)
SELECT st_length(ST_Transform(st_force2D(geom), 7855))/5/60 + 6 AS flight_time 
FROM group01.flight_path
WHERE id = (SELECT path_id FROM flight_info)
)
WHERE flight_history_id = 1;