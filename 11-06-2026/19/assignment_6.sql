Create Database ass06;
use ass06;

#Q1
create table emp(
    e_id int primary key,
    fname varchar(20) not null,
    lname varchar(20) not null,
    hire_date date not null,
    job_id varchar(15) not null,
    sal int not null,
    dept_id int check(dept_id >= 10)
);
insert into emp values
(198, 'Donald', 'Connell', '1999-06-21', 'SH_CLERK', 2600, 50),
(199, 'Douglas', 'Grant', '1998-01-13', 'SH_CLERK', 3000, 50),
(200, 'Jennifer', 'Whalen', '1987-09-17', 'AD_ASST', 4400, 10),
(201, 'Michael', 'Hartstein', '1999-01-19', 'IT_PROG', 6000, 20),
(202, 'Pat', 'Fay', '1989-10-25', 'AC_MGR', 6500, 20),
(203, 'Susan', 'Mavris', '1976-11-26', 'AD_VP', 7500, 40),
(204, 'Hermann', 'Baer', '1995-08-23', 'AD_PRES', 9500, 90),
(205, 'Shelley', 'Higgins', '1998-02-24', 'AC_MGR', 2300, 60),
(206, 'William', 'Gitz', '2001-03-12', 'IT_PROG', 5000, 60),
(100, 'Steven', 'King', '2002-06-15', 'AD_ASST', 8956, 100),
(101, 'Neena', 'Kochar', '2003-07-10', 'SH_CLERK', 3400, 30);

select * from emp;

#Q2
SELECT FIRST_NAME AS Employee_Name
FROM EMP
ORDER BY FIRST_NAME ASC;

#Q3
SELECT FIRST_NAME AS Employee_Name
FROM EMP
ORDER BY FIRST_NAME DESC;

#Q4
SELECT HIRE_DATE
FROM EMP
ORDER BY HIRE_DATE ASC;

#Q5
SELECT *
FROM EMP
WHERE FIRST_NAME LIKE 'J%'
   OR FIRST_NAME LIKE 'M%'
ORDER BY LAST_NAME;

#Q6
SELECT
MAX(SAL) AS Max,
MIN(SAL) AS Min,
AVG(SAL) AS Avg,
SUM(SAL) AS Sum
FROM EMP;

#Q7
SELECT
JOB_ID,
MAX(SAL),
MIN(SAL),
AVG(SAL),
SUM(SAL)
FROM EMP
GROUP BY JOB_ID;

#Q8
SELECT JOB_ID, COUNT(*) AS Employee_Count
FROM EMP
GROUP BY JOB_ID;

#Q9
SELECT COUNT(DISTINCT JOB_ID) AS Manager_Count
FROM EMP
WHERE JOB_ID LIKE '%MGR%'
   OR JOB_ID LIKE '%MAN%';

#Q10
SELECT MAX(SAL) - MIN(SAL) AS Salary_Difference
FROM EMP;

#Q11
SELECT MAX(SAL), AVG(SAL)
FROM EMP
WHERE JOB_ID LIKE '%PROG%';

#Q12
SELECT
MIN(FIRST_NAME) AS First_Name,
MAX(FIRST_NAME) AS Last_Name
FROM EMP;

#Q13
SELECT
MIN(HIRE_DATE) AS `First Hire_Date`,
MAX(HIRE_DATE) AS `Last Hire_Date`
FROM EMP;

#Q14
SELECT MAX(SAL), AVG(SAL)
FROM EMP
WHERE JOB_ID LIKE '%CLERK%';

#Q15
SELECT DEPT_ID, MIN(SAL) AS Minimum_Salary
FROM EMP
GROUP BY DEPT_ID;

#Q16
SELECT DEPT_ID, MIN(SAL) AS Minimum_Salary
FROM EMP
GROUP BY DEPT_ID
HAVING MIN(SAL) > 3000
ORDER BY Minimum_Salary DESC;

#Q17
SELECT CONCAT(
FIRST_NAME, ' whose designation is ',
JOB_ID, ' gets ',
SAL, ' but wants to earn ',
3 * SAL
) AS Employee_Details
FROM EMP;

#Q18
SELECT CONCAT(
EMP_ID, ', ',
FIRST_NAME, ', ',
LAST_NAME, ', ',
DATE_FORMAT(HIRE_DATE, '%d-%b-%y'), ', ',
JOB_ID, ', ',
SAL, ', ',
DEPT_ID
) AS Employee_Details
FROM EMP;

#Q19
SELECT CURDATE() AS TODAY;

#Q20
SELECT
EMP_ID,
DAY(HIRE_DATE) AS Hire_Day,
YEAR(HIRE_DATE) AS Hire_Year
FROM EMP;

#Q21
SELECT
FIRST_NAME,
DATE_FORMAT(HIRE_DATE, '%d-%M-%y') AS Hire_Date
FROM EMP;

#Q22
SELECT
EMP_ID,
MONTHNAME(HIRE_DATE) AS Hire_Month
FROM EMP;

#Q23
SELECT
FIRST_NAME,
EMP_ID,
DATE_FORMAT(HIRE_DATE, '%d-%b-%Y') AS Hire_Date
FROM EMP;

#Q24
SELECT
FIRST_NAME,
EMP_ID,
DATE_FORMAT(HIRE_DATE, '%M-%d-%Y') AS Hire_Date
FROM EMP;

#Q25
SELECT ELT(
    YEAR(CURDATE())-2025,
    'Two Thousand Twenty Five',
    'Two Thousand Twenty Six',
    'Two Thousand Twenty Seven'
) AS System_Year;

#Q26
SELECT
CURDATE() AS Today,
DATE_ADD(CURDATE(), INTERVAL 15 DAY) AS After_15_Days,
DATE_SUB(CURDATE(), INTERVAL 15 DAY) AS Before_15_Days;

#Q27
ALTER TABLE EMP
ADD CONSTRAINT chk_dept
CHECK (DEPT_ID >= 10);

#Q28
ALTER TABLE EMP
DROP CHECK chk_dept;

#Q29
ALTER TABLE EMP
DROP PRIMARY KEY;

#Q30
DROP TABLE EMP;