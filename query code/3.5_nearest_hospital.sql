--3.5 Give 3 nearest hotels and one nearest hospital address and name information

--ST_SRID of flight_path is 4326
--the nearest hospital from the starter point
SELECT hospital.name, hospital.geolocation
FROM group01.flight_path as path, group01.hospital as hospital
-- change the flight_path id here
WHERE path.id = 4
ORDER BY ST_StartPoint(path.geom) <-> hospital.geolocation
limit 1;