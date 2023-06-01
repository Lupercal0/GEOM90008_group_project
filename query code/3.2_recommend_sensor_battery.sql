WITH valid AS(
	SELECT plan_id,ST_length(ST_transform(geom,7855)) AS length, is_weight_limit
	FROM group01.flight_application
	WHERE is_plan_valid=true
)
SELECT plan_id, battery.id as optional_battery_id
FROM group01.battery as battery, valid
-- we assume the remained battery is able to fly for at least 3 times the applied length
WHERE (battery_level/100*(weight-43)*30/39)*60*5/3>valid.length
AND ((weight>100) OR is_weight_limit);




WITH valid AS(
	SELECT plan_id,ST_length(ST_transform(geom,7855)) AS length, is_weight_limit, max_elev
	FROM group01.flight_application
	WHERE is_plan_valid=true
)
SELECT plan_id, sensor.id as optional_sensor_id
FROM group01.sensor as sensor, valid
-- we also have to make sure the sensor's height limit
WHERE max_elev<height_limit;




