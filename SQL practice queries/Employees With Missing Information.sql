-- USE my_new_database;

-- Create Employees table
-- CREATE TABLE newEmployees (
--     employee_id INT PRIMARY KEY,
--     name VARCHAR(255)
-- );

-- Insert values into Employees table
-- INSERT INTO newEmployees (employee_id, name) VALUES
-- (2, 'Crew'),
-- (4, 'Haven'),
-- (5, 'Kristian');

-- Create Salaries table
-- CREATE TABLE Salaries (
--     employee_id INT PRIMARY KEY,
--     salary INT
-- );

-- Insert values into Salaries table
-- INSERT INTO Salaries (employee_id, salary) VALUES
-- (5, 76071),
-- (1, 22517),
-- (4, 63539);

-- Select employee IDs with missing information
SELECT T.employee_id
FROM  
  (SELECT * FROM my_new_database.newEmployees LEFT JOIN Salaries USING(employee_id)
   UNION 
   SELECT * FROM my_new_database.newEmployees RIGHT JOIN Salaries USING(employee_id))
AS T
WHERE T.salary IS NULL OR T.name IS NULL
ORDER BY employee_id;