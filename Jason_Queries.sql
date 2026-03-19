# How long does it take to get help in the night compared to in the day after an accident?
SELECT A.Sunrise_Sunset,
COUNT(*)AS TOTAL_ACCIDENTS,
AVG(TIMESTAMPDIFF(MINUTE, a.Start_Time, a.End_Time)) AS AVG_MINS
FROM ACCIDENTS A
WHERE SUNRISE_SUNSET IN ('Day','Night')
GROUP BY a.Sunrise_Sunset;

#Which road features are most commonly present at accidents?
SELECT SUM(R.Bump) AS Bump,
SUM(R.Crossing) AS Crossing,
SUM(R.Junction) AS Junction,
SUM(R.Railway) AS Railway,
SUM(R.Roundabout) AS Roundabout,
SUM(R.Stop) AS Stop,
SUM(R.Traffic_Calming) AS Traffic_Calming,
SUM(R.Traffic_Signal) AS Traffic_Signal
FROM ACCIDENTS A
JOIN ROAD R ON A.Road_ID = R.Road_ID;

# Earlier we learned that LA has the highest number of accidents, rank the top 10 most accident prone cities
SELECT RANK() OVER (ORDER BY COUNT(a.ID) DESC) AS accident_rank,
L.Street,
L.City,
L.State,
COUNT(A.ID) AS total_accidents
FROM ACCIDENTS A
JOIN LOCATION L ON A.Location_ID = L.Location_ID
WHERE L.City = 'Los Angeles' AND L.State = 'CA'
GROUP BY L.Street, L.City, L.State
ORDER BY accident_rank
LIMIT 10;


