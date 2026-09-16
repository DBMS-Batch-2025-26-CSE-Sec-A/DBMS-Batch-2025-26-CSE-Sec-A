use DBMSLAB;
CREATE TABLE EMP1 (
    ID INT,
    Name VARCHAR(10),
    Basic DECIMAL(6,2),
    Designation VARCHAR(10),
    Age INT
);

desc emp1;

ALTER TABLE EMP1
MODIFY Basic INT;

desc emp1;

ALTER TABLE EMP1
MODIFY Name VARCHAR(15);

CREATE TABLE EMP_trainee (
    Emp_id INT,
    Name VARCHAR(15),
    Basic INT,
    Designation VARCHAR(10),
    Age INT
);

INSERT INTO EMP1
(ID, Name, Basic, Designation, Age)
VALUES
(1, 'Rohit', 6700, 'Manager', 24),
(2, 'Sunil', 6200, 'Engineer', 27),
(3, 'Payal', 6300, 'Engineer', 25),
(4, 'Kunal', 6700, 'Trainee', 28),
(5, 'Sunita', 6230, 'Trainee', 26),
(6, 'Bimal', 7000, 'Trainee', 25);

SELECT * FROM EMP1;

INSERT INTO EMP_trainee
(Emp_id, Name, Basic, Designation, Age)
SELECT ID, Name, Basic, Designation, Age
FROM EMP1
WHERE Designation = 'Trainee';

ALTER TABLE EMP1
ADD Skills VARCHAR(10),
ADD DOJ DATE;

set sql_safe_updates=0;


UPDATE EMP1
SET Basic = Basic + 500
WHERE Designation = 'Trainee';

ALTER TABLE EMP1
RENAME COLUMN Age TO Age_in_Years;

ALTER TABLE EMP_trainee
DROP COLUMN Age;

RENAME TABLE EMP1 TO EMP_Mgr_Engr;

TRUNCATE TABLE EMP_Mgr_Engr;
