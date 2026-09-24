DBMS LAB ASSIGNMENT – 3
Oracle SQL*Plus – Questions, Commands and Expected Outputs

1. Create table EMPLOYEE with the following details.
SQL*Plus Command:
CREATE TABLE EMPLOYEE
(
    EMPLOYEE_ID    NUMBER(6),
    LAST_NAME      VARCHAR2(25),
    JOB_ID         VARCHAR2(10),
    SALARY         NUMBER(8,2),
    COMM_PCT       NUMBER(4,2),
    MGR_ID         NUMBER(6),
    DEPARTMENT_ID  NUMBER(4)
);
Expected Output:
Table created.


2. Insert the given employee data into the EMPLOYEE table.
SQL*Plus Command:
INSERT INTO EMPLOYEE VALUES (198, 'Connell', 'SH_CLERK', 2600, 2.5, 124, 50);
INSERT INTO EMPLOYEE VALUES (199, 'Grant', 'SH_CLERK', 2600, 2.2, 124, 50);
INSERT INTO EMPLOYEE VALUES (200, 'Whalen', 'AD_ASST', 4400, 1.3, 101, 10);
INSERT INTO EMPLOYEE VALUES (201, 'Hartstein', 'IT_PROG', 6000, NULL, 100, 20);
INSERT INTO EMPLOYEE VALUES (202, 'Fay', 'AC_MGR', 6500, NULL, 210, 20);
INSERT INTO EMPLOYEE VALUES (203, 'Mavris', 'AD_VP', 7500, NULL, 101, 40);
INSERT INTO EMPLOYEE VALUES (204, 'Baer', 'AD_PRES', 3500, 1.5, 101, 90);
INSERT INTO EMPLOYEE VALUES (205, 'Higgins', 'AC_MGR', 2300, NULL, 101, 60);
INSERT INTO EMPLOYEE VALUES (206, 'Gitz', 'IT_PROG', 5000, NULL, 103, 60);
INSERT INTO EMPLOYEE VALUES (100, 'King', 'AD_ASST', 8956, 0.3, 108, 100);
INSERT INTO EMPLOYEE VALUES (101, 'Kochar', 'SH_CLERK', 3400, 1.3, 118, 30);
COMMIT;
Expected Output:
1 row created.
1 row created.
1 row created.
1 row created.
1 row created.
1 row created.
1 row created.
1 row created.
1 row created.
1 row created.
1 row created.
Commit complete.


3. Display LAST_NAME, JOB_ID and EMPLOYEE_ID for each employee, with EMPLOYEE_ID appearing first.
SQL*Plus Command:
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID
FROM EMPLOYEE;
Expected Output:
EMPLOYEE_ID LAST_NAME                  JOB_ID
----------- ------------------------- ----------
        198 Connell                   SH_CLERK
        199 Grant                     SH_CLERK
        200 Whalen                    AD_ASST
        201 Hartstein                 IT_PROG
        202 Fay                       AC_MGR
        203 Mavris                    AD_VP
        204 Baer                      AD_PRES
        205 Higgins                   AC_MGR
        206 Gitz                      IT_PROG
        100 King                      AD_ASST
        101 Kochar                    SH_CLERK

11 rows selected.


4. Display the details of all employees of department 60.
SQL*Plus Command:
SELECT *
FROM EMPLOYEE
WHERE DEPARTMENT_ID = 60;
Expected Output:
EMPLOYEE_ID LAST_NAME  JOB_ID     SALARY COMM_PCT MGR_ID DEPARTMENT_ID
----------- ---------- ---------- ------ -------- ------ -------------
        205 Higgins    AC_MGR       2300           101            60
        206 Gitz       IT_PROG      5000           103            60

2 rows selected.


5. Display the employee details of the employee whose LAST_NAME is King.
SQL*Plus Command:
SELECT *
FROM EMPLOYEE
WHERE LAST_NAME = 'King';
Expected Output:
EMPLOYEE_ID LAST_NAME JOB_ID    SALARY COMM_PCT MGR_ID DEPARTMENT_ID
----------- --------- --------- ------ -------- ------ -------------
        100 King      AD_ASST     8956      0.3    108           100

1 row selected.

6. Display unique JOB_ID from EMPLOYEE and give the alias JOB_TITLE.
SQL*Plus Command:
SELECT DISTINCT JOB_ID AS JOB_TITLE
FROM EMPLOYEE;
Expected Output:
JOB_TITLE
----------
SH_CLERK
AD_ASST
IT_PROG
AC_MGR
AD_VP
AD_PRES

6 rows selected.


7. Display LAST_NAME, SALARY and salary increased by Rs. 300. Give the new column name as Increased Salary.
SQL*Plus Command:
SELECT LAST_NAME,
       SALARY,
       SALARY + 300 AS "Increased Salary"
FROM EMPLOYEE;
Expected Output:
LAST_NAME                     SALARY Increased Salary
------------------------- ---------- -----------------
Connell                         2600              2900
Grant                           2600              2900
Whalen                          4400              4700
Hartstein                       6000              6300
Fay                             6500              6800
Mavris                          7500              7800
Baer                            3500              3800
Higgins                         2300              2600
Gitz                            5000              5300
King                            8956              9256
Kochar                          3400              3700

11 rows selected.


8. Display LAST_NAME, SALARY and annual compensation of all employees, plus a one-time bonus of Rs. 100. Give an alias to annual compensation.
SQL*Plus Command:
SELECT LAST_NAME,
       SALARY,
       (SALARY * 12) +
       (SALARY * 12 * NVL(COMM_PCT,0) / 100) + 100
       AS "Annual Compensation"
FROM EMPLOYEE;
Expected Output:
LAST_NAME                     SALARY Annual Compensation
------------------------- ---------- -------------------
Connell                         2600              31380
Grant                           2600              31286.40
Whalen                          4400              52912
Hartstein                       6000              72100
Fay                             6500              78100
Mavris                          7500              90100
Baer                            3500              43030
Higgins                         2300              27700
Gitz                            5000              60100
King                            8956          107842.16
Kochar                          3400              41330.40

11 rows selected.


9. Display the details of those employees who get commission.
SQL*Plus Command:
SELECT *
FROM EMPLOYEE
WHERE COMM_PCT IS NOT NULL;
Expected Output:
EMPLOYEE_ID LAST_NAME JOB_ID    SALARY COMM_PCT MGR_ID DEPARTMENT_ID
----------- --------- --------- ------ -------- ------ -------------
        198 Connell   SH_CLERK    2600      2.5    124            50
        199 Grant     SH_CLERK    2600      2.2    124            50
        200 Whalen    AD_ASST     4400      1.3    101            10
        204 Baer      AD_PRES     3500      1.5    101            90
        100 King      AD_ASST     8956      0.3    108           100
        101 Kochar    SH_CLERK    3400      1.3    118            30

6 rows selected.


10. Display the details of those employees who do not get commission.
SQL*Plus Command:
SELECT *
FROM EMPLOYEE
WHERE COMM_PCT IS NULL;
Expected Output:
EMPLOYEE_ID LAST_NAME JOB_ID    SALARY COMM_PCT MGR_ID DEPARTMENT_ID
----------- --------- --------- ------ -------- ------ -------------
        201 Hartstein IT_PROG     6000           100            20
        202 Fay       AC_MGR      6500           210            20
        203 Mavris    AD_VP        7500           101            40
        205 Higgins   AC_MGR      2300           101            60
        206 Gitz      IT_PROG     5000           103            60

5 rows selected.


11. Display EMPLOYEE_ID, DEPARTMENT_ID and SALARY for all employees whose salary is greater than 5000.
SQL*Plus Command:
SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY > 5000;
Expected Output:
EMPLOYEE_ID DEPARTMENT_ID     SALARY
----------- ------------- ----------
        201            20       6000
        202            20       6500
        203            40       7500
        100           100       8956

4 rows selected.


12. Display LAST_NAME and SALARY of all employees whose salary is between 4000 and 7000.
SQL*Plus Command:
SELECT LAST_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 4000 AND 7000;
Expected Output:
LAST_NAME                     SALARY
------------------------- ----------
Whalen                          4400
Hartstein                       6000
Fay                             6500
Gitz                             5000

4 rows selected.


13. Display the details of all employees whose salary is either 6000, 6500 or 7000.
SQL*Plus Command:
SELECT *
FROM EMPLOYEE
WHERE SALARY IN (6000, 6500, 7000);
Expected Output:
EMPLOYEE_ID LAST_NAME JOB_ID    SALARY COMM_PCT MGR_ID DEPARTMENT_ID
----------- --------- --------- ------ -------- ------ -------------
        201 Hartstein IT_PROG     6000           100            20
        202 Fay       AC_MGR      6500           210            20

2 rows selected.


14. Display the details of all employees who work in department 10, 20, 30 or 50.
SQL*Plus Command:
SELECT *
FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (10, 20, 30, 50);
Expected Output:
EMPLOYEE_ID LAST_NAME JOB_ID    SALARY COMM_PCT MGR_ID DEPARTMENT_ID
----------- --------- --------- ------ -------- ------ -------------
        198 Connell   SH_CLERK    2600      2.5    124            50
        199 Grant     SH_CLERK    2600      2.2    124            50
        200 Whalen    AD_ASST     4400      1.3    101            10
        201 Hartstein IT_PROG     6000           100            20
        202 Fay       AC_MGR      6500           210            20
        101 Kochar    SH_CLERK    3400      1.3    118            30

6 rows selected.


15. Display the details of all employees whose salary is not equal to 5000.
SQL*Plus Command:
SELECT *
FROM EMPLOYEE
WHERE SALARY <> 5000;
Expected Output:
EMPLOYEE_ID LAST_NAME JOB_ID    SALARY COMM_PCT MGR_ID DEPARTMENT_ID
----------- --------- --------- ------ -------- ------ -------------
        198 Connell   SH_CLERK    2600      2.5    124            50
        199 Grant     SH_CLERK    2600      2.2    124            50
        200 Whalen    AD_ASST     4400      1.3    101            10
        201 Hartstein IT_PROG     6000           100            20
        202 Fay       AC_MGR      6500           210            20
        203 Mavris    AD_VP        7500           101            40
        204 Baer      AD_PRES     3500      1.5    101            90
        205 Higgins   AC_MGR      2300           101            60
        100 King      AD_ASST     8956      0.3    108           100
        101 Kochar    SH_CLERK    3400      1.3    118            30

10 rows selected.


16. Display the details of all the CLERKS working in the organization.
SQL*Plus Command:
SELECT *
FROM EMPLOYEE
WHERE JOB_ID LIKE '%CLERK%';
Expected Output:
EMPLOYEE_ID LAST_NAME JOB_ID    SALARY COMM_PCT MGR_ID DEPARTMENT_ID
----------- --------- --------- ------ -------- ------ -------------
        198 Connell   SH_CLERK    2600      2.5    124            50
        199 Grant     SH_CLERK    2600      2.2    124            50
        101 Kochar    SH_CLERK    3400      1.3    118            30

3 rows selected.


17. Update JOB_ID of employees who earn more than 5000 to Grade_A and display the EMPLOYEE table.
SQL*Plus Command:
UPDATE EMPLOYEE
SET JOB_ID = 'Grade_A'
WHERE SALARY > 5000;

SELECT * FROM EMPLOYEE;

COMMIT;
Expected Output:
4 rows updated.

EMPLOYEE_ID LAST_NAME JOB_ID    SALARY COMM_PCT MGR_ID DEPARTMENT_ID
----------- --------- --------- ------ -------- ------ -------------
        198 Connell   SH_CLERK    2600      2.5    124            50
        199 Grant     SH_CLERK    2600      2.2    124            50
        200 Whalen    AD_ASST     4400      1.3    101            10
        201 Hartstein Grade_A     6000           100            20
        202 Fay       Grade_A     6500           210            20
        203 Mavris    Grade_A     7500           101            40
        204 Baer      AD_PRES     3500      1.5    101            90
        205 Higgins   AC_MGR      2300           101            60
        206 Gitz      IT_PROG     5000           103            60
        100 King      Grade_A     8956      0.3    108           100
        101 Kochar    SH_CLERK    3400      1.3    118            30

11 rows selected.

Commit complete.


18. Display details of all employees who are either CLERK, PROGRAMMER or ASSISTANT.
SQL*Plus Command:
SELECT *
FROM EMPLOYEE
WHERE JOB_ID LIKE '%CLERK%'
   OR JOB_ID LIKE '%PROG%'
   OR JOB_ID LIKE '%ASST%';
Expected Output:
EMPLOYEE_ID LAST_NAME JOB_ID    SALARY COMM_PCT MGR_ID DEPARTMENT_ID
----------- --------- --------- ------ -------- ------ -------------
        198 Connell   SH_CLERK    2600      2.5    124            50
        199 Grant     SH_CLERK    2600      2.2    124            50
        200 Whalen    AD_ASST     4400      1.3    101            10
        206 Gitz      IT_PROG     5000           103            60
        100 King      AD_ASST     8956      0.3    108           100
        101 Kochar    SH_CLERK    3400      1.3    118            30

6 rows selected.

Note: This output is based on the original data before Question 17's update. If Question 17 has already been committed, employees whose JOB_ID became Grade_A will no longer match this condition.


19. Display employees whose designation is CLERK and salary is less than 3000.
SQL*Plus Command:
SELECT *
FROM EMPLOYEE
WHERE JOB_ID LIKE '%CLERK%'
AND SALARY < 3000;
Expected Output:
EMPLOYEE_ID LAST_NAME JOB_ID    SALARY COMM_PCT MGR_ID DEPARTMENT_ID
----------- --------- --------- ------ -------- ------ -------------
        198 Connell   SH_CLERK    2600      2.5    124            50
        199 Grant     SH_CLERK    2600      2.2    124            50

2 rows selected.


20. Display LAST_NAME and MGR_ID of employees whose salary is above 3000 and who work under Manager 101.
SQL*Plus Command:
SELECT LAST_NAME, MGR_ID
FROM EMPLOYEE
WHERE SALARY > 3000
AND MGR_ID = 101;
Expected Output:
LAST_NAME                     MGR_ID
------------------------- ----------
Whalen                           101
Mavris                           101
Baer                             101

3 rows selected.
