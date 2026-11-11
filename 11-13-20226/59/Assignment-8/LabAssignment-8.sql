--CREATE TABLE Sports_Stud (
--    Roll NUMBER(3) PRIMARY KEY,
--    Name VARCHAR2(30) UNIQUE,
--    Dept VARCHAR2(5),
--    Sports_Fee NUMBER(6),
--    CONSTRAINT chk_sdept CHECK (Dept IN ('IT','CS')),
--    CONSTRAINT chk_sfee CHECK (Sports_Fee >= 1000)
--);
--INSERT INTO Sports_Stud VALUES (1,'Aman','IT',1200);
--INSERT INTO Sports_Stud VALUES (7,'Anurag','CS',1500);
--INSERT INTO Sports_Stud VALUES (2,'Binay','IT',1000);
--INSERT INTO Sports_Stud VALUES (8,'Chiranjit','CS',1700);

--CREATE TABLE Cultural_Stud (
--    Roll NUMBER(3) PRIMARY KEY,
--    Name VARCHAR2(30) UNIQUE,
--    Dept VARCHAR2(5),
--    Cul_Fees NUMBER(6),
--    CONSTRAINT chk_cdept CHECK (Dept IN ('IT','CS')),
--    CONSTRAINT chk_cfee CHECK (Cul_Fees >= 600)
--);
--INSERT INTO Cultural_Stud VALUES (1,'Aman','IT',700);
--INSERT INTO Cultural_Stud VALUES (2,'Binay','IT',700);
--INSERT INTO Cultural_Stud VALUES (3,'Bipul','CS',600);
--INSERT INTO Cultural_Stud VALUES (4,'Joy','CS',600);
--INSERT INTO Cultural_Stud VALUES (5,'Surojit','IT',700);
--INSERT INTO Cultural_Stud VALUES (6,'Wasim','CS',600);

--SELECT Name FROM Sports_Stud
--UNION
--SELECT Name FROM Cultural_Stud;
--SELECT Name FROM Sports_Stud
--UNION ALL
--SELECT Name FROM Cultural_Stud;

--SELECT Name FROM Sports_Stud
--INTERSECT
--SELECT Name FROM Cultural_Stud;

--SELECT Name FROM Sports_Stud
--MINUS
--SELECT Name FROM Cultural_Stud;

--SELECT Name FROM Cultural_Stud
--MINUS
--SELECT Name FROM Sports_Stud;

--SELECT S.Roll, S.Sports_Fee, C.Cul_Fees
--FROM Sports_Stud S
--JOIN Cultural_Stud C
--ON S.Roll = C.Roll;
--
--
--ALTER TABLE Sports_Stud
--ADD Birthday DATE;
--
--ALTER TABLE Cultural_Stud
--ADD Birthday DATE;



--UPDATE Sports_Stud
--SET Birthday = TO_DATE('15-01-2004','DD-MM-YYYY')
--WHERE Roll = 1;
--
--UPDATE Sports_Stud
--SET Birthday = TO_DATE('20-03-2004','DD-MM-YYYY')
--WHERE Roll = 7;
--
--UPDATE Sports_Stud
--SET Birthday = TO_DATE('10-05-2004','DD-MM-YYYY')
--WHERE Roll = 2;
--
--UPDATE Sports_Stud
--SET Birthday = TO_DATE('25-08-2004','DD-MM-YYYY')
--WHERE Roll = 8;
--
--UPDATE Cultural_Stud
--SET Birthday = TO_DATE('15-01-2004','DD-MM-YYYY')
--WHERE Roll = 1;
--
--UPDATE Cultural_Stud
--SET Birthday = TO_DATE('10-05-2004','DD-MM-YYYY')
--WHERE Roll = 2;
--
--UPDATE Cultural_Stud
--SET Birthday = TO_DATE('12-02-2004','DD-MM-YYYY')
--WHERE Roll = 3;
--
--UPDATE Cultural_Stud
--SET Birthday = TO_DATE('18-04-2004','DD-MM-YYYY')
--WHERE Roll = 4;
--
--UPDATE Cultural_Stud
--SET Birthday = TO_DATE('22-06-2004','DD-MM-YYYY')
--WHERE Roll = 5;
--
--UPDATE Cultural_Stud
--SET Birthday = TO_DATE('30-09-2004','DD-MM-YYYY')
--WHERE Roll = 6;

--SELECT Name,
--       TRUNC(MONTHS_BETWEEN(SYSDATE, Birthday)/12) AS Age,
--       TO_CHAR(Birthday,'MONTH') AS Birth_Month
--FROM (
--    SELECT Name, Birthday FROM Sports_Stud
--    UNION
--    SELECT Name, Birthday FROM Cultural_Stud
--)
--ORDER BY Name;


--SELECT LAST_DAY(Birthday) AS Last_Day
--FROM Sports_Stud
--
--UNION
--
--SELECT LAST_DAY(Birthday) AS Last_Day
--FROM Cultural_Stud
--ORDER BY Last_Day;


--SELECT Name || ' who studies in ' ||
--Dept || ' dept pays Rs' ||
--Sports_Fee || ' for sports.' AS DETAILS
--FROM Sports_Stud;


--SELECT Roll, Name, Dept, Sports_Fee AS Fee
--FROM Sports_Stud
--WHERE Dept = 'IT'
--
--UNION ALL
--
--SELECT Roll, Name, Dept, Cul_Fees AS Fee
--FROM Cultural_Stud
--WHERE Dept = 'IT';


--SELECT SUM(Sports_Fee) AS Total_Sports_Income
--FROM Sports_Stud;


--SELECT SUM(Cul_Fees) AS Total_Cultural_Income
--FROM Cultural_Stud;

--SELECT Name FROM Sports_Stud
--UNION
--SELECT Name FROM Cultural_Stud
--ORDER BY Name DESC;

--ALTER TABLE Sports_Stud
--DROP CONSTRAINT chk_sdept;
--
--ALTER TABLE Sports_Stud
--DROP CONSTRAINT chk_sfee;
--
--ALTER TABLE Cultural_Stud
--DROP CONSTRAINT chk_cdept;
--
--ALTER TABLE Cultural_Stud
--DROP CONSTRAINT chk_cfee;


SELECT MAX(Sports_Fee) AS Maximum_Fee,
       MIN(Sports_Fee) AS Minimum_Fee,
       AVG(Sports_Fee) AS Average_Fee
FROM Sports_Stud;