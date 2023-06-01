
--3.1.2

-- Return the operators who are students 
SELECT *
FROM group01.operator
WHERE qualification_type = 'false';

-- check if the flight path is valid for student
-- return: true if the path is valid
	   --: Null if the path is invalid
WITH cte as(
	WITH check_db as (
	 WITH campus_flight_path as (
	 SELECT id as flight_id, path.geom as path_geom, campus.geom as campus_geom, campus
	 FROM group01.flight_path as path
	 CROSS JOIN group01.campus_db as campus
	 )
	 SELECT flight_id, ST_Within(path_geom, ST_Transform(campus_geom, 4326)) as check_result
	 FROM campus_flight_path
	)
	SELECT flight_id, check_result, 
		ROW_NUMBER() OVER (PARTITION BY check_db.flight_id ORDER BY check_db.check_result DESC) as rn
	FROM check_db
	)
SELECT flight_id, check_result
FROM cte
WHERE rn = 1;