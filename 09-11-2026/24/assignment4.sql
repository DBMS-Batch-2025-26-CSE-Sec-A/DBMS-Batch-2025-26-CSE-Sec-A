DBMS LAB ASSIGNMENT – 4
Oracle SQL*Plus – Questions, Commands & Expected Outputs

1. Create the following tables with the constraints mentioned.
CREATE TABLE Customer (
    Cust_id VARCHAR2(3) PRIMARY KEY,
    Fname VARCHAR2(15) NOT NULL,
    Lname VARCHAR2(15),
    Area VARCHAR2(2) NOT NULL,
    Phone NUMBER(7)
);

CREATE TABLE Movie (
    Mv_no NUMBER(2) PRIMARY KEY,
    Cust_id VARCHAR2(3) NOT NULL,
    Title VARCHAR2(30) NOT NULL,
    Star VARCHAR2(2) NOT NULL,
    Price NUMBER(5) CHECK (Price BETWEEN 100 AND 250),
    CONSTRAINT movie_cust_fk
        FOREIGN KEY (Cust_id) REFERENCES Customer(Cust_id)
);

INSERT INTO Customer VALUES ('A01','Ivan','Ross','SA',6125467);
INSERT INTO Customer VALUES ('A02','Vandana','Ray','MU',5560379);
INSERT INTO Customer VALUES ('A03','Pramada','Jauguste','DA',4560389);
INSERT INTO Customer VALUES ('A04','Basu','Navindi','BA',6125401);
INSERT INTO Customer VALUES ('A05','Ravi','Shridhar','NA',NULL);
INSERT INTO Customer VALUES ('A06','Rukmini','Aiyer','GH',5125274);

INSERT INTO Movie VALUES (1,'A02','Bloody','JC',181);
INSERT INTO Movie VALUES (2,'A04','The Firm','TC',200);
INSERT INTO Movie VALUES (3,'A01','Pretty Woman','RG',151);
INSERT INTO Movie VALUES (4,'A06','Home Alone','MC',150);
INSERT INTO Movie VALUES (5,'A05','The Fugitive','MF',200);
INSERT INTO Movie VALUES (6,'A03','Coma','MD',100);
INSERT INTO Movie VALUES (7,'A02','Dracula','GO',150);
INSERT INTO Movie VALUES (8,'A06','Quick Change','BM',100);
INSERT INTO Movie VALUES (9,'A03','Gone with the Wind','CB',200);
INSERT INTO Movie VALUES (10,'A05','Carry on Doctor','LP',100);

COMMIT;
Expected Output
Table created.
Table created.
1 row created.   (for each INSERT)
Commit complete.


2. Prove that entity integrity constraint is ensured by both the tables. (2 conditions to be checked).
-- Condition 1: Primary key cannot be NULL
INSERT INTO Customer
VALUES (NULL,'Test','User','AB',1234567);

-- Condition 2: Primary key must be unique
INSERT INTO Customer
VALUES ('A01','Test','User','AB',1234567);

-- Movie primary key test
INSERT INTO Movie
VALUES (1,'A01','Test','TT',150);
Expected Output
ORA-01400: cannot insert NULL into ("CUSTOMER"."CUST_ID")
ORA-00001: unique constraint violated
ORA-00001: unique constraint violated


3. Prove that referential integrity constraint is ensured by both the tables.
INSERT INTO Movie
VALUES (11,'A99','Test Movie','TM',150);
Expected Output
ORA-02291: integrity constraint violated - parent key not found


4. Prove that domain integrity constraint is ensured by the Movie table.
INSERT INTO Movie
VALUES (11,'A01','Test Movie','TT',300);

INSERT INTO Movie
VALUES (11,'A01','Test Movie','TT',50);
Expected Output
ORA-02290: check constraint violated
ORA-02290: check constraint violated


5. Display the movie titles, whose price is greater than 100 but less than 200.
SELECT Title
FROM Movie
WHERE Price > 100
AND Price < 200;
Expected Output
TITLE
------------------------------
Bloody
Pretty Woman
Home Alone
Dracula


6. Display the cust_id who have seen movies having stars as either JC or TC or MC.
SELECT Cust_id
FROM Movie
WHERE Star IN ('JC','TC','MC');
Expected Output
CUS
---
A02
A04
A06


7. Display the details of those customers who have an A in their area name.
SELECT *
FROM Customer
WHERE Area LIKE '%A%';
Expected Output
CUS FNAME           LNAME           AR PHONE
--- --------------- --------------- -- -------
A01 Ivan            Ross            SA 6125467
A03 Pramada         Jauguste        DA 4560389
A04 Basu            Navindi        BA 6125401
A05 Ravi            Shridhar       NA


8. Display the movie titles, whose price is within 180 and the movie titles are of exactly 6 characters.
SELECT Title
FROM Movie
WHERE Price <= 180
AND LENGTH(Title) = 6;
Expected Output
no rows selected


9. Display the movie name, their original prices and the prices after 10% increment. Give alias name to the incremented price column.
SELECT Title,
       Price AS Original_Price,
       Price * 1.10 AS Incremented_Price
FROM Movie;
Expected Output
TITLE                         ORIGINAL_PRICE INCREMENTED_PRICE
----------------------------  -------------- -----------------
Bloody                                  181            199.1
The Firm                                200            220
Pretty Woman                            151            166.1
Home Alone                              150            165
The Fugitive                            200            220
Coma                                    100            110
Dracula                                 150            165
Quick Change                            100            110
Gone with the Wind                      200            220
Carry on Doctor                         100            110


10. Display all the customer details in the following way: ‘Ivan Ross stays in SA and his phone number is 6125467.’
SELECT Fname || ' ' || Lname ||
       ' stays in ' || Area ||
       ' and his phone number is ' || Phone || '.'
       AS Customer_Details
FROM Customer;
Expected Output
CUSTOMER_DETAILS
------------------------------------------------------------
Ivan Ross stays in SA and his phone number is 6125467.
Vandana Ray stays in MU and his phone number is 5560379.
Pramada Jauguste stays in DA and his phone number is 4560389.
Basu Navindi stays in BA and his phone number is 6125401.
Ravi Shridhar stays in NA and his phone number is .
Rukmini Aiyer stays in GH and his phone number is 5125274.


11. Add a NOT NULL constraint to the Lname field in Customer.
ALTER TABLE Customer
MODIFY Lname VARCHAR2(15) NOT NULL;

INSERT INTO Customer
VALUES ('A07','Test',NULL,'AB',1234567);
Expected Output
Table altered.
ORA-01400: cannot insert NULL into ("CUSTOMER"."LNAME")


12. Display the customer name whose phone number is not recorded.
SELECT Fname, Lname
FROM Customer
WHERE Phone IS NULL;
Expected Output
FNAME           LNAME
--------------- ---------------
Ravi            Shridhar


13. Add the phone number according to your own wish for the person mentioned in problem no 7.
UPDATE Customer
SET Phone = 9876543
WHERE Cust_id = 'A05';

SELECT *
FROM Customer
WHERE Cust_id = 'A05';
Expected Output
1 row updated.

CUS FNAME           LNAME           AR PHONE
--- --------------- --------------- -- -------
A05 Ravi            Shridhar        NA 9876543


14. Display the unique customer id’s from movie table.
SELECT DISTINCT Cust_id
FROM Movie;
Expected Output
CUS
---
A01
A02
A03
A04
A05
A06


15. Remove the NOT NULL constraint from Star column in movie table.
ALTER TABLE Movie
MODIFY Star VARCHAR2(2) NULL;

INSERT INTO Movie
VALUES (11,'A01','Test Movie',NULL,150);

DELETE FROM Movie
WHERE Mv_no = 11;
Expected Output
Table altered.
1 row created.
1 row deleted.


16. Delete any row from the Customer table. If you cannot delete, then note the error message displayed.
DELETE FROM Customer
WHERE Cust_id = 'A01';
Expected Output
ORA-02292: integrity constraint violated - child record found


17. Delete any row from the Movie table. If you cannot delete, then note the error message displayed.
DELETE FROM Movie
WHERE Mv_no = 10;
Expected Output
1 row deleted.


18. Drop the Customer table. If you cannot drop, then note the error message displayed.
DROP TABLE Customer;
Expected Output
ORA-02449: unique/primary keys in table referenced by foreign keys


19. Drop the Movie table. If you cannot drop, then note the error message displayed.
DROP TABLE Movie;
Expected Output
Table dropped.


20. Drop the foreign key from Movie table.
ALTER TABLE Movie
DROP CONSTRAINT movie_cust_fk;
Expected Output
Table altered.
