SET ECHO ON;

DESC jrwolf.sharkattacks;
--1 Find the AGE, YEAR, and SEX of all shark attacks in the USA.
--Order the results from oldest to newest by year.
--(Make sure to use the correct case for 'USA')
select AGE,YEAR,SEX
from jrwolf.sharkattacks
where COUNTRY = 'USA'
order by YEAR
fetch first 10 rows only;

--2 Find the AGE, YEAR, and SEX of all shark attacks where the victim was Surfing (Make sure to use the correct case for 'Surfing') in South Africa (country = 'SOUTH AFRICA'). Order the results from newest to oldest by year.
select AGE,YEAR, SEX
from jrwolf.sharkattacks
where COUNTRY = 'SOUTH AFRICA' and ACTIVITY = 'Surfing'
order by YEAR DESC
fetch first 10 rows only;

--3Find all fields for females (SEX = 'F') attacked while Snorkeling in AUSTRALIA.
select *
from jrwolf.sharkattacks
where SEX = 'F' and ACTIVITY = 'Snorkeling' and COUNTRY = 'AUSTRALIA';

--4Find the AGE, YEAR, AND ACTIVITY of the 3 OLDEST MEN fatally attacked (FATAL = 'Y) in the USA.
select AGE, YEAR, ACTIVITY
from jrwolf.sharkattacks
where SEX = 'M' AND FATAL = 'Y'
order by AGE DESC
fetch first 3 rows only;

--5Find the COUNTRY and AGE of the 8 youngest people attacked by a shark.
select COUNTRY, AGE
from jrwolf.sharkattacks
order by age
fetch first 8 rows only;