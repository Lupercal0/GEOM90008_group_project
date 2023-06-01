--3.1.6

-- check the bettery again the distance and whether pass airport
-- true: this path pass the battery check
UPDATE group01.flight_application
SET(battery_check) = (
WITH domains AS (SELECT d.plan_id, is_weight_limit ,case
  when d.len>6 THEN 'not-valid'
  when d.len between 3 and 6 then 'need large'
  else 'all-good'
  end AS status
FROM (SELECT plan_id, st_length(st_force2d(st_transform(f.geom, 7855)))/1000 AS len, is_weight_limit
FROM group01.flight_application AS f) AS d)

SELECT case
     when d.is_weight_limit = false AND d.status = 'need large' THEN false
     when d.status = 'not-valid' then false
     else true
    end
FROM domains AS d
WHERE d.plan_id = 1
) 
WHERE plan_id = 1;