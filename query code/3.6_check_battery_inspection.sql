--3.6 Notify users on batteries or sensors needed for inspection 
--the carlitation due date for each battery is one month before 2 years
SELECT * FROM group01.battery_history
WHERE (DATE_PART('year', '2023-06-10'::date) - DATE_PART('year', inspection_date::date)) * 365 +
   EXTRACT(DOY FROM DATE '2023-06-10') - EXTRACT(DOY FROM inspection_date) > 700;

--the carlitation due date for each sensor is one month before 1 year
SELECT * FROM group01.sensor_history
WHERE (DATE_PART('year', '2023-06-10'::date) - DATE_PART('year', calibration_date::date)) * 365 +
   EXTRACT(DOY FROM DATE '2023-06-10') - EXTRACT(DOY FROM calibration_date) > 335;
