--1)
CREATE TABLE EMP (
    E_ID NUMBER(3) PRIMARY KEY,
    FNAME VARCHAR2(30) NOT NULL,
    LNAME VARCHAR2(30) NOT NULL,
    HIRE_DATE DATE NOT NULL,
    JOB_ID VARCHAR2(20) NOT NULL,
    SAL NUMBER(8,2) NOT NULL,
    DEPT_ID NUMBER(3) CHECK (DEPT_ID >= 10)
);

INSERT INTO EMP VALUES (198, 'Donald', 'Connell', TO_DATE('21-Jun-99','DD-Mon-RR'), 'SH_CLERK', 2600, 50);
INSERT INTO EMP VALUES (199, 'Douglas', 'Grant', TO_DATE('13-Jan-98','DD-Mon-RR'), 'SH_CLERK', 3000, 50);
INSERT INTO EMP VALUES (200, 'Jennifer', 'Whalen', TO_DATE('17-Sep-87','DD-Mon-RR'), 'AD_ASST', 4400, 10);
INSERT INTO EMP VALUES (201, 'Michael', 'Hartstein', TO_DATE('19-Jan-99','DD-Mon-RR'), 'IT_PROG', 6000, 20);
INSERT INTO EMP VALUES (202, 'Pat', 'Fay', TO_DATE('25-Oct-89','DD-Mon-RR'), 'AC_MGR', 6500, 20);
INSERT INTO EMP VALUES (203, 'Susan', 'Mavris', TO_DATE('26-Nov-76','DD-Mon-RR'), 'AD_VP', 7500, 40);
INSERT INTO EMP VALUES (204, 'Hermann', 'Baer', TO_DATE('23-Aug-95','DD-Mon-RR'), 'AD_PRES', 9500, 90);
INSERT INTO EMP VALUES (205, 'Shelley', 'Higgins', TO_DATE('24-Feb-98','DD-Mon-RR'), 'AC_MGR', 2300, 60);
INSERT INTO EMP VALUES (206, 'William', 'Gitz', TO_DATE('12-Mar-01','DD-Mon-RR'), 'IT_PROG', 5000, 60);
INSERT INTO EMP VALUES (100, 'Steven', 'King', TO_DATE('15-Jun-02','DD-Mon-RR'), 'AD_ASST', 8956, 100);
INSERT INTO EMP VALUES (101, 'Neena', 'Kochar', TO_DATE('10-Jul-03','DD-Mon-RR'), 'SH_CLERK', 3400, 30);
COMMIT;

--2)
SELECT FNAME AS "First Name" FROM EMP
ORDER BY FNAME ASC;

--3)
SELECT FNAME AS "First Name" FROM EMP
ORDER BY FNAME DESC;

--4)
SELECT HIRE_DATE FROM EMP
ORDER BY HIRE_DATE ASC;

--5)
SELECT * FROM EMP
WHERE FNAME LIKE 'J%' OR FNAME LIKE 'M%'
ORDER BY LNAME ASC;


--6)
SELECT
    MAX(SAL) AS "Max",
    MIN(SAL) AS "Min",
    AVG(SAL) AS "Avg",
    SUM(SAL) AS "Sum"
FROM EMP;


--7)
SELECT
    JOB_ID,
    MAX(SAL) AS "Max",
    MIN(SAL) AS "Min",
    AVG(SAL) AS "Avg",
    SUM(SAL) AS "Sum"
FROM EMP
GROUP BY JOB_ID;


--8)
SELECT
    JOB_ID,
    COUNT(*) AS "Number of Employees"
FROM EMP
GROUP BY JOB_ID;


--9)
SELECT COUNT(*) AS "Number of Managers"
FROM EMP WHERE JOB_ID LIKE '%MGR';


--10)
SELECT MAX(SAL) - MIN(SAL) AS "Salary Difference"
FROM EMP;


--11)
SELECT
    MAX(SAL) AS "Maximum Salary",
    AVG(SAL) AS "Average Salary"
FROM EMP WHERE JOB_ID LIKE '%PROG';


--12)
SELECT
    MIN(FNAME) AS "First Employee",
    MAX(FNAME) AS "Last Employee"
FROM EMP;

--13)
SELECT
    MIN(HIRE_DATE) AS "First Hire_Date",
    MAX(HIRE_DATE) AS "Last Hire_Date"
FROM EMP;


--14)
SELECT
    MAX(SAL) AS "Maximum Salary",
    AVG(SAL) AS "Average Salary"
FROM EMP WHERE JOB_ID LIKE '%CLERK';


--15)
SELECT
    DEPT_ID,
    MIN(SAL) AS "Minimum Salary"
FROM EMP
GROUP BY DEPT_ID;


--16)
SELECT
    DEPT_ID,
    MIN(SAL) AS "Minimum Salary"
FROM EMP
GROUP BY DEPT_ID
HAVING MIN(SAL) > 3000
ORDER BY MIN(SAL) DESC;


--17)
SELECT
    FNAME || ' whose designation is ' ||
    JOB_ID || ' gets ' ||
    SAL || ' but wants to earn ' ||
    (3 * SAL) AS "Employee Details"
FROM EMP;


--18)
SELECT
    E_ID || ', ' ||
    FNAME || ', ' ||
    LNAME || ', ' ||
    TO_CHAR(HIRE_DATE, 'DD-Mon-RR') || ', ' ||
    JOB_ID || ', ' ||
    SAL || ', ' ||
    DEPT_ID AS "Employee Details"
FROM EMP;


--19)
SELECT SYSDATE AS TODAY
FROM DUAL;


--20)
SELECT
    E_ID,
    TO_CHAR(HIRE_DATE, 'DD') AS DAY,
    TO_CHAR(HIRE_DATE, 'YYYY') AS YEAR
FROM EMP;


--21)
SELECT
    FNAME,
    TO_CHAR(HIRE_DATE, 'DD-MONTH-YY') AS HIRE_DATE
FROM EMP;


--22)
SELECT
    E_ID,
    TO_CHAR(HIRE_DATE, 'MONTH') AS MONTH
FROM EMP;


--23)
SELECT
    FNAME,
    E_ID,
    TO_CHAR(HIRE_DATE, 'DD-MON-YYYY') AS HIRE_DATE
FROM EMP;


--24)
SELECT
    FNAME,
    E_ID,
    TO_CHAR(HIRE_DATE, 'MONTH-DD-YYYY') AS HIRE_DATE
FROM EMP;


--25)
SELECT
    TO_CHAR(SYSDATE, 'YEAR') AS "SYSTEM YEAR"
FROM DUAL;


--26)
SELECT
    SYSDATE AS "TODAY'S DATE",
    SYSDATE + 15 AS "15 DAYS AFTER",
    SYSDATE - 15 AS "15 DAYS BEFORE"
FROM DUAL;


--27)
ALTER TABLE EMP
ADD CONSTRAINT CHK_DEPT
CHECK (DEPT_ID >= 10);

ALTER TABLE EMP
ADD CONSTRAINT PK_EMP
PRIMARY KEY (E_ID);


--28)
ALTER TABLE EMP
DROP CONSTRAINT CHK_DEPT;


--29)
ALTER TABLE EMP
DROP PRIMARY KEY;


--30)
DROP TABLE EMP;




