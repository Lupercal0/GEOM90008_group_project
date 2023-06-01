--3.1.4

-- check if pass airport
--pass through airport -> false
UPDATE group01.flight_application
SET(is_weight_limit) = (
SELECT CASE
	WHEN EXISTS (
		SELECT
		f.plan_id, 
		St_intersects(st_transform(st_force2d(f.geom), 4326), st_transform(ST_buffer(st_transform(st_setsrid(ST_MAKEPOINT(a.longitude, a.latitude), 4326), 7855), 100),4326))
		FROM group01.flight_application AS f
		CROSS JOIN group01.airport AS a
		WHERE f.plan_id  = 4

	)
	THEN TRUE
	ELSE FALSE
END AS condition_result
)
--change the plan_id here
where plan_id = 4;