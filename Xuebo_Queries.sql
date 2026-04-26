-- 2 basic SQL queries, 6 advanced SQL query
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


-- Advanced SQL Query 1
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


-- Advanced SQL Query 2
-- CTE
-- What is the average accident duration by severity level?
WITH duration_cte AS (
    SELECT Severity,
           TIMESTAMPDIFF(MINUTE, Start_Time, End_Time) AS duration_minutes
    FROM accidents
)
SELECT Severity, ROUND(AVG(duration_minutes), 2) AS avg_duration
FROM duration_cte
GROUP BY Severity
ORDER BY Severity;


-- Advanced SQL Query 3
-- Subquery
-- Which weather conditions are most associated with severe accidents (Severity ≥ 3)
SELECT Weather_Condition, COUNT(*) AS severe_accidents
FROM weather
WHERE Weather_ID IN (
    SELECT Weather_ID
    FROM accidents
    WHERE Severity >= 3
)
GROUP BY Weather_Condition
ORDER BY severe_accidents DESC
LIMIT 5;


-- Advanced SQL Query 4
-- View
-- Which road features are most common in accident-prone areas?
CREATE VIEW high_risk_roads AS
SELECT r.Traffic_Signal, r.Crossing, r.Junction, COUNT(*) AS accident_count
FROM accidents a
JOIN road r ON a.Road_ID = r.Road_ID
GROUP BY r.Traffic_Signal, r.Crossing, r.Junction;
SELECT 
    CASE WHEN Traffic_Signal = 1 THEN 'TRUE' ELSE 'FALSE' END AS Traffic_Signal,
    CASE WHEN Crossing = 1 THEN 'TRUE' ELSE 'FALSE' END AS Crossing,
    CASE WHEN Junction = 1 THEN 'TRUE' ELSE 'FALSE' END AS Junction,
    accident_count
FROM high_risk_roads
ORDER BY accident_count DESC
LIMIT 5;


-- Advanced SQL Query 5
-- Subquery
-- How did monthly accident counts change month-over-month in California?
SELECT year_mo, monthly_accidents,
    LAG(monthly_accidents) OVER (ORDER BY year_mo) AS prev_month,
    ROUND((monthly_accidents - LAG(monthly_accidents) OVER (ORDER BY year_mo)) 
        * 100.0 / LAG(monthly_accidents) OVER (ORDER BY year_mo), 1) AS pct_change
FROM (
    SELECT DATE_FORMAT(a.Start_Time, '%Y-%m') AS year_mo, COUNT(*) AS monthly_accidents
    FROM accidents a
    JOIN location l ON a.Location_ID = l.Location_ID
    WHERE l.State = 'CA'
    GROUP BY year_mo
) sub
ORDER BY ABS(pct_change) DESC 
LIMIT 10;


-- Advanced SQL Query 6
-- Index + Explain
-- How can we speed up the frequent query that filters accidents by state and date range 
CREATE INDEX idx_location_state ON location (State, City);
CREATE INDEX idx_accident_time_loc ON accidents (Start_Time, Location_ID, Severity);
EXPLAIN SELECT l.State, l.City, COUNT(*) AS accidents, AVG(a.Severity) AS avg_severity
FROM accidents a
JOIN location l ON a.Location_ID = l.Location_ID
WHERE l.State = 'CA' AND a.Start_Time BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY l.State, l.City
ORDER BY accidents DESC;
