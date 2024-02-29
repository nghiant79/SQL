SET ECHO ON

-- Q1. Find the names of sailors who have reserved boat number 103 
-- Use IN
SELECT sname
from Sailors JOIN Reserves USING(sid)
where Reserves.bid IN(103);

-- Q2. Find the names of sailors who have never reserved boat number 103
-- Use NOT IN
SELECT S.sname
FROM Sailors S 
WHERE S.sid NOT IN (
   SELECT R.sid
   FROM Reserves R 
   WHERE R.bid = 103
);

-- Q3. Find the names of sailors who have reserved both a red and a green boat
-- Use INTERSECT

SELECT s.sname
FROM Reserves r JOIN Sailors s ON r.sid = s.sid
     JOIN Boats b ON r.bid = b.bid
WHERE b.color = 'red' 
INTERSECT
SELECT s.sname
FROM Reserves r JOIN Sailors s ON r.sid = s.sid
     JOIN Boats b ON r.bid = b.bid  
WHERE b.color = 'green';

-- Q4. Find the names of sailors who have reserved both a red and a green boat
-- Use at least 1 subquery
SELECT s.sname
FROM Sailors s
WHERE s.sid IN (
  SELECT r.sid
  FROM Reserves r JOIN Boats b ON b.bid = r.bid
  WHERE b.color = 'red'
)
AND s.sid IN (
  SELECT r.sid
  FROM Reserves r JOIN Boats b ON b.bid = r.bid 
  WHERE b.color = 'green'
);

-- Q5. Find the names of sailors who have reserved a red but not a green boat
-- Use minus
SELECT S.sname
FROM Reserves R1 JOIN Sailors S ON R1.sid = S.sid
     JOIN Boats B1 ON R1.bid = B1.bid
WHERE B1.color = 'red' 
MINUS
SELECT S.sname
FROM Reserves R2 JOIN Sailors S ON R2.sid = S.sid
     JOIN Boats B2 ON R2.bid = B2.bid  
WHERE B2.color = 'green';

-- Q6. Find the names of sailors who have reserved a red but not a green boat
-- Use NOT IN

SELECT s.sname
FROM Sailors s 
WHERE s.sid IN (
  SELECT r.sid 
  FROM Reserves r JOIN Boats b ON b.bid = r.bid
  WHERE b.color = 'red'
)
AND s.sid NOT IN (
  SELECT r.sid
  FROM Reserves r JOIN Boats b ON b.bid = r.bid
  WHERE b.color = 'green'  
);

-- Q7. Find the names of sailors who have reserved at least two different boats
-- Use anything you want
SELECT S.sname
FROM Sailors S
WHERE (SELECT COUNT(DISTINCT R.bid) 
       FROM Reserves R
       WHERE R.sid = S.sid) >= 2;
       

-- Q8. Find the names of sailors who have reserved ALL boats
-- Use anything you want
SELECT DISTINCT S.sname
FROM Sailors S JOIN Reserves R
  ON S.sid = R.sid
GROUP BY S.sname
HAVING COUNT(DISTINCT R.bid) = (SELECT DISTINCT COUNT(*) FROM Boats);

-- Q9. Find the names of sailors who have reserved all boats called Interlake
-- Use anything you want
                                
SELECT s.sname
FROM Sailors s
WHERE (SELECT COUNT(*) 
       FROM Boats b JOIN Reserves r  
         ON b.bid = r.bid
       WHERE b.bname = 'Interlake'
         AND r.sid = s.sid) =  
         (SELECT COUNT(*) 
          FROM Boats 
          WHERE bname = 'Interlake');
-- Q10. Find the names of all sailors who have not reserved a red boat
SELECT S.sname
FROM Sailors S
WHERE S.sid NOT IN (
  SELECT R.sid
  FROM Reserves R JOIN Boats B
    ON R.bid = B.bid
  WHERE B.color = 'red'
);

-- Q11. Find sailors whose rating is better than ANY sailor called Horataio

SELECT s1.sname
FROM Sailors s1
WHERE s1.rating > ANY (
  SELECT s2.rating
  FROM Sailors s2 
  WHERE s2.sname = 'Horataio'
);

-- Q12. Find sailors whose rating is better than ALL sailors called Horataio
SELECT S.sname, S.rating
FROM Sailors S
WHERE S.rating > ALL (
  SELECT S1.rating
  FROM Sailors S1
  WHERE S1.sname = 'Horataio'
);


-- Q13. Find the sailors with the highest rating
SELECT s.sname, s.rating
FROM Sailors s
WHERE s.rating = (SELECT MAX(rating) FROM sailors);

-- Q14. Find the names of sailors who are older than the oldest sailor with a rating of 10
SELECT S.sname
FROM Sailors S
WHERE S.age > (
  SELECT MAX(S2.age)
  FROM Sailors S2
  WHERE S2.rating = 10
);

-- Q15. Find the age of the youngest sailor for each rating level
SELECT rating, MIN(age) AS youngest_age
FROM Sailors
GROUP BY rating;


-- Q16. Find the average age of sailors for each rating level that has at least two sailors
SELECT rating, AVG(age) AS average_age
FROM Sailors
GROUP BY rating
HAVING COUNT(sid) >= 2;


-- Q17. Find those ratings for which the average age of sailors in the minimum over all ratings

SELECT rating, AVG(age) AS avg_age
FROM Sailors 
GROUP BY rating
HAVING AVG(age) = (
  SELECT MIN(AVG(age))
  FROM Sailors
  GROUP BY rating
);

-- Q18. Find the sailors with top 5 highest ratings
SELECT sname, rating
from Sailors
ORDER BY rating DESC
FETCH FIRST 5 ROWS ONLY;

-- Q19. Find the sailors who have reserved the same boats as DUSTIN
SELECT DISTINCT S1.sname
FROM Sailors S1 JOIN Reserves R1
  ON S1.sid = R1.sid
JOIN Reserves R2
  ON R2.bid = R1.bid AND R2.sid = (SELECT sid FROM Sailors WHERE sname='Dustin')
WHERE S1.sname != 'Dustin';

-- Q20. Find the sailors who have reserved the same boats on the same days as DUSTIN

SELECT DISTINCT S1.sname
FROM Sailors S1 JOIN Reserves R1
  ON S1.sid = R1.sid
JOIN Reserves R2
  ON R2.bid = R1.bid AND R2.day = R1.day AND R2.sid = (SELECT sid FROM Sailors WHERE sname='Dustin')
WHERE S1.sname != 'Dustin';
