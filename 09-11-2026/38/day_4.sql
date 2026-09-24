CREATE TABLE Customer (
    Cust_id VARCHAR2(3) PRIMARY KEY,
    Fname VARCHAR2(15),
    Lname VARCHAR2(15),
    Area VARCHAR2(2),
    Phone NUMBER(7),
    Mv_no NUMBER(2)
);

CREATE TABLE Movie (
    Mv_no NUMBER(2) PRIMARY KEY,
    Cust_id VARCHAR2(3),
    Title VARCHAR2(30) NOT NULL,
    Star VARCHAR2(5) NOT NULL,
    Price NUMBER(6,2) CHECK (Price BETWEEN 100 AND 250),
    FOREIGN KEY (Cust_id) REFERENCES Customer(Cust_id)
);

INSERT INTO Customer VALUES
('A01', 'Ivan', 'Ross', 'SA', '6125467', 1),
('A02', 'Vandana', 'Ray', 'MU', '5560379', 2),
('A03', 'Pramada', 'Jauguste', 'DA', '4560389', 3),
('A04', 'Basu', 'Navindi', 'BA', '6125401', 4),
('A05', 'Ravi', 'Shridhar', 'NA', NULL, 5),
('A06', 'Rukmini', 'Aiyer', 'GH', '5125274', 6);

INSERT INTO Movie VALUES
(1, 'A02', 'Bloody', 'JC', 181),
(2, 'A04', 'The Firm', 'TC', 200),
(3, 'A01', 'Pretty Woman', 'RG', 151),
(4, 'A06', 'Home Alone', 'MC', 150),
(5, 'A05', 'The Fugitive', 'MF', 200),
(6, 'A03', 'Coma', 'MD', 100),
(7, 'A02', 'Dracula', 'GO', 150),
(8, 'A06', 'Quick Change', 'BM', 100),
(9, 'A03', 'Gone with the Wind', 'CB', 200),
(10, 'A05', 'Carry on Doctor', 'LP', 100);


--condition 1: primary cannot be null
INSERT INTO Customer
VALUES(NULL,'Test','User','AA',1234567,1);
--condition 2: primary key cannot be duplicated
INSERT INTO Customer
VALUES('A01','Test','User','AA',1234567,1);

--similarly for Movie table
INSERT INTO Customer
VALUES(NULL, 'A01', 'Test Movie', 'XX', 150);
INSERT INTO Customer
VALUES(1, 'A01', 'Test Movie', 'XX', 150);


--check whether a valid foreign key is accepted
INSERT INTO Movie
VALUES (11, 'A01', 'Test Movie', 'XX', 150);
-- Check whether an invalid foreign key value is rejected
INSERT INTO Movie
VALUES (12, 'A99', 'Test Movie', 'XX', 150);


-- Valid value: Price is within the allowed domain
INSERT INTO Movie
VALUES (11, 'A01', 'Test Movie', 'XX', 150);
-- Invalid value: Price is outside the allowed domain
INSERT INTO Movie
VALUES (12, 'A01', 'Test Movie', 'XX', 300);


SELECT Title FROM Movie
WHERE Price > 100 AND Price < 200;


SELECT Cust_id FROM Movie
WHERE Star IN ('JC','TC','MC');


SELECT * FROM Customer
WHERE Area LIKE '%A%'; --LIKE is used for pattern matching, and '%A%' means there can be anything before and after A


SELECT Title FROM Movie
WHERE Price <= 180 AND LENGTH(Title) = 6; --counts the number of characters in the movie title.


SELECT Title,Price,
Price*1.10 AS Incremented_Price FROM Movie; --AS gives a temporary name (alias) to the calculated column.


SELECT Fname || ' ' || Lname || 
' stays in ' || Area || ' and his phone number is ' || Phone || '.' AS Customer_Details
FROM Customer;


ALTER TABLE Customer
MODIFY Lname VARCHAR2(15) NOT NULL;


SELECT Fname,Lname FROM Customer
WHERE Phone IS NULL;


UPDATE Customer SET Phone = 9876543
WHERE Cust_id= 'A05';


SELECT DISTINCT Cust_id
FROM Movie;


ALTER TABLE Movie
MODIFY Star VARCHAR2(5) NULL; --use modify to modify existing movie tabele


DELETE FROM Customer
WHERE Cust_id = 'A02';


DELETE FROM Movie
WHERE Mv_no = 1;


DROP TABLE Customer;


DROP TABLE Movie;


ALTER TABLE Movie
DROP CONSTRAINT fk_movie_customer;

