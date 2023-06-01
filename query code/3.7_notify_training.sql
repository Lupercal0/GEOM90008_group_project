--3.7 Notify users on pilots for re-training 
--Check operators’ historical training and flying record
WITH total AS(
	SELECT o.id AS id, SUM(real_fly_time) AS total_time
	FROM group01.flight_history AS fh INNER JOIN group01.operator AS o
	ON fh.operator_id=o.id
	GROUP BY o.id
)
SELECT id
FROM total
WHERE total_time>50*60
