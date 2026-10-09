CREATE DATABASE Ass_5;
USE Ass_5;

#Q1
Create Table Client_Master(
    Client_no Varchar(5) Primary Key
    Check (Client_no Like 'C%'),
    Name Varchar(20) Unique Not Null,
    Address1 Varchar(30),
    State Varchar(30),
    City Varchar(15)
    Check (City in ('Delhi', 'Mumbai', 'Chennai'))
);
Create Table Sales_Order(
    S_order_no Varchar(10) Primary Key
    Check (S_order_no Like 'O%'),
    S_order_date Date,
    Client_no Varchar(5),
    Foreign Key (Client_no) References Client_Master(Client_no),
    Salesman_no Varchar(10)
    Check(Salesman_no Like 'S%'),
    Product_no Varchar(10),
    Foreign Key (Product_no) References Products_Master(Product_no)
);
Create Table Products_Master(
    Product_no Varchar(10) Primary Key
    Check (Product_no Like 'P%'),
    Description Varchar(20) Unique Not Null,
    Qty_on_hand INT
    Check (Qty_on_hand > 10),
    Sell_price Decimal(8, 2) Not Null,
    Cost_price Decimal(8, 2) Not Null
);

Insert Into Client_Master Values
('C01',	'Ivaan', 'Church Rd', 'Maharashtra', 'Mumbai'),
('C02', 'Vandana', 'St.Mary Rd', 'Tamil Nadu', 'Chennai'),
('C03', 'Pramada', 'Mall Rd', 'Maharashtra', 'Mumbai'),
('C04',	'Basu', 'Church Rd', 'Maharashtra', 'Mumbai'),
('C05',	'Ravi',	'Chandni', null, 'Delhi'),
('C06',	'Rukmini', 'Mall Rd', 'Maharashtra', 'Mumbai');

Insert Into Sales_Order Values
('O19001',	'1996-01-12',	'C01',	'S01',	'P01'),
('O19002',	'1996-01-25',	'C02',	'S02',	'P02'),
('O19003',	'1996-02-18',	'C03',	'S03',	'P03'),
('O19004',	'1996-04-03',	'C01',	'S01',	'P04'),
('O19005',	'1996-05-20',	'C04',	'S02',	'P05'),
('O19006',	'1996-05-24',	'C05',	'S04',	'P06');

INSERT INTO Products_Master VALUES
('P01', '1.44 Floppies', 100, 525, 500),
('P02', 'Monitors', 25, 12000, 11280),
('P03', 'Mouse', 20, 1050, 1000),
('P04', '1.22 floppies', 100, 525, 500),
('P05', 'Keyboards', 15, 3150, 3050),
('P06', 'Cd drive', 14, 5250, 5100);

Select * from Client_Master;
Select * from Products_Master;
Select * from Sales_Order;

#Q2
Alter Table Client_Master
Modify Address1 Varchar(30) Not Null;
Desc Client_Master;

#Q3
Select Product_no, Description,
(Sell_price - Cost_price) As Profit
From Products_Master;

#Q4
Select Product_no, Description,
(Qty_on_hand * Cost_price) As Total_Cost_Price
From Products_Master;

#Q5
Select * from Client_Master
Where Name Like 'I%';

#Q6
Select * from Client_Master
Where Name Like 'R%i';

#Q7
Select * from Client_Master
Where Name Like '__a_a%';

#Q8
Select * from Client_Master
Where Name Like '%aa%';

#Q9
Select * from Client_Master
Where Name Like '____';

#Q10
Select * from Client_Master
Where State is Null;

#Q11
Select * from Sales_Order
Where S_order_date > '1996-01-31';

#Q12
Update Sales_order
Set S_order_date = '1996-07-24',
Product_no = 'P06',
Salesman_no = 'S04'
Where Client_no = 'C01';

#Q13
Update Client_Master
Set City = 'Kolkata'
Where Client_no = 'C05';

#Q14
ALTER TABLE Sales_Order
DROP FOREIGN KEY Sales_Order_ibfk_1;

ALTER TABLE Sales_Order
MODIFY Client_no VARCHAR(15);

ALTER TABLE Client_Master
MODIFY Client_no VARCHAR(15);

ALTER TABLE Sales_Order
ADD CONSTRAINT fk_sales_client
FOREIGN KEY (Client_no)
REFERENCES Client_Master(Client_no);

#Q15
DELETE FROM Sales_Order
WHERE Client_no = 'C02';

DELETE FROM Client_Master
WHERE Client_no = 'C02';

#Q16
DELETE so FROM Sales_Order AS so
JOIN Products_Master AS p
    ON so.Product_no = p.Product_no
WHERE p.Sell_price BETWEEN 1000 AND 10000;

-- Step 2: Delete the products
DELETE FROM Products_Master
WHERE Sell_price BETWEEN 1000 AND 10000;

#Q17
CREATE TABLE Student_Course (
    Student_id VARCHAR(10),
    Course_id VARCHAR(10),
    PRIMARY KEY (Student_id, Course_id)
);
CREATE TABLE Exam_Result (
    Student_id VARCHAR(10),
    Course_id VARCHAR(10),
    Marks INT,
    FOREIGN KEY (Student_id, Course_id)
        REFERENCES Student_Course(Student_id, Course_id)
);

#Q18
CREATE TABLE Student_Course (
    Student_id VARCHAR(10),
    Course_id VARCHAR(10),
    PRIMARY KEY (Student_id, Course_id)
);
CREATE TABLE Exam_Result (
    Student_id VARCHAR(10),
    Course_id VARCHAR(10),
    Marks INT,
    FOREIGN KEY (Student_id, Course_id)
        REFERENCES Student_Course(Student_id, Course_id)
);
