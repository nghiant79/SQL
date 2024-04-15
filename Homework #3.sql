SET ECHO ON;

--1. For each month in 2024, what is the average distance between the Moon and Earth? (in km, rounded to 1 decimal point)
SELECT TO_CHAR(datetime, 'MONTH') AS MONTH,
       ROUND(AVG(dist),1) AS "Month's Average Distance"
FROM jrwolf.moon24
GROUP BY TO_CHAR(datetime, 'MONTH'), TO_CHAR(datetime,'MM')
ORDER BY TO_CHAR(datetime,'MM');

--2. What is the maximum difference in distance between consecutive days in 2024? (in km)
--SELECT MAX(abs(dist - LAG(dist, 1) OVER (ORDER BY datetime))) AS max_difference
--FROM jrwolf.moon24;

SELECT MAX(diff) AS max_difference
FROM (
    SELECT ABS(dist - LAG(dist, 1) OVER (ORDER BY datetime)) AS diff
    FROM jrwolf.moon24
);

--3. What is the standard deviation of the distances between the Moon and Earth in 2024? (in km)
SELECT STDDEV_POP(dist) AS distance_stddev
FROM jrwolf.moon24;

--4. Identify the month in 2024 with the smallest average change in the Moon's distance from Earth between consecutive days. 
--Display the month and the average change (in km).
SELECT TO_CHAR(datetime, 'Month') AS month,
       AVG(change_in_distance) AS avg_change
FROM (
    SELECT datetime,
           ABS(dist - LAG(dist) OVER (ORDER BY datetime)) AS change_in_distance
    FROM jrwolf.moon24
) a
GROUP BY TO_CHAR(datetime, 'Month')
ORDER BY avg_change
FETCH FIRST ROW ONLY;

--17. Determine the day in 2024 when the Moon's distance from Earth experienced the largest decrease compared to the previous day. 
--Display the date and the decrease in distance (in km).
SELECT datetime, decrease_in_distance
FROM (
    SELECT datetime,
           dist - LAG(dist, 1) OVER (ORDER BY datetime) AS decrease_in_distance
    FROM jrwolf.moon24
)
WHERE decrease_in_distance IS NOT NULL
ORDER BY decrease_in_distance DESC
FETCH FIRST ROW ONLY;

--18. What is the average distance between the Moon and Earth throughout the year 2024? (in km)
SELECT ROUND(AVG(dist)) "Average Distance"
FROM jrwolf.moon24;

--19. For each month in 2024, what is the furthest distance between the Moon and Earth? (in km, rounded to 1 decimal point). 
-- Display only the months where the distance is greater than 406,000 km.
SELECT TO_CHAR(datetime, 'MONTH') AS MONTH,
       ROUND(MAX(dist),1) AS "Month's Furthest Distance"
FROM jrwolf.moon24
GROUP BY TO_CHAR(datetime, 'MONTH')
HAVING  MAX(dist) > 406000
ORDER BY 2 DESC;

--20. What is the average distance between the Moon and Earth throughout the year 2024? (in miles, rounded to 1 decimal point)
SELECT ROUND(AVG(dist)*0.62137,1) "Average Distance(Miles)"
FROM jrwolf.moon24;
