SET ECHO ON;
--1. Run the following query:
COL table_name FOR A10
SELECT table_name
FROM user_tables
FETCH FIRST 10 ROWS ONLY;

DESC user_tables;
select count(*)
from user_tables;

select count(*)
from all_tables;

--2. Run the following queries:
DESC SHIPS;
DESC ATTACKS;
DESC UBOATS;
--3. Show the first 5 rows in the SHIPS table.
select *
from SHIPS
fetch first 5 rows only;
--4. Show the first 5 rows in the ATTACKS table.
select *
from ATTACKS
fetch first 5 rows only;

--5. Show the first 5 rows in the UBOATS table.
select *
from UBOATS
fetch first 5 rows only;
--6. Find the number of British (BR) ships in the ships table.
select count(*)
from SHIPS
where NAT = 'BR';
--7. Find the number of U-Boat commanders with the first name of
--FRIEDRICH.
select count(*)
from UBOATS
where COMMANDER LIKE 'FRIEDRICH%';

--8. Find the names and countries of the ships attacked by U-593. Use JOIN
SELECT sh.SHIP, sh.NAT
from ATTACKS a, SHIPS sh
where sh.SID = a.SID AND
a.UBOAT = 'U-593';

--9. Redo #8. Use JOIN USING.
SELECT SHIP, NAT
from SHIPS join ATTACKS USING(sid)
where UBOAT = 'U-593';

--10. Redo #8, use a NATURAL JOIN.
SELECT SHIP, NAT
from SHIPS NATURAL JOIN ATTACKS
where UBOAT = 'U-593';