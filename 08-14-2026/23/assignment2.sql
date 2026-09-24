DBMS – Lab ASSIGNMENT 2
1. Create a table EMP1 with following structure.

ID	Name	Basic	Designation	Age

Column Description:-
ID		Number (2)		
Name		Varchar2 (10)		
Basic		Number (6, 2)		
Designation	Varchar2 (10)					
Age		Number (2)

Query:
CREATE TABLE EMP1 (
    ID NUMBER(2),
    Name VARCHAR2(10),
    Basic NUMBER(6, 2),
    Designation VARCHAR2(10),
    Age NUMBER(2)
);

 

2. Change the data type of the field Basic from float to integer with required size of the EMP1 table.
Query:
ALTER TABLE EMP1 
MODIFY Basic NUMBER(6);

 

3. Change the field size of Name column of the EMP1 table from 10 to 15.
Query:
ALTER TABLE EMP1 
MODIFY Name VARCHAR2(15);
 

4. Create another table EMP_trainee with the same (changed) structure. The column ID to be renamed as Emp_id in the EMP_trainee table.
Query:
CREATE TABLE EMP_trainee (
    Emp_id NUMBER(2),
    Name VARCHAR2(15),
    Basic NUMBER(6),
    Designation VARCHAR2(10),
    Age NUMBER(2)
);
 
5. Insert following data in EMP1 table:-
(1, Rohit, 6700, Manager, 24)
(2, Sunil, 6200, Engineer, 27)
(3, Payal, 6300, Engineer, 25)
(4, Kunal, 6700, Trainee, 28)
(5, Sunita, 6230, Trainee, 26)
(6, Bimal, 7000, Trainee, 25)
Query:
INSERT INTO EMP1 (ID, Name, Basic, Designation, Age) VALUES (1, 'Rohit', 6700, 'Manager', 24);
INSERT INTO EMP1 (ID, Name, Basic, Designation, Age) VALUES (2, 'Sunil', 6200, 'Engineer', 27);
INSERT INTO EMP1 (ID, Name, Basic, Designation, Age) VALUES (3, 'Payal', 6300, 'Engineer', 25);
INSERT INTO EMP1 (ID, Name, Basic, Designation, Age) VALUES (4, 'Kunal', 6700, 'Trainee', 28);
INSERT INTO EMP1 (ID, Name, Basic, Designation, Age) VALUES (5, 'Sunita', 6230, 'Trainee', 26);
INSERT INTO EMP1 (ID, Name, Basic, Designation, Age) VALUES (6, 'Bimal', 7000, 'Trainee', 25);

COMMIT;
 
6. Insert all rows with the designation ‘trainee’ from the EMP1 table to EMP_trainee table
Query:
INSERT INTO EMP_trainee (Emp_id, Name, Basic, Designation, Age)
SELECT ID, Name, Basic, Designation, Age
FROM EMP1
WHERE LOWER(Designation) = 'trainee';


COMMIT;
 
7. Add columns Skills (data type-varchar2 and size-10) and DOJ(data type-date) to the EMP1 table and add data for the Skills and DOJ columns according to your own wish.
Query:
ALTER TABLE EMP1 
ADD (
    Skills VARCHAR2(10),
    DOJ DATE
);
UPDATE EMP1 SET Skills = 'Java',       DOJ = TO_DATE('15-JAN-2022', 'DD-MON-YYYY') WHERE ID = 1;
UPDATE EMP1 SET Skills = 'Python',     DOJ = TO_DATE('20-MAR-2022', 'DD-MON-YYYY') WHERE ID = 2;
UPDATE EMP1 SET Skills = 'SQL',        DOJ = TO_DATE('10-JUN-2022', 'DD-MON-YYYY') WHERE ID = 3;
UPDATE EMP1 SET Skills = 'C++',        DOJ = TO_DATE('01-AUG-2023', 'DD-MON-YYYY') WHERE ID = 4;
UPDATE EMP1 SET Skills = 'Testing',    DOJ = TO_DATE('15-SEP-2023', 'DD-MON-YYYY') WHERE ID = 5;
UPDATE EMP1 SET Skills = 'Web Dev',    DOJ = TO_DATE('01-DEC-2023', 'DD-MON-YYYY') WHERE ID = 6;


COMMIT;
 


8.Update more than one row in one query in EMP1 table.
Query:
UPDATE EMP1
SET Basic = CASE 
    WHEN ID = 1 THEN 7500
    WHEN ID = 2 THEN 6800
    WHEN ID = 3 THEN 6900
    ELSE Basic
END
WHERE ID IN (1, 2, 3);

COMMIT;
 
9. Rename the column Age of EMP1 table to Age_in_Years.
Query :
ALTER TABLE EMP1 
RENAME COLUMN Age TO Age_in_Years;
 
10. Drop the Age column from the EMP_trainee table.
Query:
ALTER TABLE EMP_trainee 
DROP COLUMN Age;
 
11. Rename the table EMP to EMP_Mgr_Engr.
Query:
RENAME EMP TO EMP_Mgr_Engr;
12. Truncate EMP_Mgr_Engr table.                    
Query:
TRUNCATE TABLE EMP_Mgr_Engr;
