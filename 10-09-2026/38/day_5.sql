--1)
CREATE TABLE Client_Master(
    Client_no VARCHAR2(5)
        CONSTRAINT pk_client_master PRIMARY KEY
        CONSTRAINT chk_client_no CHECK (Client_no LIKE 'C%'),
        
    Name VARCHAR2(20)
        CONSTRAINT nn_client_name NOT NULL
        CONSTRAINT uq_client_name UNIQUE,
        
    Address1 VARCHAR2(20),
    State VARCHAR2(30),
    City VARCHAR2(15)
        CONSTRAINT chk_client_city
        CHECK (City IN ('Delhi', 'Mumbai', 'Chennai'))
);


INSERT INTO Client_Master
VALUES ('C01', 'Ivaan', 'Church Rd', 'Maharashtra', 'Mumbai');

INSERT INTO Client_Master
VALUES ('C02', 'Vandana', 'St.Mary Rd', 'Tamil Nadu', 'Chennai');

INSERT INTO Client_Master
VALUES ('C03', 'Pramada', 'Mall Rd', 'Maharashtra', 'Mumbai');

INSERT INTO Client_Master
VALUES ('C04', 'Basu', 'Church Rd', 'Maharashtra', 'Mumbai');

INSERT INTO Client_Master
VALUES ('C05', 'Ravi', 'Chandni', NULL, 'Delhi');

INSERT INTO Client_Master
VALUES ('C06', 'Rukmini', 'Mall Rd', 'Maharashtra', 'Mumbai');



CREATE TABLE Products_Master (
    Product_no VARCHAR2(10)
        CONSTRAINT pk_products_master PRIMARY KEY
        CONSTRAINT chk_product_no CHECK (Product_no LIKE 'P%'),

    Description VARCHAR2(20)
        CONSTRAINT nn_product_description NOT NULL
        CONSTRAINT uq_product_description UNIQUE,

    Qty_on_hand NUMBER(8)
        CONSTRAINT chk_product_qty CHECK (Qty_on_hand > 10),

    Sell_price NUMBER(8,2)
        CONSTRAINT nn_product_sell_price NOT NULL,

    Cost_price NUMBER(8,2)
        CONSTRAINT nn_product_cost_price NOT NULL
);



INSERT INTO Products_Master
VALUES ('P01', '1.44 Floppies', 100, 525, 500);

INSERT INTO Products_Master
VALUES ('P02', 'Monitors', 25, 12000, 11280);

INSERT INTO Products_Master
VALUES ('P03', 'Mouse', 20, 1050, 1000);

INSERT INTO Products_Master
VALUES ('P04', '1.22 floppies', 100, 525, 500);

INSERT INTO Products_Master
VALUES ('P05', 'Keyboards', 15, 3150, 3050);

INSERT INTO Products_Master
VALUES ('P06', 'Cd drive', 14, 5250, 5100);



CREATE TABLE Sales_Order (
    S_order_no VARCHAR2(10)
        CONSTRAINT pk_sales_order PRIMARY KEY
        CONSTRAINT chk_s_order_no CHECK (S_order_no LIKE 'O%'),

    S_order_date DATE,

    Client_no VARCHAR2(5),

    Salesman_no VARCHAR2(10)
        CONSTRAINT chk_salesman_no CHECK (Salesman_no LIKE 'S%'),

    Product_no VARCHAR2(10),

    CONSTRAINT fk_sales_client
        FOREIGN KEY (Client_no)
        REFERENCES Client_Master(Client_no),

    CONSTRAINT fk_sales_product
        FOREIGN KEY (Product_no)
        REFERENCES Products_Master(Product_no)
);



INSERT INTO Sales_Order
VALUES ('O19001', DATE '1996-01-12', 'C01', 'S01', 'P01');

INSERT INTO Sales_Order
VALUES ('O19002', DATE '1996-01-25', 'C02', 'S02', 'P02');

INSERT INTO Sales_Order
VALUES ('O19003', DATE '1996-02-18', 'C03', 'S03', 'P03');

INSERT INTO Sales_Order
VALUES ('O19004', DATE '1996-04-03', 'C01', 'S01', 'P04');

INSERT INTO Sales_Order
VALUES ('O19005', DATE '1996-05-20', 'C04', 'S02', 'P05');

INSERT INTO Sales_Order
VALUES ('O19006', DATE '1996-05-24', 'C05', 'S04', 'P06');



--2)
ALTER TABLE Client_Master MODIFY (
    Address1 CONSTRAINT nn_client_address1 NOT NULL
);


--3)
SELECT Product_no ,Description, Sell_price - Cost_price AS Profit
FROM Products_Master;


--4)
SELECT Product_no ,Description, Qty_on_hand * Cost_price AS Total_Stock_Cost
FROM Products_Master;


--5)
SELECT * FROM Client_Master 
WHERE Name LIKE 'I%';


--6)
SELECT * FROM Client_Master 
WHERE Name LIKE 'R%i';


--7)
SELECT * FROM Client_Master 
WHERE Name LIKE '__a_a%';


--8)
SELECT * FROM Client_Master 
WHERE Name LIKE '%aa%';


--9)
SELECT * FROM Client_Master 
WHERE Name LIKE '____';


--10)
SELECT * FROM Client_Master 
WHERE State IS NULL;


--11)
SELECT * FROM Sales_Order
WHERE S_order_date >= DATE '1996-02-01';


--12)
UPDATE Sales_Order
SET S_order_date = DATE '1996-07-24', Product_no = 'P06', Salesman_no = 'S04'
WHERE Client_no = 'C01';


--13)
ALTER TABLE Client_Master
DROP CONSTRAINT chk_client_city;

ALTER TABLE Client_Master
ADD CONSTRAINT chk_client_city
CHECK (City IN ('Delhi', 'Mumbai', 'Chennai', 'Kolkata'));

UPDATE Client_Master
SET City = 'Kolkata' WHERE Client_no = 'C05';



--14)
--temporarily remove the foreign key
ALTER TABLE Sales_Order DROP CONSTRAINT fk_sales_client;
ALTER TABLE Client_Master MODIFY (Client_no VARCHAR2(15));
ALTER TABLE Sales_Order MODIFY (Client_no VARCHAR2(15));

--now recreate
ALTER TABLE Sales_Order ADD CONSTRAINT fk_sales_client
FOREIGN KEY (Client_no) REFERENCES Client_Master(Client_no);


--15)

DELETE FROM Sales_Order
WHERE Client_no = 'C02';
DELETE FROM Client_Master
WHERE Client_no = 'C02';


--16)
DELETE FROM Sales_Order
WHERE Product_no IN (
    SELECT Product_no
    FROM Products_Master
    WHERE Sell_price BETWEEN 1000 AND 10000
);
DELETE FROM Products_Master
WHERE Sell_price BETWEEN 1000 AND 10000;


--17)
CREATE TABLE Student_Course (
    Student_ID NUMBER(5),
    Course_ID VARCHAR2(10),

    CONSTRAINT pk_student_course
        PRIMARY KEY (Student_ID, Course_ID)
);


--18)
CREATE TABLE Course_Result (
    Result_ID NUMBER(5)
        CONSTRAINT pk_course_result PRIMARY KEY,

    Student_ID NUMBER(5),
    Course_ID VARCHAR2(10),
    Marks NUMBER(3),

    CONSTRAINT fk_result_student_course
        FOREIGN KEY (Student_ID, Course_ID)
        REFERENCES Student_Course(Student_ID, Course_ID)
);

COMMIT;





