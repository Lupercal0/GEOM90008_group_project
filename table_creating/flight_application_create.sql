
--create table flight_application
DROP TABLE IF EXISTS group01.flight_application;
CREATE TABLE group01.flight_application(
plan_id serial primary key,
geom geometry(Linestringz, 4326),
--pass through airport -> false
is_weight_limit boolean,
-- out of campus -> true
is_licence_re boolean,
max_elev float(2),
min_elev float(2),
is_distance_valid boolean,
is_plan_valid boolean
);
