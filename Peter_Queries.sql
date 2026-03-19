/*Max airspeed for each severity level*/

SELECT a.Severity, MAX(w.Wind_Speed) AS Max_Wind_Speed
FROM accidents a
JOIN weather w ON a.Weather_ID = w.Weather_ID
WHERE w.Wind_Speed IS NOT NULL
GROUP BY a.Severity
ORDER BY a.Severity;

/*Looking at the severity of accidents (4 representing the most impact on traffic), do we see a correlation with the average total time of the accident?*/

SELECT 
    a.Severity, 
    COUNT(*) AS Total_Accidents, 
    AVG(TIMESTAMPDIFF(MINUTE, a.Start_Time, a.End_Time)) AS AVG_Elapsed_Minutes,
    MIN(TIMESTAMPDIFF(MINUTE, a.Start_Time, a.End_Time)) AS MIN_Elapsed_Minutes,
    MAX(TIMESTAMPDIFF(MINUTE, a.Start_Time, a.End_Time)) AS MAX_Elapsed_Minutes
FROM accidents a
WHERE a.Start_Time IS NOT NULL 
  AND a.End_Time IS NOT NULL
GROUP BY a.Severity
ORDER BY a.Severity;


/*How do weather conditions and severity affect the average time of the accident?*/

SELECT
    a.Severity,
    w.Weather_Condition,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, a.Start_Time, a.End_Time)), 2) AS Avg_Elapsed_Time
FROM accidents a
JOIN weather w
    ON a.Weather_ID = w.Weather_ID
WHERE a.Start_Time IS NOT NULL
  AND a.End_Time IS NOT NULL
  AND a.End_Time > a.Start_Time
GROUP BY a.Severity, w.Weather_Condition
ORDER BY a.Severity, Avg_Elapsed_Time DESC;


/*What are the 5 longest accident times, for each severity level?*/

WITH accident_times AS (
    SELECT a.ID, a.Severity, TIMESTAMPDIFF(MINUTE, a.Start_Time, a.End_Time) AS Elapsed_Time
    FROM accidents a
    WHERE a.Start_Time IS NOT NULL AND a.End_Time IS NOT NULL AND a.End_Time > a.Start_Time
),
ranked AS (
    SELECT ID, Severity, Elapsed_Time,
        DENSE_RANK() OVER (PARTITION BY Severity ORDER BY Elapsed_Time DESC) AS rnk
    FROM accident_times
)
SELECT ID, Severity, Elapsed_Time
FROM ranked
WHERE rnk <= 5
ORDER BY Severity, Elapsed_Time DESC;
