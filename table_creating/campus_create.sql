-- Create table with name campus_db

-- Parkville campus info
WITH parkville_main_off_UNION as(
 WITH parkville_main_off as (
  WITH parkville_main as (
   SELECT *
   FROM spatial.unimelb_campus as campus_info
   WHERE campus_info.p_cluster ='Main_Campus' and campus_info.campus = 'Parkville'
  )
  SELECT parkville_main.campus as campus_name, campus_off_info.geom as off_campus_geom, parkville_main.geom as main_geom
  FROM parkville_main 
  CROSS JOIN spatial.unimelb_campus as campus_off_info
  WHERE campus_off_info.p_cluster ='Off_Campus' and campus_off_info.campus = 'Parkville'
  )
 SELECT parkville_main_off.campus_name, ST_Union(off_campus_geom, main_geom) as main_off_geom
 FROM parkville_main_off
)
SELECT parkville_main_off_UNION.campus_name, ST_Union(parkville_main_off_UNION.main_off_geom, campus_other_info.geom) as geom INTO group01.campus_db
FROM parkville_main_off_UNION
CROSS JOIN spatial.unimelb_campus as campus_other_info
WHERE campus_other_info.p_cluster ='Other' and campus_other_info.campus = 'Parkville';

-- Inser campus with only one geom row
INSERT INTO group01.campus_db
SELECT campus, geom
FROM spatial.unimelb_campus as campus_info
WHERE campus_info.campus = 'Burnley' or campus_info.campus = 'Creswick' or campus_info.campus = 'Werribee';

-- Dookie campus info
INSERT INTO group01.campus_db
SELECT off_campus_info.campus as campus, ST_Union(off_campus_info.geom, main_campus_info.geom) as Dookie_main_off_other
FROM spatial.unimelb_campus as off_campus_info
CROSS JOIN spatial.unimelb_campus as main_campus_info
WHERE off_campus_info.campus = 'Dookie' and main_campus_info.campus = 'Dookie' and off_campus_info.p_cluster = 'Off_Campus' and main_campus_info.p_cluster = 'Main_Campus'

-- Shepparton campus info
INSERT INTO group01.campus_db
SELECT off_campus_info.campus as campus, ST_Union(off_campus_info.geom, main_campus_info.geom) as Shepparton_main_off_other
FROM spatial.unimelb_campus as off_campus_info
CROSS JOIN spatial.unimelb_campus as main_campus_info
WHERE off_campus_info.campus = 'Shepparton' and main_campus_info.campus = 'Shepparton' and off_campus_info.p_cluster = 'Other' and main_campus_info.p_cluster = 'Main_Campus'


-- Southbank campus info

-- TESTING INVALID GEOM in Southbank Campus
SELECT campus,p_cluster,geom
FROM spatial.unimelb_campus as off_campus_info
WHERE NOT ST_isvalid(geom);

INSERT INTO group01.campus_db
SELECT off_campus_info.campus as campus, ST_Union(off_campus_info.geom, ST_MakeValid(main_campus_info.geom)) as Southbank_main_off_other
FROM spatial.unimelb_campus as off_campus_info
CROSS JOIN spatial.unimelb_campus as main_campus_info
WHERE off_campus_info.campus = 'Southbank' and main_campus_info.campus = 'Southbank' and off_campus_info.p_cluster = 'Other' and main_campus_info.p_cluster = 'Main_Campus'

