--3.1.7
-- check is the path in the application is valid 
UPDATE group01.flight_application
SET(is_plan_valid) = (
SELECT (max_elev < 120) and (min_elev > 30) and (is_distance_valid) and (is_notcrowded) and (battery_check)
FROM group01.flight_application
WHERE plan_id = 1
)
WHERE plan_id = 1;

