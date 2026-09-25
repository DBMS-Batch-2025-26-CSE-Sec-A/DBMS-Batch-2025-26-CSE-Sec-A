Skip to content
DBMS-Batch-2025-26-CSE-Sec-A
DBMS-Batch-2025-26-CSE-Sec-A
Repository navigation
Code
Issues
Pull requests
10
 (10)
Agents
Actions
Projects
Wiki
Security and quality
Insights
Settings
DBMS-Batch-2025-26-CSE-Sec-A/09-11-2026/68
/Assignment_4.sql
Go to file
t
T
 

Code

Blame
138 lines (79 loc) · 2.04 KB
use DBMS_LAB;


CREATE TABLE Customer (
    Cust_id VARCHAR(3) PRIMARY KEY,
    Fname VARCHAR(15) NOT NULL,
    Lname VARCHAR(15) NOT NULL,
    Area VARCHAR(5),
    Phone VARCHAR(10),
    Mv_no INT
);



CREATE TABLE Movie (
    Mv_no INT PRIMARY KEY,
    Cust_id VARCHAR(3) NOT NULL,
    Title VARCHAR(30) NOT NULL,
    Star VARCHAR(3) NOT NULL,
    Price INT CHECK (Price BETWEEN 100 AND 250),
    FOREIGN KEY (Cust_id) REFERENCES Customer(Cust_id)
);



INSERT INTO Customer
VALUES
('A01', 'Ivan', 'Ross', 'SA', '6125467', 1),
('A02', 'Vandana', 'Ray', 'MU', '5560379', 2),
('A03', 'Pramada', 'Jauguste', 'DA', '4560389', 3),
('A04', 'Basu', 'Navindi', 'BA', '6125401', 4),
('A05', 'Ravi', 'Shridhar', 'NA', NULL, 5),
('A06', 'Rukmini', 'Aiyer', 'GH', '5125274', 6);




INSERT INTO Movie
VALUES
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




SELECT Title
FROM Movie
WHERE Price > 100 AND Price < 200;




SELECT Cust_id
FROM Movie
WHERE Star IN ('JC', 'TC', 'MC');



SELECT *
FROM Customer
WHERE Area LIKE '%A%';



SELECT Title
FROM Movie
WHERE Price <= 180
AND CHAR_LENGTH(Title) = 6;



SELECT Title, Price,
       Price * 1.10 AS New_Price
FROM Movie;




SELECT CONCAT(
    Fname, ' ', Lname,
    ' stays in ', Area,
    ' and his phone number is ', Phone, '.'
) AS Customer_Details
FROM Customer;




ALTER TABLE Customer
MODIFY Lname VARCHAR(15) NOT NULL;




SELECT Fname, Lname
FROM Customer
WHERE Phone IS NULL;




UPDATE Customer
SET Phone = '9876543210'
WHERE Cust_id = 'A05';



SELECT DISTINCT Cust_id
FROM Movie;




ALTER TABLE Movie
MODIFY Star VARCHAR(3) NULL;


DELETE FROM Customer
WHERE Cust_id = 'A01';


DELETE FROM Movie
WHERE Mv_no = 1;

DROP TABLE Customer;

DROP TABLE Movie;

ALTER TABLE Movie
DROP FOREIGN KEY movie_ibfk_1;
Footer
© 2026 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Community
Docs
Contact
Manage cookies
Do not share my personal information
