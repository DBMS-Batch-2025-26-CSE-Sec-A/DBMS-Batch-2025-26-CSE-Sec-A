USE Ass_9;

#Q1
CREATE TABLE Customer (
    Cust_id VARCHAR(3) PRIMARY KEY,
    Fname VARCHAR(30) NOT NULL,
    Lname VARCHAR(30),
    Area VARCHAR(5) NOT NULL,
    Phone BIGINT,
    CHECK (Cust_id LIKE 'A%')
);
INSERT INTO Customer VALUES
('A01', 'Ivan', 'Bayross', 'SA', 6125467),
('A02', 'Vandana', 'Saiteal', 'MU', 5560379),
('A03', 'Pramada', 'Jauguste', 'DA', 4560389),
('A04', 'Basu', 'Navindi', 'BA', 6125401),
('A05', 'Ravi', 'Shreedhar', 'NA', NULL),
('A06', 'Rukmini', NULL, 'GH', 5125274);

CREATE TABLE Movie (
    Mv_no INT PRIMARY KEY,
    Title VARCHAR(50) NOT NULL,
    Type VARCHAR(20) NOT NULL,
    Star VARCHAR(10) NOT NULL,
    Price INT NOT NULL
);
INSERT INTO Movie VALUES
(1, 'Bloody', 'Action', 'JC', 181),
(2, 'The Firm', 'Thriller', 'TC', 200),
(3, 'Pretty Woman', 'Romance', 'RG', 151),
(4, 'Home Alone', 'Comedy', 'MC', 150),
(5, 'The Fugitive', 'Thriller', 'MF', 200),
(6, 'Coma', 'Suspense', 'MD', 100),
(7, 'Dracula', 'Horror', 'GO', 150),
(8, 'Quick Change', 'Comedy', 'BM', 100),
(9, 'Gone with the Wind', 'Action', 'CB', 200),
(10, 'Carry on Doctor', 'Comedy', 'LP', 100);

CREATE TABLE Invoice (
    Inv_no VARCHAR(3) PRIMARY KEY,
    Mv_no INT,
    Cust_id VARCHAR(3),
    Issue_date DATE NOT NULL,
    Return_date DATE NOT NULL,
    CHECK (Inv_no LIKE 'I%'),
    FOREIGN KEY (Mv_no) REFERENCES Movie(Mv_no),
    FOREIGN KEY (Cust_id) REFERENCES Customer(Cust_id)
);
INSERT INTO Invoice VALUES
('I01', 4, 'A01', '1993-07-23', '1993-07-25'),
('I02', 3, 'A02', '1993-08-12', '1993-08-15'),
('I03', 1, 'A02', '1993-08-15', '1993-08-18'),
('I04', 6, 'A03', '1993-09-10', '1993-09-13'),
('I05', 7, 'A04', '1993-08-05', '1993-08-08'),
('I06', 2, 'A06', '1993-09-18', '1993-09-21'),
('I07', 9, 'A05', '1993-07-07', '1993-07-10'),
('I08', 9, 'A01', '1993-08-11', '1993-08-14'),
('I09', 5, 'A03', '1993-07-06', '1993-07-09'),
('I10', 8, 'A06', '1993-09-03', '1993-09-06');

#Q2
SELECT C.Fname, C.Lname, I.Mv_no
FROM Customer C
INNER JOIN Invoice I
ON C.Cust_id = I.Cust_id;

#Q3
SELECT M.Mv_no, M.Title
FROM Movie M
INNER JOIN Invoice I
ON M.Mv_no = I.Mv_no
INNER JOIN Customer C
ON I.Cust_id = C.Cust_id
WHERE C.Fname = 'Ivan';

#Q4
SELECT M.Title, I.Cust_id, I.Mv_no
FROM Movie M
INNER JOIN Invoice I
ON M.Mv_no = I.Mv_no;

#Q5
SELECT M.Title, M.Type
FROM Movie M
INNER JOIN Invoice I
ON M.Mv_no = I.Mv_no
INNER JOIN Customer C
ON I.Cust_id = C.Cust_id
WHERE C.Fname = 'Vandana';

#Q6
SELECT DISTINCT C.Fname, C.Lname
FROM Customer C
INNER JOIN Invoice I
ON C.Cust_id = I.Cust_id
INNER JOIN Movie M
ON I.Mv_no = M.Mv_no
WHERE M.Type = 'Action';

#Q7
SELECT CONCAT(
    'The movie taken by ',
    C.Fname, ' ',
    C.Lname,
    ' is ',
    M.Title, '.'
) AS Movie_Details
FROM Customer C
INNER JOIN Invoice I
ON C.Cust_id = I.Cust_id
INNER JOIN Movie M
ON I.Mv_no = M.Mv_no
WHERE M.Mv_no >= 3;

#Q8
SELECT C.*
FROM Customer C
INNER JOIN Invoice I
ON C.Cust_id = I.Cust_id
WHERE I.Inv_no = 'I10';

#Q9
SELECT DISTINCT C.Fname, C.Lname, C.Phone, C.Area
FROM Customer C
INNER JOIN Invoice I
ON C.Cust_id = I.Cust_id
WHERE MONTH(I.Issue_date) < 8;

#Q10
SELECT DISTINCT M.Mv_no, M.Title
FROM Movie M
INNER JOIN Invoice I
ON M.Mv_no = I.Mv_no
INNER JOIN Customer C
ON I.Cust_id = C.Cust_id
WHERE C.Fname IN ('Ivan', 'Vandana', 'Ravi');

#Q11
SELECT DISTINCT M.Mv_no, M.Title
FROM Movie M
INNER JOIN Invoice I
ON M.Mv_no = I.Mv_no;

#Q12
SELECT M.Type, M.Mv_no
FROM Movie M
INNER JOIN Invoice I
ON M.Mv_no = I.Mv_no
WHERE I.Cust_id IN ('A01', 'A02');

#Q13
SELECT DISTINCT I.Cust_id
FROM Movie M
INNER JOIN Invoice I
ON M.Mv_no = I.Mv_no
WHERE M.Star = 'TC';

#Q14
SELECT DISTINCT C.Fname, C.Lname
FROM Customer C
INNER JOIN Invoice I
ON C.Cust_id = I.Cust_id;

#Q15
SELECT M.Mv_no
FROM Movie M
LEFT JOIN Invoice I
ON M.Mv_no = I.Mv_no
WHERE I.Mv_no IS NULL;

#Q16
SELECT
    E.EMPNO,
    E.ENAME,
    E.MGR,
    M.ENAME AS MANAGER_NAME
FROM EMP E
LEFT JOIN EMP M
ON E.MGR = M.EMPNO;

#Q17
SELECT
    E.ENAME AS EMPLOYEE_NAME,
    E.MGR AS MANAGER_ID,
    M.ENAME AS MANAGER_NAME,
    MM.ENAME AS MANAGERS_MANAGER_NAME
FROM EMP E
LEFT JOIN EMP M
ON E.MGR = M.EMPNO
LEFT JOIN EMP MM
ON M.MGR = MM.EMPNO;
