-- CREATE TABLE my_new_database.Salary(
--     id INT PRIMARY KEY,
--     name VARCHAR(50),
--     sex ENUM('m','f'),
--     Salary int 
-- );

-- INSERT INTO my_new_database.salary(id, name, sex, salary)
-- VALUES 
--     (1, 'A', 'm', 2500),
--     (2, 'B', 'f', 1500),
--     (3, 'C', 'm', 5500),
--     (4, 'D', 'f', 500);

-- Write a solution to swap all 
-- 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) 
-- with a single update statement and no intermediate temporary tables.

-- Approach: Using UPDATE and CASE...WHEN [Accepted]
-- Algorithm

-- To dynamically set a value to a column, we can use UPDATE statement together when CASE...WHEN... flow control statement.

-- MySQL

UPDATE my_new_database.salary
SET
    sex = CASE sex
        WHEN 'm' THEN 'f'
        ELSE 'm'
    END;

-- in one line :
-- update salary set sex = IF (sex = "m", "f", "m");