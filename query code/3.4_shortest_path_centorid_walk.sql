'
With distance AS(SELECT p."OBJECTID" AS node, s.id AS start, st_distance(st_transform(p.geom, 4326), s.st, true) AS d, p.geom
					FROM spatial.victoria_roads2023 AS p
						CROSS JOIN 
						(SELECT id, st_transform(st_startpoint(st_force2d(geom)), 4326) AS st  FROM group01.flight_path LIMIT 1)
				 			AS s)

SELECT node, st_transform(the_geom,4326) FROM distance AS s ORDER BY s.d LIMIT 1;



WITH near_camp_g as (
		SELECT r.central_pt 
		from (
			select *, st_distance(st_transform(c.central_pt, 4326), s.st, true) AS d 
			From (SELECT ST_Centroid(geom) as central_pt, campus_name as campus
					FROM group01.campus_db) AS c CROSS JOIN
			(SELECT id, st_transform(st_startpoint(st_force2d(geom)), 4326) AS st  FROM group01.flight_path LIMIT 1) AS s
		) AS r
		ORDER BY r.d LIMIT 1
)

SELECT l.id, st_transform(l.the_geom, 4326)
FROM (
SELECT *, st_distance(st_transform(p.the_geom, 4326), st_transform(n.central_pt, 4326), true) AS d  
from near_camp_g as n cross join spatial.victoria_roads2023_vertices_pgr AS p) AS l
ORDER  BY l.d limit 1
'

with end_point AS (SELECT*
FROM(SELECT l.id
FROM (
SELECT *, st_distance(st_transform(p.the_geom, 4326), st_transform(n.central_pt, 4326), true) AS d  
from (SELECT r.central_pt 
		from (
			select *, st_distance(st_transform(c.central_pt, 4326), st_transform(s.st, 4326), true) AS d 
			From (SELECT ST_Centroid(geom) as central_pt, campus_name as campus
					FROM group01.campus_db) AS c CROSS JOIN
			(SELECT id, st_transform(st_startpoint(st_force2d(geom)), 4326) AS st  FROM group01.flight_path LIMIT 1) AS s--HERE ROW NUMBER
		) AS r
		ORDER BY r.d LIMIT 1) as n cross join spatial.victoria_roads2023_vertices_pgr AS p) AS l
ORDER  BY l.d limit 1) AS i,
(SELECT n FROM (SELECT p.id AS n, s.id AS start, st_distance(st_transform(p.the_geom, 4326), st_transform(s.st, 4326), true) AS d
FROM spatial.victoria_roads2023_vertices_pgr AS p
CROSS JOIN (SELECT id, st_transform(st_startpoint(st_force2d(geom)), 4326) AS st  FROM group01.flight_path LIMIT 1) AS s)--HERE ROW NUMBER
 AS s ORDER BY s.d LIMIT 1) AS l
)			

--SELECT * FROM end_point

select seq, node 
FROM
end_point AS e, 
pgr_dijkstra('SELECT "OBJECTID" as id, source,target,st_length(st_transform(st_transform(geom, 4326), 7855)) AS cost FROM spatial.victoria_roads2023', e.id, e.n, false)

			
			






