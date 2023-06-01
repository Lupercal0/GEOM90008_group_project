--3.1.5

-- check the distance of given geom is within 6000
UPDATE group01.flight_application
SET (is_distance_valid) = (
	SELECT CASE
    WHEN EXISTS (
        SELECT plan_id, ST_3DLength(ST_Transform(geom, 7855)) as dist
   		FROM group01.flight_application
   		WHERE plan_id = 4 and ST_3DLength(ST_Transform(geom, 7855)) < 6000
    )
    THEN TRUE
    ELSE FALSE
END AS condition_result
)
--change the plan_id here
where plan_id = 4;