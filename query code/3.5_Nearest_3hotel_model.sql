--3.5 Give 3 nearest hotels and one nearest hospital address and name information
--the nearest hotel_model in polygon from the starter point
With hotel_db as(
SELECT hotel_table.name AS hotel_name, hotel_table.way AS geom_location
FROM
((SELECT name, tags, way
FROM spatial.melbourne_osm_point 
WHERE tags?'tourism' 
AND tags->'tourism'='hotel'
AND name IS NOT NULL)
UNION
(SELECT name, tags, way
FROM spatial.melbourne_osm_polygon 
WHERE tags?'building' 
AND tags->'building'='hotel'
AND name IS NOT NULL)
UNION
(SELECT name, tags, way
FROM spatial.melbourne_osm_polygon 
WHERE tags?'tourism' 
AND tags->'tourism'='motel'
AND name IS NOT NULL)
UNION
(SELECT name, tags, way
FROM spatial.melbourne_osm_point 
WHERE tags?'tourism' 
AND tags->'tourism'='motel'
AND name IS NOT NULL)) AS hotel_table)
SELECT hotel_db.hotel_name, ST_StartPoint(ST_Transform(hotel_db.geom_location, 4326))
FROM group01.flight_path as path, hotel_db
-- change the flight_path id here
WHERE path.id = 4
ORDER BY ST_StartPoint(path.geom) <-> ST_Transform(hotel_db.geom_location, 4326)
limit 3;

