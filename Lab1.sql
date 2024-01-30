SQL> SET ECHO ON;
SQL> -- 3rd answer the following
SQL> -- Submit both the SQL and the results IN PLAIN TEXT via Canvas. 
SQL> 
SQL> 
SQL> -- Questions for Lab #1 (all of these can be done without a join)
SQL> --1. Find all the ship names in the ships table
SQL> SELECT ship
  2  FROM ships;

SHIP         
-------------
SS Fingal
AHS Centaur
HNLMS K XVI
USAT Liberty
USS Seadragon

SQL> 
SQL> --2. Find the number of ships in the ships table
SQL> SELECT COUNT(ship)
  2  FROM ships;

COUNT(SHIP)
-----------
          5

SQL> --3. Find the ship names and the number of the sub that sank them
SQL> SELECT ship, sub_id
  2  FROM ships
  3  WHERE sub_id IS NOT NULL;

SHIP          SUB_I
------------- -----
SS Fingal     I-180
AHS Centaur   I-177
HNLMS K XVI   I-166
USAT Liberty  I-166

SQL> --4. Find the number of ships sank by sub I-166
SQL> SELECT COUNT(ship) "Sank by I-166"
  2  FROM ships
  3  WHERE sub_id = 'I-166';

Sank by I-166
-------------
            2

SQL> 
SQL> --5. Find the ship names and the number of the sub that sank them -- ONLY for US ships
SQL> SELECT ship, sub_id
  2  FROM ships
  3  WHERE country = 'US' AND sub_id IS NOT NULL;

SHIP          SUB_I
------------- -----
USAT Liberty  I-166

SQL> 
SQL> --6. Find the number of US ships NOT attacked/sank in the ships table
SQL> SELECT COUNT(ship)
  2  FROM ships
  3  WHERE sub_id IS NULL and country = 'US';

COUNT(SHIP)
-----------
          1