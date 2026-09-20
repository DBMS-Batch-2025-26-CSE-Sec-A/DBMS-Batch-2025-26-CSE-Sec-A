INSERT INTO MCA
SELECT Roll_Number,
       Name,
       Age,
       Course,
       Math,
       Physics,
       Computer,
       Birthday
FROM Student
WHERE Course = 'MCA';