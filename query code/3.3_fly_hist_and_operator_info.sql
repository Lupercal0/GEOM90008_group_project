--3.3 Check operators’ historical training and flying records
-- Gives all flight history
SELECT joined.flight_history_id, camp.campus_name AS closest_point, joined.flight_date, joined.operator_id AS operator_id, joined.phone_number, joined.email AS email
FROM group01.campus_db AS camp, (SELECT * 
						 FROM group01.flight_history AS fh INNER JOIN group01.flight_path AS fp 
						 ON fh.flight_history_id=fp.id
						 INNER JOIN group01.operator AS o
						 ON o.id=fh.operator_id
						) AS joined
WHERE ST_Distance(ST_Centroid(ST_Transform(camp.geom,4326), true),ST_Transform(joined.geom,4326),true) IN (
           -- find the closest known point (campus center)
  	with cte AS (
  		SELECT ST_Distance(ST_Centroid(ST_Transform(camp.geom,4326), true),ST_Transform(fp.geom,4326),true), ROW_NUMBER() OVER (PARTITION BY fp.id ORDER BY ST_Distance(ST_Centroid(ST_Transform(camp.geom,4326), true),ST_Transform(fp.geom,4326),true)) AS rn
  		FROM group01.flight_path AS fp,group01.campus_db AS camp
  	)
  	SELECT st_distance
  	FROM cte
  	WHERE rn=1
)



