
--3.1.1
-- update the elevation infomation of new submitted flight path
-- for later checking
UPDATE group01.flight_application
SET (min_elev, max_elev) = (
    SELECT d.min_val, d.max_val
	FROM
	(SELECT *, 
	 ROW_NUMBER() OVER (PARTITION BY d.plan_id ) AS rn
	FROM
	 (SELECT *, 
		   MAX(d.z) OVER (PARTITION BY d.plan_id) max_val, 
		   MIN(d.z) OVER (PARTITION BY d.plan_id) min_val 
	  FROM (
	  SELECT pi.plan_id, st_z((st_dumppoints(pi.geom)).geom) as z 
	   from group01.flight_application AS pi
		--change the plan_id here
		where plan_id = 4
		group by pi.plan_id
	  	) AS d) AS d) AS d
	WHERE d.rn = 1
)
--change the plan_id here
where plan_id = 4;
