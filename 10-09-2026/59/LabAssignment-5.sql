CREATE TABLE Client_Master ( Client_no VARCHAR2(5) CONSTRAINT pk_client PRIMARY KEY CONSTRAINT chk_client_no CHECK (Client_no LIKE 'C%'), Name VARCHAR2(20) 
CONSTRAINT nn_client_name NOT NULL CONSTRAINT uq_client_name UNIQUE, Address1 VARCHAR2(30), State VARCHAR2(30), City VARCHAR2(15) CONSTRAINT chk_client_city CHECK (City IN ('Delhi', 'Mumbai', 'Chennai')));

INSERT INTO Client_Master VALUES ('C01', 'Ivaan', 'Church Rd', 'Maharashtra', 'Mumbai');
INSERT INTO Client_Master VALUES ('C02', 'Vandana', 'St.Mary Rd', 'Tamil Nadu', 'Chennai');

INSERT INTO Client_Master VALUES ('C03', 'Pramada', 'Mall Rd', 'Maharashtra', 'Mumbai');

INSERT INTO Client_Master VALUES ('C04', 'Basu', 'Church Rd', 'Maharashtra', 'Mumbai');

INSERT INTO Client_Master VALUES ('C05', 'Ravi', 'Chandni', NULL, 'Delhi');

INSERT INTO Client_Master VALUES ('C06', 'Rukmini', 'Mall Rd', 'Maharashtra', 'Mumbai');

CREATE TABLE Products_Master ( Product_no VARCHAR2(10) CONSTRAINT pk_product PRIMARY KEY CONSTRAINT chk_product_no CHECK (Product_no LIKE 'P%'), Description VARCHAR2(20) CONSTRAINT nn_product_desc NOT NULL
CONSTRAINT uq_product_desc UNIQUE,Qty_on_hand NUMBER(8) CONSTRAINT chk_product_qty CHECK (Qty_on_hand > 10),Sell_price NUMBER(8,2) CONSTRAINT nn_sell_price NOT NULL,sCost_price NUMBER(8,2) CONSTRAINT nn_cost_price NOT NULL);

INSERT INTO Products_Master VALUES ('P01', '1.44 Floppies', 100, 525, 500);

INSERT INTO Products_Master VALUES ('P02', 'Monitors', 25, 12000, 11280);

INSERT INTO Products_Master VALUES ('P03', 'Mouse', 20, 1050, 1000);

INSERT INTO Products_Master VALUES ('P04', '1.22 floppies', 100, 525, 500);

INSERT INTO Products_Master VALUES ('P05', 'Keyboards', 15, 3150, 3050);

INSERT INTO Products_Master VALUES ('P06', 'Cd drive', 14, 5250, 5100);

CREATE TABLE Sales_Order (S_order_no VARCHAR2(10) CONSTRAINT pk_sales_order PRIMARY KEY CONSTRAINT chk_order_no CHECK (S_order_no LIKE 'O%'),S_order_date DATE, Client_no VARCHAR2(5),Salesman_no VARCHAR2(10)
CONSTRAINT chk_salesman_no CHECK (Salesman_no LIKE 'S%'), Product_no VARCHAR2(10),CONSTRAINT fk_order_client FOREIGN KEY (Client_no) REFERENCES Client_Master(Client_no), CONSTRAINT fk_order_product
FOREIGN KEY (Product_no) REFERENCES Products_Master(Product_no));

INSERT INTO Sales_Order VALUES ('O19001', DATE '1996-01-12', 'C01', 'S01', 'P01');

INSERT INTO Sales_Order VALUES ('O19002', DATE '1996-01-25', 'C02', 'S02', 'P02');

INSERT INTO Sales_Order VALUES ('O19003', DATE '1996-02-18', 'C03', 'S03', 'P03');

INSERT INTO Sales_Order VALUES ('O19004', DATE '1996-04-03', 'C01', 'S01', 'P04');

INSERT INTO Sales_Order VALUES ('O19005', DATE '1996-05-20', 'C04', 'S02', 'P05');

INSERT INTO Sales_Order VALUES ('O19006', DATE '1996-05-24', 'C05', 'S04', 'P06');

COMMIT;

ALTER TABLE Client_Master ADD CONSTRAINT nn_client_address CHECK (Address1 IS NOT NULL);

ALTER TABLE Client_Master MODIFY Address1 CONSTRAINT nn_client_address NOT NULL;

DESC Client_Master;

SELECT Product_no, Description, Sell_price - sCost_price AS Profit FROM Products_Master;

SELECT Product_no, Description, Qty_on_hand * sCost_price AS Total_Cost_Price FROM Products_Master;

SELECT * FROM Client_Master WHERE Name LIKE 'I%';

SELECT * FROM Client_Master WHERE Name LIKE 'R%i';

SELECT * FROM Client_Master WHERE Name LIKE '__a_a%';

SELECT * FROM Client_Master WHERE Name LIKE '%aa%';

SELECT * FROM Client_Master WHERE Name LIKE '____';

SELECT * FROM Client_Master WHERE State IS NULL;

SELECT * FROM Sales_Order WHERE S_order_date >= DATE '1996-02-01';

UPDATE Sales_Order SET S_order_date = DATE '1996-07-24', Product_no = 'P06', Salesman_no = 'S04' WHERE Client_no = 'C01';

ALTER TABLE Client_Master DROP CONSTRAINT chk_client_city;

ALTER TABLE Client_Master ADD CONSTRAINT chk_client_city CHECK (City IN ('Delhi', 'Mumbai', 'Chennai', 'Kolkata'));

UPDATE Client_Master SET City = 'Kolkata' WHERE Client_no = 'C05';
COMMIT;

ALTER TABLE Sales_Order DROP CONSTRAINT fk_order_client;

ALTER TABLE Client_Master MODIFY Client_no VARCHAR2(15);

ALTER TABLE Sales_Order MODIFY Client_no VARCHAR2(15);

ALTER TABLE Sales_Order ADD CONSTRAINT fk_order_client FOREIGN KEY (Client_no) REFERENCES Client_Master(Client_no);

DELETE FROM Sales_Order WHERE Client_no = 'C02';
DELETE FROM Client_Master WHERE Client_no = 'C02';
COMMIT;

DELETE FROM Sales_Order WHERE Product_no IN ( SELECT Product_no FROM Products_Master WHERE Sell_price BETWEEN 1000 AND 10000);

DELETE FROM Products_Master WHERE Sell_price BETWEEN 1000 AND 10000;

COMMIT;

CREATE TABLE Student_Course (Student_ID VARCHAR2(10), Course_ID VARCHAR2(10), Course_Name VARCHAR2(30), CONSTRAINT pk_student_course PRIMARY KEY (Student_ID, Course_ID));

INSERT INTO Student_Course VALUES ('ST01', 'CS101', 'DBMS');

INSERT INTO Student_Course VALUES ('ST01', 'CS102', 'Programming');

INSERT INTO Student_Course VALUES ('ST02', 'CS101', 'DBMS');

COMMIT;

CREATE TABLE Student_Course_Result (Student_ID VARCHAR2(10),Course_ID VARCHAR2(10),Marks NUMBER(5,2),CONSTRAINT pk_course_result PRIMARY KEY (Student_ID, Course_ID),
CONSTRAINT fk_course_result FOREIGN KEY (Student_ID, Course_ID) REFERENCES Student_Course(Student_ID, Course_ID) );

INSERT INTO Student_Course_Result VALUES ('ST01', 'CS101', 85);

INSERT INTO Student_Course_Result VALUES ('ST01', 'CS102', 90);

INSERT INTO Student_Course_Result VALUES ('ST02', 'CS101', 78);

COMMIT;

SELECT * FROM Student_Course_Result;