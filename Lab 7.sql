
SET ECHO ON;

--1
CREATE TABLE ch10_suppliers
(
SUBJECT_ID NUMBER NOT NULL  UNIQUE,
SUBJECT_NAME VARCHAR2(30) UNIQUE NOT NULL ,
DESCRIPTION VARCHAR2(4000)
)


CREATE TABLE ch10_subjects
(
SUPPLIER_ID  NUMBER(10) UNIQUE NOT NULL,
SUPPLIER_NAME  VARCHAR2(50) NOT NULL,
ADDRESS VARCHAR2(50),
CITY VARCHAR2(50),
STATE VARCHAR2(25),
ZIP_CODE VARCHAR2(10)
);

--b
DESC ch10_suppliers;
DESC ch10_subjects;

--2
column table_name format A25
column comments format A55 WORD_WRAPPED
SELECT *
FROM DICTIONARY
WHERE TABLE_NAME LIKE '%USER_TAB%';


--b
SELECT *
FROM DICTIONARY
WHERE TABLE_NAME LIKE '%CONSTRAINT%';

--C
SELECT *
FROM DICTIONARY
WHERE TABLE_NAME LIKE '%USER_IND%';

--3
--a
column table_name format A15
column owner format A15
column CONSTRAINT_NAME format A10
column CONSTRAINT_TYPE format A15
column LAST_CHANGE format A20
column SEARCH_CONDITION format A15
SELECT TABLE_NAME, owner, CONSTRAINT_NAME, CONSTRAINT_TYPE, LAST_CHANGE, SEARCH_CONDITION
FROM ALL_CONSTRAINTS
WHERE table_name LIKE 'CH10_%';

--b
column table_name format A15
column column_name format A20
column DATA_TYPE format A15
SELECT TABLE_NAME, column_name, DATA_TYPE
FROM USER_TAB_COLS
WHERE table_name LIKE 'CH10_%';

--c
column index_name format A15
column table_name format A15
column column_name format A15
column descend format A15
SELECT index_name, table_name, column_name, descend
FROM user_ind_columns
where table_name like 'CH10%';
