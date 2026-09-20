CREATE TABLE MCA AS
SELECT Roll_Number,
       Name AS First_Name,
       Age,
       Course AS Department,
       Math,
       Physics,
       Computer,
       Birthday
FROM Student
WHERE 1 = 2;