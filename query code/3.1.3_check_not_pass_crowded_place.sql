--3.1.3

--check crowed palce(park)
UPDATE group01.flight_application
SET(is_notcrowded) = (
SELECT CASE
	WHEN EXISTS (
		SELECT 
		f.plan_id, 
		St_intersects(st_transform(st_force2d(f.geom), 4326), st_transform(ST_buffer(st_transform(st_setsrid(ST_MAKEPOINT(a.longitude, a.latitude), 4326), 7855), 50),4326))
		FROM group01.flight_application AS f
		CROSS JOIN group01.park AS a
		WHERE St_intersects(st_transform(st_force2d(f.geom), 4326), st_transform(ST_buffer(st_transform(st_setsrid(ST_MAKEPOINT(a.longitude, a.latitude), 4326), 7855), 50),4326))
		AND f.plan_id  = 4
	)
	THEN FALSE
	ELSE TRUE
END AS condition_result
)
--change the plan_id here
where plan_id = 4;
