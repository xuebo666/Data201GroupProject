-- 2 basic SQL queries, 1 advanced SQL query
USE us_accidents_db;

-- Basic SQL Query 1
-- List the top 5 states have the highest number of accidents.
SELECT l.State, COUNT(*) AS Total_Accidents
FROM accidents a
JOIN location l 
ON a.Location_ID = l.Location_ID
GROUP BY l.State
ORDER BY Total_Accidents DESC
LIMIT 5;


-- Basic SQL Query 2
-- Accident happened during day and night time
SELECT Sunrise_Sunset, COUNT(*) AS Total_Accidents
FROM accidents
WHERE Sunrise_Sunset = "Day" OR Sunrise_Sunset = "Night" 
GROUP BY Sunrise_Sunset
ORDER BY Sunrise_Sunset; 


-- Advanced SQL Query 
-- Window Function 
-- Find the top 3 cities in state of AZ, CA, NY
SELECT t.State, t.City, t.Total_accidents, t.rn AS RankNumber
FROM (
	SELECT l.State, l.City, COUNT(*) AS total_accidents,
	ROW_NUMBER() OVER (PARTITION BY l.State ORDER BY COUNT(*) DESC) AS rn
	FROM accidents a
	JOIN location l 
	ON a.Location_ID = l.Location_ID
	WHERE l.State IN ("CA", "NY", "AZ")
	GROUP BY l.State, l.City) t
WHERE t.rn <= 3; 



