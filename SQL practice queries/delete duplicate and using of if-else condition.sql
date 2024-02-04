-- CREATE TABLE my_new_database.Employees(
--     employee_id INT,
--     name VARCHAR(50),
--     salary int
-- )

-- INSERT INTO my_new_database.employees(employee_id,name,salary)
-- VALUES
--     (2,'Meir',3000),
--     (3, 'Michael', 3800),
--     (7, 'Addilyn', 7400),
--     (8, 'Juan', 6100),
--     (9, 'Kannon', 7700);

-- INSERT INTO my_new_database.employees(employee_id,name,salary)
-- VALUES
--     (100,'abir',3000000);

-- SELECT * from my_new_database.employees;

-- DELETE FROM my_new_database.employees
-- WHERE (employee_id, name, salary) IN (
--     SELECT employee_id, name, salary
--     FROM (
--         SELECT 
--             employee_id,
--             name,
--             salary,
--             ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY (SELECT NULL)) AS RowNum
--         FROM my_new_database.employees
--     ) AS DuplicateCTE
--     WHERE RowNum > 1
-- );

-- Algorithm
-- Let's take a look at the bonus calculation conditions: 
-- the bonus is equal to the salary only when the employee's ID is odd 
-- and his name does not start with the letter M. Otherwise, the bonus is set to 0. This can be represented as a straightforward if-else statement:
-- bonus = salary if (id % 2 and not name.startwith('M')) else 0

-- How do we implement this expression to each row of the DataFrame employee?

-- To accomplish this task, we could use a loop to iterate through the DataFrame rows one by one. However, Python offers a more elegant and efficient approach known as "Vectorization" using the apply() method. Vectorization takes advantage of the underlying optimizations in Pandas and enables us to apply operations to entire columns or rows at once, leading to faster and more concise code.

-- In this scenario, the use of apply() allows us to avoid writing explicit loops and handle the operations more concisely. By defining a custom function that calculates the bonus based on the conditions and utilizing apply() with the axis=1 argument, we can effortlessly process each row and compute the corresponding bonus. The custom function is outlined as follows:

-- lambda x: x['salary'] if x['employee_id'] % 2 and not x['name'].startswith('M') else 0

-- It implements our if-else logic statement by checking the conditions based on the employee's ID and the first letter of their name and returning the corresponding bonus value. We set the first parameter of apply() to this lambda function and set the parameter axis to 1, indicating that the function should be applied along the row.

-- employees['bonus'] = employees.apply(
--     lambda x: x['salary'] if x['employee_id'] % 2 and not x['name'].startswith('M') else 0, 
--     axis=1
-- )

-- The above code creates a new column bonus

-- Next, we select the required columns employee_id and bonus and sort the DataFrame df in ascending order of employee_id.

-- df = employees[['employee_id', 'bonus']].sort_values('employee_id')

-- python:
-- import pandas as pd

-- def calculate_special_bonus(employees: pd.DataFrame) -> pd.DataFrame:
--     employees['bonus'] = employees.apply(
--         lambda x: x['salary'] if x['employee_id'] % 2 and not x['name'].startswith('M') else 0, 
--         axis=1
--     )

--     df = employees[['employee_id', 'bonus']].sort_values('employee_id')
--     return df

-- database
-- Approach: If Statement
-- Algorithm
-- In SQL, we use the conditional function IF to perform conditional checks and return different values based on the condition's result. The syntax of the IF function is as follows:

-- IF(condition, value_if_true, value_if_false)
-- The condition consists of two parts separated by the keyword AND:

-- employee_id % 2 = 1: this condition checks whether employee_id is an odd number.
-- name NOT REGEXP '^M': we use the keyword REGEXP for regular expression pattern matching, which checks whether the name does not start with the letter "M" (^M represents a regular expression pattern that matches any name not starting with "M").
-- Therefore, the IF function in our case is as follows:
-- IF(employee_id % 2 = 1 AND name NOT REGEXP '^M', salary, 0)

-- The AS clause is used to give an alias bonus to the calculated column above. If both conditions are met, the bonus will be set to the employee's salary. Otherwise, it will be set to 0. Then the result set is sorted based on the employee_id column in ascending order. The complete code is as follows:

-- Implementation

SELECT 
    employee_id,
    IF(employee_id % 2 = 1 AND name NOT REGEXP '^M', salary, 0) AS bonus 
FROM 
    my_new_database.employees 
ORDER BY 
    employee_id

