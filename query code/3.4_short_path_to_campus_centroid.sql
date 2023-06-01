-- Find the shortest path for each flight path from campus central 
WITH info_db as(
 WITH campus_flight_path as (
  WITH campus_centroid as (
   SELECT ST_Centroid(ST_Force2D(geom)) as central_pt, campus_name as campus
   FROM group01.campus_db
  )
  SELECT *
  FROM group01.flight_path as path
  CROSS JOIN campus_centroid)
 SELECT ST_ShortestLine(ST_Force2D(geom), ST_Transform(central_pt, 4326)) as short_path, id, campus, ST_Length( ST_ShortestLine(ST_Force2D(geom), ST_Transform(central_pt, 4326))) as distance
 FROM campus_flight_path
)
SELECT *
FROM info_db
-- change the flight_path id here
WHERE id=1
ORDER BY distance
LIMIT 1;