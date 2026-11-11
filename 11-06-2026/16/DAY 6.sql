Create Database Ass_7;
Use Ass_7;

CREATE TABLE Employee_Details (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    job_id VARCHAR(20),
    salary DECIMAL(10,2),
    commission_pct DECIMAL(5,2),
    department_id INT,
    hire_date DATE
);

INSERT INTO Employee_Details VALUES
(100, 'Steven', 'King', 'AD_PRES', 24000, NULL, 90, '1987-06-17'),
(101, 'Neena', 'Kochhar', 'AD_VP', 17000, NULL, 90, '1989-09-21'),
(102, 'Lex', 'De Haan', 'AD_VP', 17000, NULL, 90, '1993-01-13'),
(103, 'Alexander', 'Hunold', 'IT_PROG', 9000, NULL, 60, '1990-01-03'),
(104, 'Bruce', 'Ernst', 'IT_PROG', 6000, NULL, 60, '1991-05-21'),
(105, 'David', 'Austin', 'IT_PROG', 4800, NULL, 60, '1997-06-25'),
(106, 'Valli', 'Pataballa', 'IT_PROG', 4800, NULL, 60, '1998-02-05'),
(107, 'Diana', 'Lorentz', 'IT_PROG', 4200, NULL, 60, '1999-02-07'),
(108, 'Nancy', 'Greenberg', 'FI_MGR', 12000, NULL, 100, '1994-08-17'),
(109, 'Daniel', 'Faviet', 'FI_ACCOUNT', 9000, NULL, 100, '1994-08-16'),
(110, 'John', 'Chen', 'FI_ACCOUNT', 8200, NULL, 100, '1997-09-28'),
(111, 'Ismael', 'Sciarra', 'FI_ACCOUNT', 7700, NULL, 100, '1997-09-30'),
(112, 'Jose', 'Manuel', 'SA_REP', 11000, 0.20, 80, '1995-10-01'),
(113, 'Peter', 'Vargas', 'SA_REP', 9000, 0.15, 80, '1998-07-09'),
(114, 'Lily', 'Smith', 'SA_REP', 7500, 0.10, 80, '1999-03-15'),
(115, 'Adam', 'Taylor', 'SA_REP', 8000, 0.12, 80, '2000-04-20'),
(116, 'Sarah', 'Bell', 'ST_CLERK', 4000, NULL, 50, '1996-02-04'),
(117, 'Michael', 'Hall', 'ST_CLERK', 3500, NULL, 50, '1997-08-15'),
(118, 'Kevin', 'Mourgos', 'ST_MAN', 5800, NULL, 50, '1998-11-16'),
(119, 'Julia', 'Nayer', 'ST_CLERK', 3200, NULL, 50, '1999-07-16'),
(120, 'Donald', 'OConnell', 'SH_CLERK', 2600, NULL, 50, '2000-06-21'),
(121, 'Jennifer', 'Whalen', 'AD_ASST', 4400, NULL, 10, '1987-09-17'),
(122, 'Shelley', 'Higgins', 'AC_MGR', 12000, NULL, 110, '1994-06-07'),
(123, 'William', 'Gietz', 'AC_ACCOUNT', 8300, NULL, 110, '1995-06-07'),
(124, 'Pat', 'Fay', 'MK_REP', 6000, NULL, 20, '1997-08-17');

Select * from Employee_details;

#Q1
SELECT LOWER(first_name) AS First_Name
FROM Employee_Details
WHERE department_id IN (20, 50, 80);

#Q2
SELECT UPPER(last_name) AS Last_Name
FROM Employee_Details
WHERE department_id IN (10, 110, 60);

#Q3
SELECT CONCAT(
    UPPER(LEFT(SUBSTRING_INDEX(job_id, '_', 1), 1)),
    LOWER(SUBSTRING(SUBSTRING_INDEX(job_id, '_', 1), 2)),
    '_',
    UPPER(LEFT(SUBSTRING_INDEX(job_id, '_', -1), 1)),
    LOWER(SUBSTRING(SUBSTRING_INDEX(job_id, '_', -1), 2))
) AS Job_ID
FROM Employee_Details;

#Q4
SELECT CONCAT(first_name, ' ', last_name) AS Employee_Name
FROM Employee_Details;

#Q5
SELECT last_name, LENGTH(last_name) AS Name_Length
FROM Employee_Details
WHERE commission_pct IS NOT NULL;

#Q6
SELECT first_name, INSTR(first_name, 'a') AS Position
FROM Employee_Details;

#Q7
SELECT
    CONCAT(first_name, ' ', last_name) AS Employee_Name,
    LENGTH(last_name) AS Name_Length,
    INSTR(last_name, 'a') AS Position
FROM Employee_Details
WHERE job_id LIKE '%CLERK%';

#Q8
SELECT LPAD(salary, 10, '$') AS Salary
FROM Employee_Details;

SELECT RPAD(salary, 10, '$') AS Salary
FROM Employee_Details;

#Q9
SELECT TRIM('e' FROM first_name) AS Trimmed
FROM Employee_Details
WHERE first_name LIKE '%e%';

#Q10
SELECT department_id, salary, hire_date
FROM Employee_Details
WHERE CHAR_LENGTH(first_name) = 6;

#Q11
SELECT job_id, INSTR(first_name, 'e') AS Position
FROM Employee_Details
WHERE first_name LIKE '%e%';

#Q12
SELECT last_name
FROM Employee_Details
WHERE SUBSTRING(job_id, 4, 3) = 'REP';

#Q13
SELECT salary, MOD(salary, 3000) AS Remainder
FROM Employee_Details
WHERE job_id = 'SA_REP';

#Q14
SELECT CONCAT('$', FORMAT(salary, 2)) AS Salary
FROM Employee_Details;

#Q15
SELECT CONCAT('$', CAST(salary AS UNSIGNED)) AS Salary
FROM Employee_Details
WHERE department_id IN (60, 90, 110);

#Q16
SELECT
    last_name,
    IFNULL(CAST(commission_pct AS CHAR), 'No Commission') AS COMM
FROM Employee_Details;

#Q17
SELECT
    last_name,
    ROUND(DATEDIFF(CURDATE(), hire_date)) AS Days_Elapsed
FROM Employee_Details;

#Q18
SELECT
    last_name,
    DATEDIFF(CURDATE(), hire_date) / 7 AS Weeks_Elapsed
FROM Employee_Details;

#Q19
SELECT
    last_name,
    ROUND(DATEDIFF(CURDATE(), hire_date) / 365) AS Years_Elapsed
FROM Employee_Details;

#Q20
SELECT
    CONCAT(first_name, ' ', last_name) AS Employee_Name,
    TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) AS MONTHS_WORKED
FROM Employee_Details;

#Q21
SELECT
    CONCAT(first_name, ' ', last_name) AS Employee_Name,
    LAST_DAY(hire_date) AS Last_Day
FROM Employee_Details;

#Q22
SELECT
    CONCAT(first_name, ' ', last_name) AS Employee_Name,
    CASE YEAR(hire_date)
        WHEN 1987 THEN 'Nineteen Eighty Seven'
        WHEN 1989 THEN 'Nineteen Eighty Nine'
        WHEN 1990 THEN 'Nineteen Ninety'
        WHEN 1991 THEN 'Nineteen Ninety One'
        WHEN 1993 THEN 'Nineteen Ninety Three'
        WHEN 1994 THEN 'Nineteen Ninety Four'
        WHEN 1995 THEN 'Nineteen Ninety Five'
        WHEN 1996 THEN 'Nineteen Ninety Six'
        WHEN 1997 THEN 'Nineteen Ninety Seven'
        WHEN 1998 THEN 'Nineteen Ninety Eight'
        WHEN 1999 THEN 'Nineteen Ninety Nine'
        WHEN 2000 THEN 'Two Thousand'
    END AS Hiring_Year
FROM Employee_Details;

#Q23
SELECT DATE_ADD(CURDATE(), INTERVAL 5 MONTH)
AS `FUTURE DATE`;

#Q24
SELECT
    CONCAT(first_name, ' ', last_name) AS Employee_Name,
    DAYNAME(hire_date) AS Joining_Day,
    DATE_FORMAT(hire_date, '%d-%m-%Y') AS Joining_Date
FROM Employee_Details;

#Q25
SELECT
    CONCAT(first_name, ' ', last_name) AS Employee_Name,
    (salary * 12) + IFNULL(commission_pct, 0) AS Annual_Salary,
    ROUND(
        (salary * 12) + IFNULL(commission_pct, 0), 2
    ) AS Rounded_Annual_Salary
FROM Employee_Details;
