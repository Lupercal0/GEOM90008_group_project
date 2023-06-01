-- out of campus -> true
UPDATE group01.flight_application
SET(is_licence_re) = (
SELECT CASE
	WHEN EXISTS (
	WITH check_db as (
	 WITH campus_flight_path as (
	 SELECT plan_id as flight_id, path.geom as path_geom, campus.geom as campus_geom, campus
	 FROM group01.flight_application as path
	 CROSS JOIN group01.campus_db as campus
	 )
	   -- check if the flight path is valid for student
	   -- return: true if the path is valid
	   --: Null if the path is invalid
	 SELECT ST_Within(st_force2d(path_geom), ST_Transform(campus_geom, 4326)) as check_result
	 FROM campus_flight_path
	 WHERE flight_id = 4
	)
	SELECT *
	FROM check_db
	WHERE check_result = 'true'
	GROUP BY check_result
)
THEN FALSE
ELSE TRUE
END AS condition_result
)
--change the plan_id here
where plan_id = 4;