-- -- Create Customers table
-- CREATE TABLE my_new_database.Customers (
--     id INT PRIMARY KEY,
--     name VARCHAR(100)
-- );

-- -- Insert values into Customers table
-- INSERT INTO my_new_database.Customers (id, name) VALUES
-- (1, 'Joe'),
-- (2, 'Henry'),
-- (3, 'Sam'),
-- (4, 'Max');

-- -- Create Orders table
-- CREATE TABLE my_new_database.arektaOrders (
--     id INT PRIMARY KEY,
--     customerId INT,
--     FOREIGN KEY (customerId) REFERENCES Customers(id)
-- );

-- -- Insert values into Orders table
-- INSERT INTO my_new_database.arektaOrders (id, customerId) VALUES
-- (1, 3),
-- (2, 1);

-- pandas
-- Approach 1: Filtering Data with Exclusion Criteria
-- Algorithm
-- The criterion for determining whether a customer ever orders is: if a customer ID does not appear in the orders table, it means they have never placed an order.

-- Therefore, we can use row filtering to remove customer IDs that do not meet the criteria.

-- In Pandas:

-- isin(values) is used to filter and select rows based on whether their values are present in a given set values.
-- ~ represents logical negation.
-- Therefore, ~isin(values) selects rows if their values are NOT present in values.

-- # Select the rows which `id` is not present in orders['customerId'].
-- df = customers[~customers['id'].isin(orders['customerId'])]
-- We can obtain the following table:

-- id	name
-- 2	Henry
-- 4	Max

-- Note that the requirement is to only return the names that meet the criteria, and the column name should be renamed as Customers, therefore.

-- # Build a dataframe that only contains the column `name` 
-- # and rename the column `name` as `Customers`.
-- df = df[['name']].rename(columns={'name': 'Customers'})
-- Here is the resulting table:

-- Customers
-- Henry
-- Max

-- Implementation
-- import pandas as pd

-- def find_customers(customers: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
--     # Select the rows which `id` is not present in orders['customerId'].
--     df = customers[~customers['id'].isin(orders['customerId'])]

--     # Build a dataframe that only contains the column `name` 
--     # and rename the column `name` as `Customers`.
--     df = df[['name']].rename(columns={'name': 'Customers'})
--     return df

-- Approach 2: Left Join on customers
-- Algorithm
-- The idea is to join the table customers with the table orders based on the common customer ID (the column id in customers and the column customerId in orders).

-- By performing a left join and selecting the records where the customerId is null, we can identify customers who do not make an order.

-- We use a left join on customers because we want to include all customers from it, regardless of whether they place an order or not.
-- Therefore, by using left join, we can preserve all the rows from the left table (customers) and match them with corresponding rows from the right table (orders) based on id and customerID, separately.

-- df = customers.merge(orders, left_on='id', right_on='customerId', how='left')
-- The table appears as follows:

-- id	name	id	customerId
-- 1	Joe	2	1
-- 2	Henry	null	null
-- 3	Sam	1	3
-- 4	Max	    null	null

-- The next step is filtering the joined table by selecting the rows where the customerId is null, which will give us the customers who do not have any orders.

-- df = df[result['customerId'].isna()]
-- The table appears as follows:

-- id	name	id	customerId
-- 2	Henry	null	null
-- 4	Max	    null	null

-- Similarly, we only return the names of the rows that meet the criteria, and rename the column name as Customers.

-- df = df[['name']].rename(columns={'name': 'Customers'})
-- Here is the resulting table:

-- Customers
-- Henry
-- Max

-- In summary, the complete answer is as follows:

-- Implementation

-- database
-- Approach 1: Filtering Data with Exclusion Criteria
-- Algorithm
-- The criterion for determining whether a customer ever orders is: if a customer ID does not appear in the orders table, it means they have never placed an order.

-- Therefore, we can use row filtering to remove customer IDs that do not meet the criteria using NOT IN clause.

-- select *
-- from customers
-- where customers.id not in
-- (
--     select customerid from orders
-- );
-- We can obtain the following table:

-- id	name
-- 2	Henry
-- 4	Max

-- Note that the requirement is to only return the names that meet the criteria, and the column name should be renamed as Customers, therefore, the complete answer is as follows:

-- Implementation
-- select customers.name as 'Customers'
-- from customers
-- where customers.id not in
-- (
--     select customerid from orders
-- );

-- Approach 2: Left Join on customers
-- Algorithm
-- The idea is to join the table customers with the table orders based on the common customer ID (the column id in customers and the column customerId in orders).

-- By performing a left join and selecting the records where the customerId is null, we can identify customers who do not make an order.

-- We use a left join on customers because we want to include all customers from it, regardless of whether they place an order or not.
-- Therefore, by using left join, we can preserve all the rows from the left table (customers) and match them with corresponding rows from the right table (orders) based on id and customerID, separately.

-- SELECT * 
-- FROM Customers c
-- LEFT JOIN Orders o
-- ON c.Id = o.CustomerId
-- The table appears as follows:

-- id	name	id	customerId
-- 1	Joe	2	1
-- 2	Henry	null	null
-- 3	Sam	1	3
-- 4	Max	    null	null

-- The next step is filtering the joined table by selecting the rows where the customerId is null, which will give us the customers who do not have any orders.

-- SELECT * 
-- FROM Customers
-- LEFT JOIN Orders ON Customers.Id = Orders.CustomerId
-- WHERE Orders.CustomerId IS NULL
-- The table appears as follows:

-- id	name	id	customerId
-- 2	Henry	null	null
-- 4	Max	    null	null

-- Similarly, we only return the names of the rows that meet the criteria, and rename the column name as Customers. The complete answer is as follows:

-- Implementation
SELECT name AS 'Customers'
FROM my_new_database.Customers
LEFT JOIN my_new_database.arektaOrders ON Customers.Id = arektaOrders.CustomerId
WHERE arektaOrders.CustomerId IS NULL