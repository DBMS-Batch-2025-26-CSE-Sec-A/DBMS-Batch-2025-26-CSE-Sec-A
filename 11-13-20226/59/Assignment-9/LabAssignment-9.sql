--CREATE TABLE Customer (
--    Cust_id VARCHAR2(5) PRIMARY KEY,
--    Fname VARCHAR2(20) NOT NULL,
--    Lname VARCHAR2(20),
--    Area VARCHAR2(5) NOT NULL,
--    Phone NUMBER(10)
----);
--INSERT INTO Customer VALUES ('A01','Ivan','Bayross','SA',6125467);
--INSERT INTO Customer VALUES ('A02','Vandana','Saiteal','MU',5560379);
--INSERT INTO Customer VALUES ('A03','Pramada','Jauguste','DA',4560389);
--INSERT INTO Customer VALUES ('A04','Basu','Navindi','BA',6125401);
--INSERT INTO Customer VALUES ('A05','Ravi','Shreedhar','NA',NULL);
--INSERT INTO Customer VALUES ('A06','Rukmini',NULL,'GH',5125274);
--CREATE TABLE Movie (
--    Mv_no NUMBER(2) PRIMARY KEY,
--    Title VARCHAR2(40) NOT NULL,
--    Type VARCHAR2(20) NOT NULL,
--    Star VARCHAR2(10) NOT NULL,
--    Price NUMBER(5) NOT NULL
--);
--INSERT INTO Movie VALUES (1,'Bloody','Action','JC',181);
--INSERT INTO Movie VALUES (2,'The Firm','Thriller','TC',200);
--INSERT INTO Movie VALUES (3,'Pretty Woman','Romance','RG',151);
--INSERT INTO Movie VALUES (4,'Home Alone','Comedy','MC',150);
--INSERT INTO Movie VALUES (5,'The Fugitive','Thriller','MF',200);
--INSERT INTO Movie VALUES (6,'Coma','Suspense','MD',100);
--INSERT INTO Movie VALUES (7,'Dracula','Horror','GO',150);
--INSERT INTO Movie VALUES (8,'Quick Change','Comedy','BM',100);
--INSERT INTO Movie VALUES (9,'Gone with the Wind','Action','CB',200);
--INSERT INTO Movie VALUES (10,'Carry on Doctor','Comedy','LP',100);
--CREATE TABLE Invoice (
--    Inv_no VARCHAR2(5) PRIMARY KEY,
--    Mv_no NUMBER(2),
--    Cust_id VARCHAR2(5),
--    Issue_date DATE NOT NULL,
--    Return_date DATE NOT NULL,
--    FOREIGN KEY (Mv_no) REFERENCES Movie(Mv_no),
--    FOREIGN KEY (Cust_id) REFERENCES Customer(Cust_id)
--);
--INSERT INTO Invoice VALUES
--('I01',4,'A01',TO_DATE('23-JUL-1993','DD-MON-YYYY'),
--TO_DATE('25-JUL-1993','DD-MON-YYYY'));
--
--INSERT INTO Invoice VALUES
--('I02',3,'A02',TO_DATE('12-AUG-1993','DD-MON-YYYY'),
--TO_DATE('15-AUG-1993','DD-MON-YYYY'));
--
--INSERT INTO Invoice VALUES
--('I03',1,'A02',TO_DATE('15-AUG-1993','DD-MON-YYYY'),
--TO_DATE('18-AUG-1993','DD-MON-YYYY'));
--
--INSERT INTO Invoice VALUES
--('I04',6,'A03',TO_DATE('10-SEP-1993','DD-MON-YYYY'),
--TO_DATE('13-SEP-1993','DD-MON-YYYY'));
--
--INSERT INTO Invoice VALUES
--('I05',7,'A04',TO_DATE('05-AUG-1993','DD-MON-YYYY'),
--TO_DATE('08-AUG-1993','DD-MON-YYYY'));
--
--INSERT INTO Invoice VALUES
--('I06',2,'A06',TO_DATE('18-SEP-1993','DD-MON-YYYY'),
--TO_DATE('21-SEP-1993','DD-MON-YYYY'));
--
--INSERT INTO Invoice VALUES
--('I07',9,'A05',TO_DATE('07-JUL-1993','DD-MON-YYYY'),
--TO_DATE('10-JUL-1993','DD-MON-YYYY'));
--
--INSERT INTO Invoice VALUES
--('I08',9,'A01',TO_DATE('11-AUG-1993','DD-MON-YYYY'),
--TO_DATE('14-AUG-1993','DD-MON-YYYY'));
--
--INSERT INTO Invoice VALUES
--('I09',5,'A03',TO_DATE('06-JUL-1993','DD-MON-YYYY'),
--TO_DATE('09-JUL-1993','DD-MON-YYYY'));
--
--INSERT INTO Invoice VALUES
--('I10',8,'A06',TO_DATE('03-SEP-1993','DD-MON-YYYY'),
--TO_DATE('06-SEP-1993','DD-MON-YYYY'));

--SELECT C.Fname, C.Lname, I.Mv_no
--FROM Customer C
--JOIN Invoice I
--ON C.Cust_id = I.Cust_id;

--SELECT M.Mv_no, M.Title
--FROM Movie M
--JOIN Invoice I ON M.Mv_no = I.Mv_no
--JOIN Customer C ON I.Cust_id = C.Cust_id
--WHERE C.Fname = 'Ivan';
--SELECT M.Title, I.Cust_id, I.Mv_no
--FROM Movie M
--JOIN Invoice I
--ON M.Mv_no = I.Mv_no;
--SELECT M.Title, M.Type
--FROM Movie M
--JOIN Invoice I ON M.Mv_no = I.Mv_no
--JOIN Customer C ON I.Cust_id = C.Cust_id
--WHERE C.Fname = 'Vandana';

--SELECT DISTINCT C.Fname, C.Lname
--FROM Customer C
--JOIN Invoice I ON C.Cust_id = I.Cust_id
--JOIN Movie M ON I.Mv_no = M.Mv_no
--WHERE M.Type = 'Action';
--
--SELECT 'The movie taken by ' || C.Fname || ' ' ||
--C.Lname || ' is ' || M.Title || '.' AS DETAILS
--FROM Customer C
--JOIN Invoice I ON C.Cust_id = I.Cust_id
--JOIN Movie M ON I.Mv_no = M.Mv_no
--WHERE M.Mv_no >= 3;

--SELECT C.*
--FROM Customer C
--JOIN Invoice I ON C.Cust_id = I.Cust_id
--WHERE I.Inv_no = 'I10';

--SELECT C.Fname, C.Lname, C.Phone, C.Area
--FROM Customer C
--JOIN Invoice I ON C.Cust_id = I.Cust_id
--WHERE I.Issue_date < TO_DATE('01-AUG-1993','DD-MON-YYYY');

--SELECT DISTINCT M.Mv_no, M.Title
--FROM Movie M
--JOIN Invoice I ON M.Mv_no = I.Mv_no
--JOIN Customer C ON I.Cust_id = C.Cust_id
--WHERE C.Fname IN ('Ivan','Vandana','Ravi');

--SELECT M.Type, M.Mv_no
--FROM Movie M
--JOIN Invoice I ON M.Mv_no = I.Mv_no
--WHERE I.Cust_id IN ('A01','A02')
--ORDER BY I.Cust_id, M.Mv_no;

--SELECT DISTINCT I.Cust_id
--FROM Movie M
--JOIN Invoice I ON M.Mv_no = I.Mv_no
--WHERE M.Star = 'TC';

--SELECT DISTINCT C.Fname, C.Lname
--FROM Customer C
--JOIN Invoice I ON C.Cust_id = I.Cust_id;

--SELECT M.Mv_no, M.Title
--FROM Movie M
--WHERE M.Mv_no NOT IN (
--    SELECT I.Mv_no
--    FROM Invoice I
--);
--SELECT E.EMPNO AS EMPLOYEE_ID,
--       E.ENAME AS EMPLOYEE_NAME,
--       E.MGR AS MANAGER_ID,
--       M.ENAME AS MANAGER_NAME
--FROM EMP E
--LEFT JOIN EMP M
--ON E.MGR = M.EMPNO;

SELECT E.ENAME AS EMPLOYEE_NAME,
       E.MGR AS MANAGER_ID,
       M.ENAME AS MANAGER_NAME,
       MM.ENAME AS MANAGERS_MANAGER_NAME
FROM EMP E
LEFT JOIN EMP M
ON E.MGR = M.EMPNO
LEFT JOIN EMP MM
ON M.MGR = MM.EMPNO;