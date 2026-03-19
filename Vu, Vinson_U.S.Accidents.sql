-- Vinson Vu
-- Simple Query 1 - Draw insights from the database about if weather conditions influence total accidents
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

-- Simple Query 2 - Draw insights
