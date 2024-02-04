-- CREATE TABLE my_new_database.biggestOrders(
--     order_number int,
--     customer_number int,
--     PRIMARY KEY(order_number)
-- );

-- INSERT INTO my_new_database.biggestorders(order_number,customer_number)
-- VALUES
--     (1,1),
--     (2,2),
--     (3,3),
--     (4,3);

-- Write a solution to find the customer_number for the customer who has placed the largest number of orders.

-- pandas
-- Approach: Group By
-- Algorithm
-- We are asked to find the customer who placed the largest number of orders, which involves counting the number of orders per customer. This can be done by grouping the orders by each unique customer. Hence, we group the DataFrame orders by the column customer_number and apply the size() method to calculate the number of occurrences of each unique value in customer_number, which represents the number of orders placed by each customer.

-- reset_index(name='count') is used to assign a new name count to the resulting column that represents the count of orders. This step ensures that the resulting DataFrame df has two columns: customer_number and count.

-- df = orders.groupby('customer_number').size().reset_index(name='count')
-- We will have the following DataFrame df:

-- customer_number	count
-- 1	1
-- 2	1
-- 3	2

-- Once we have the count of orders per customer, we can sort the DataFrame by count in descending order.

-- df.sort_values(by='count', ascending = False, inplace=True)
-- customer_number	count
-- 3	2
-- 1	1
-- 2	1

-- Next, we return the customer_number in the first row, which denotes the customer placing the maximum orders. The complete code is as follows:

-- Implementation

-- We can obtain the following DataFrame:
-- import pandas as pd

-- def largest_orders(orders: pd.DataFrame) -> pd.DataFrame:
--     # If orders is empty, return an empty DataFrame.
--     if orders.empty:
--         return pd.DataFrame({'customer_number': []})

--     df = orders.groupby('customer_number').size().reset_index(name='count')
--     df.sort_values(by='count', ascending = False, inplace=True)
--     return df[['customer_number']][0:1]
-- customer_number
-- 3

-- database
-- Approach: Group By
-- Algorithm
-- First, we can select the customer_number and the according count of orders using GROUP BY.

-- SELECT
--     customer_number, COUNT(*)
-- FROM
--     orders
-- GROUP BY customer_number
-- customer_number	COUNT(*)
-- 1	1
-- 2	1
-- 3	2
-- Then, the customer_number of first record is the result after sorting them by order count descending.

-- customer_number	COUNT(*)
-- 3	2
-- In MySQL, the LIMIT clause can be used to constrain the number of rows returned by the SELECT statement. It takes one or two nonnegative numeric arguments, the first of which specifies the offset of the first row to return, and the second specifies the maximum number of rows to return. The offset of the initial row is 0 (not 1).

-- It can be used with only one argument, which specifies the number of rows to return from the beginning of the result set. So LIMIT 1 will return the first record.

-- Implementation
SELECT
    customer_number
FROM
    my_new_database.biggestorders
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1
;