DROP TABLE IF EXISTS group01.hotel;
CREATE TABLE group01.hotel
(id serial,
 hotel_name varchar,
 geom geometry
);

INSERT INTO group01.hotel(hotel_name,geom)
SELECT hotel_table.name AS hotel_name, hotel_table.way AS geom
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
AND name IS NOT NULL)) AS hotel_table;


SELECT * FROM group01.hotel;