-- 03-05-2024 In-Class 

-- Use the jrwolf.moon24 table to answer the following: 
-- NOTE: The moon24 table gives the distance between the Moon and Earth in kilometers. 
-- The Moon's Diameter is given in arcseconds. 

-- Q1 During 2024, what is the Moon's average distance from Earth? (in km)
SELECT ROUND(AVG(dist)) "Average Distance"
FROM jrwolf.moon24;

-- Q2 During 2024, what is the Moon's average distance from Earth? (in miles. Use ROUND to show only 1 decimal point). 
-- NOTE: to convert kilometers to miles, simply multiply the number of kilometers by 0.62137.
SELECT ROUND(AVG(dist)*0.62137,1) "Average Distance(Miles)"
FROM jrwolf.moon24;
-- Q3 During 2024, what is the Moon's closest distance from Earth? (in km)
SELECT TO_CHAR(datetime, 'MM/DD/YY') Day,ROUND(AVG(dist),1) "Average Distance"
FROM jrwolf.moon24
GROUP BY TO_CHAR(datetime, 'MM/DD/YY')
ORDER BY AVG(dist)
FETCH FIRST 5 ROWS ONLY;

-- Q4 During 2024, what is the Moon's furthest distance from Earth? (in km)
SELECT TO_CHAR(datetime, 'MM/DD/YY') Day,ROUND(AVG(dist),1) "Average Distance"
FROM jrwolf.moon24
GROUP BY TO_CHAR(datetime, 'MM/DD/YY')
ORDER BY AVG(dist) DESC
FETCH FIRST 5 ROWS ONLY;
-- Q5 For every month, show the month name and the Moon's average distance from Earth? (in km). 
-- Use ROUND to show only 1 decimal point)
SELECT TO_CHAR(datetime, 'MONTH') AS MONTH,
       ROUND(AVG(dist),1) AS "Month's Average Distance"
FROM jrwolf.moon24
GROUP BY TO_CHAR(datetime, 'MONTH'), TO_CHAR(datetime,'MM')
ORDER BY TO_CHAR(datetime,'MM');
--FETCH FIRST 5 ROWS ONLY

-- Q6 For every month, show the month name and the Moon's closest distance from Earth? (in km). 
-- Use ROUND to show only 1 decimal point)
-- Order the months by distance and SHOW ONLY the 5 lowest months. 
SELECT TO_CHAR(datetime, 'MONTH') AS MONTH,
       ROUND(MIN(dist),1) AS "Month's Lowest Distance"
FROM jrwolf.moon24
GROUP BY TO_CHAR(datetime, 'MONTH')
ORDER BY 2
FETCH FIRST 5 ROWS ONLY;

-- Q7 For every month, show the month name and Moon's furthest distance from Earth? (in km). 
-- Use ROUND to show only 1 decimal point)
-- Order the months by distance and SHOW ONLY months where the distance is greater than 406,000 km. 
SELECT TO_CHAR(datetime, 'MONTH') AS MONTH,
       ROUND(MAX(dist),1) AS "Month's Furthest Distance"
FROM jrwolf.moon24
GROUP BY TO_CHAR(datetime, 'MONTH')
HAVING  MAX(dist) > 406000;


-- Q8 Show the day and time in 2024 when the Moon's diameter is at its greatest? Show Day, Time and Diameter. 
-- FYI: the Moon's DIAM is given in arcseconds. 
SELECT datetime, diam as "Diameter(arcseconds)"
FROM  jrwolf.moon24
ORDER BY diam DESC
FETCH FIRST 1 ROW ONLY;
-- Q9 For every month, what is the Moon's greatest diameter? (Show in degrees). 
-- Only show months where the diameter is greater than 0.55 degrees. Note: the Moon's DIAM is given in arcseconds. 
-- A conversion to degrees can be found here: https://en.wikipedia.org/wiki/Minute_and_second_of_arc
SELECT TO_CHAR(datetime, 'MONTH') AS MONTH,
       ROUND(MAX(diam)/3600,2) AS "MAXIMUM DIAMETER(deg)"
FROM jrwolf.moon24
GROUP BY TO_CHAR(datetime, 'MONTH')
HAVING MAX(diam)/3600>0.55
ORDER BY  2 DESC ;
-- Send your answers to me via email (jrwolf): Subject: Waning Crescent Moon Tonight