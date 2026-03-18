USE us_accidents_db;
SHOW TABLES;
SELECT COUNT(*) FROM accidents;
SELECT COUNT(*) FROM weather;
SELECT COUNT(*) FROM road;
SELECT COUNT(*) FROM location;

SELECT w.Weather_Condition, COUNT(*) AS Total_Accidents
FROM accidents a
JOIN weather w
	ON w.Weather_ID = w.Weather_ID
GROUP By w.Weather_Condition
ORDER BY Total_Accidents DESC
LIMIT 5;
