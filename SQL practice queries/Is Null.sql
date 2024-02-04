-- CREATE TABLE my_new_database.Customer (
--     id INT PRIMARY KEY,
--     name VARCHAR(255),
--     referee_id int
-- )

-- INSERT INTO my_new_database.customer(id, name, referee_id) 
-- VALUES
--     (1, 'Will', NULL),
--     (2, 'Jane', NULL),
--     (3, 'Alex', 2),
--     (4, 'Bill', NULL),
--     (5, 'Zack', 1),
--     (6, 'Mark', 2);

-- Find the names of the customer that are not referred by the customer with id = 2.

SELECT name 
FROM my_new_database.customer
WHERE referee_id <> 2
OR referee_id is NULL


-- Approach: Using <>(!=) and IS NULL [Accepted]
-- Intuition

-- Some people come out the following solution by intuition.

-- SELECT name FROM customer WHERE referee_Id <> 2;
-- However, this query will only return one result:Zack although there are 4 customers not referred by Jane (including Jane herself). All the customers who were referred by nobody at all (NULL value in the referee_id column) don’t show up. But why?

-- Algorithm

-- MySQL uses three-valued logic -- TRUE, FALSE and UNKNOWN. Anything compared to NULL evaluates to the third value: UNKNOWN. That “anything” includes NULL itself! That’s why MySQL provides the IS NULL and IS NOT NULL operators to specifically check for NULL.

-- Thus, one more condition 'referee_id IS NULL' should be added to the WHERE clause as below.